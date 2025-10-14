import 'dart:convert';
import 'dart:io';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'fhir_media.freezed.dart';
part 'fhir_media.g.dart';

@freezed
class FhirMedia with _$FhirMedia {
  const factory FhirMedia({
    @Default('Media') String resourceType,
    String? id,
    @Default('completed') String status,
    required FhirReference subject,
    FhirReference? encounter,
    required FhirContent content,
    @Default('image') String type,
    String? createdDateTime,
    List<FhirIdentifier>? identifier,
  }) = _FhirMedia;

  factory FhirMedia.fromJson(Map<String, dynamic> json) =>
      _$FhirMediaFromJson(json);
}

@freezed
class FhirReference with _$FhirReference {
  const factory FhirReference({
    required String reference,
    String? display,
  }) = _FhirReference;

  factory FhirReference.fromJson(Map<String, dynamic> json) =>
      _$FhirReferenceFromJson(json);
}

@freezed
class FhirContent with _$FhirContent {
  const factory FhirContent({
    required String contentType,
    String? data, // Base64 encoded data
    String? url, // Alternative: URL reference
    String? title,
    int? size,
  }) = _FhirContent;

  factory FhirContent.fromJson(Map<String, dynamic> json) =>
      _$FhirContentFromJson(json);
}

@freezed
class FhirIdentifier with _$FhirIdentifier {
  const factory FhirIdentifier({
    String? system,
    required String value,
    String? use,
  }) = _FhirIdentifier;

  factory FhirIdentifier.fromJson(Map<String, dynamic> json) =>
      _$FhirIdentifierFromJson(json);
}

// Helper class for creating FHIR Media resources from scanned documents
class FhirMediaFactory {
  static Future<FhirMedia> createFromImage({
    required String imagePath,
    required String patientId,
    String? encounterId,
    String? title,
  }) async {
    final file = File(imagePath);
    final bytes = await file.readAsBytes();
    final base64Data = base64Encode(bytes);
    final contentType = _getContentType(imagePath);
    final timestamp = DateTime.now().toIso8601String();

    return FhirMedia(
      id: _generateId(),
      status: 'completed',
      type: 'image',
      subject: FhirReference(
        reference: 'Patient/$patientId',
        display: 'Patient $patientId',
      ),
      encounter: encounterId != null
          ? FhirReference(
              reference: 'Encounter/$encounterId',
              display: 'Encounter $encounterId',
            )
          : null,
      content: FhirContent(
        contentType: contentType,
        data: base64Data,
        title: title ?? 'Scanned Document',
        size: bytes.length,
      ),
      createdDateTime: timestamp,
      identifier: [
        FhirIdentifier(
          system: 'http://health-wallet.app/media-id',
          value: _generateId(),
          use: 'usual',
        ),
      ],
    );
  }

  static String _getContentType(String filePath) {
    final extension = filePath.toLowerCase().split('.').last;
    switch (extension) {
      case 'jpg':
      case 'jpeg':
        return 'image/jpeg';
      case 'png':
        return 'image/png';
      case 'pdf':
        return 'application/pdf';
      default:
        return 'image/jpeg';
    }
  }

  static String _generateId() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }
}
