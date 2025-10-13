// health_wallet/features/document_scanner/domain/services/fhir_media_service.dart

import 'dart:convert';
import 'dart:io';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:health_wallet/features/scan/domain/models/fhir_media.dart';

@injectable
class FhirMediaService {
  static const String _fhirMediaDirectory = 'fhir_media';

  Future<List<FhirMedia>> saveScannedImagesAsFhirMedia({
    required List<String> imagePaths,
    required String patientId,
    String? encounterId,
    String? title,
  }) async {
    try {
      final List<FhirMedia> mediaResources = [];

      for (int i = 0; i < imagePaths.length; i++) {
        final imagePath = imagePaths[i];
        final documentTitle = title ?? 'Scanned Document ${i + 1}';

        final media = await FhirMediaFactory.createFromImage(
          imagePath: imagePath,
          patientId: patientId,
          encounterId: encounterId,
          title: documentTitle,
        );

        // Save the FHIR Media resource to local storage
        await _saveFhirMediaToStorage(media);

        mediaResources.add(media);
      }

      return mediaResources;
    } catch (e) {
      throw Exception('Failed to create FHIR Media resources: $e');
    }
  }

  Future<void> _saveFhirMediaToStorage(FhirMedia media) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final fhirDir = Directory(path.join(directory.path, _fhirMediaDirectory));

      if (!await fhirDir.exists()) {
        await fhirDir.create(recursive: true);
      }

      final fileName = 'media_${media.id}.json';
      final filePath = path.join(fhirDir.path, fileName);
      final file = File(filePath);

      final jsonString = jsonEncode(media.toJson());
      await file.writeAsString(jsonString);
    } catch (e) {
      throw e;
    }
  }

  Future<List<FhirMedia>> getSavedFhirMedia() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final fhirDir = Directory(path.join(directory.path, _fhirMediaDirectory));

      if (!await fhirDir.exists()) {
        return [];
      }

      final files = await fhirDir
          .list()
          .where((entity) => entity is File && entity.path.endsWith('.json'))
          .cast<File>()
          .toList();

      final List<FhirMedia> mediaResources = [];

      for (final file in files) {
        try {
          final jsonString = await file.readAsString();
          final jsonData = jsonDecode(jsonString) as Map<String, dynamic>;
          final media = FhirMedia.fromJson(jsonData);
          mediaResources.add(media);
        } catch (e) {}
      }

      // Sort by creation date (newest first)
      mediaResources.sort((a, b) {
        final aTime = a.createdDateTime ?? '';
        final bTime = b.createdDateTime ?? '';
        return bTime.compareTo(aTime);
      });

      return mediaResources;
    } catch (e) {
      return [];
    }
  }

  Future<List<FhirMedia>> getFhirMediaForEncounter(String encounterId) async {
    final allMedia = await getSavedFhirMedia();
    return allMedia
        .where(
            (media) => media.encounter?.reference == 'Encounter/$encounterId')
        .toList();
  }

  Future<List<FhirMedia>> getFhirMediaForPatient(String patientId) async {
    final allMedia = await getSavedFhirMedia();
    return allMedia
        .where((media) => media.subject.reference == 'Patient/$patientId')
        .toList();
  }

  Future<void> deleteFhirMedia(String mediaId) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final filePath =
          path.join(directory.path, _fhirMediaDirectory, 'media_$mediaId.json');
      final file = File(filePath);

      if (await file.exists()) {
        await file.delete();
      }
    } catch (e) {
      throw Exception('Failed to delete FHIR Media: $e');
    }
  }

  Future<void> attachFhirMediaToEncounter({
    required String mediaId,
    required String encounterId,
  }) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final filePath =
          path.join(directory.path, _fhirMediaDirectory, 'media_$mediaId.json');
      final file = File(filePath);

      if (!await file.exists()) {
        throw Exception('FHIR Media not found: $mediaId');
      }

      final jsonString = await file.readAsString();
      final jsonData = jsonDecode(jsonString) as Map<String, dynamic>;
      final media = FhirMedia.fromJson(jsonData);

      final updatedMedia = media.copyWith(
        encounter: FhirReference(
          reference: 'Encounter/$encounterId',
          display: 'Encounter $encounterId',
        ),
      );

      final updatedJsonString = jsonEncode(updatedMedia.toJson());
      await file.writeAsString(updatedJsonString);
    } catch (e) {
      throw Exception('Failed to attach FHIR Media to encounter: $e');
    }
  }
}
