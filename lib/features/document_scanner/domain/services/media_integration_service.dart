// health_wallet/features/document_scanner/domain/services/media_integration_service.dart

import 'dart:convert';
import 'dart:io';
import 'package:drift/drift.dart';
import 'package:health_wallet/features/document_scanner/presentation/services/pdf_generation_service.dart';
import 'package:health_wallet/features/sync/data/data_source/local/tables/fhir_resource_table.dart';
import 'package:injectable/injectable.dart';
import 'package:fhir_r4/fhir_r4.dart' as fhir_r4;
import 'package:health_wallet/core/data/local/app_database.dart';
import 'package:health_wallet/features/document_scanner/domain/services/fhir_media_service.dart';

@injectable
class MediaIntegrationService {
  final AppDatabase _database;
  final FhirMediaService _fhirMediaService;
  final PdfGenerationService _pdfGenerationService;

  MediaIntegrationService(this._database, this._fhirMediaService, this._pdfGenerationService,);

  Future<List<String>> saveGroupedDocumentsAsFhirRecords({
    required List<String> scannedImages,
    required List<String> importedImages,
    required List<String> importedPdfs,
    required String patientId,
    String? encounterId,
    String? sourceId,
    String? title,
  }) async {
    try {
      final List<String> savedResourceIds = [];
      
      // Group and convert documents to PDFs
      final documentGroups = await _pdfGenerationService.groupAndConvertDocuments(
        scannedImages: scannedImages,
        importedImages: importedImages,
        importedPdfs: importedPdfs,
      );
      
      // Create FHIR Media resource for each group
      for (int i = 0; i < documentGroups.length; i++) {
        final group = documentGroups[i];
        
        final fhirMedia = await _createFhirR4MediaFromPdf(
          pdfPath: group.pdfPath,
          patientId: patientId,
          encounterId: encounterId,
          title: group.title,
        );
        
        final resourceId = await _saveFhirMediaToDatabase(
          fhirMedia: fhirMedia,
          sourceId: sourceId ?? 'scanner-app',
          title: group.title,
        );
        
        savedResourceIds.add(resourceId);
      }
      
      return savedResourceIds;
      
    } catch (e) {
      throw Exception('Failed to create grouped FHIR Media records: $e');
    }
  }

    Future<fhir_r4.Media> _createFhirR4MediaFromPdf({
    required String pdfPath,
    required String patientId,
    String? encounterId,
    required String title,
  }) async {
    final file = File(pdfPath);
    final bytes = await file.readAsBytes();
    final base64Data = base64Encode(bytes);
    final timestamp = DateTime.now();
    
    return fhir_r4.Media(
      id: fhir_r4.FhirString(_generateId()),
      status: fhir_r4.EventStatus.completed,
      type: fhir_r4.CodeableConcept(
        coding: [
          fhir_r4.Coding(
            system: fhir_r4.FhirUri('http://terminology.hl7.org/CodeSystem/media-type'),
            code: fhir_r4.FhirCode('document'),
            display: fhir_r4.FhirString('Document'),
          ),
        ],
        text: fhir_r4.FhirString('Medical Document'),
      ),
      subject: fhir_r4.Reference(
        reference: fhir_r4.FhirString('Patient/$patientId'),
        display: fhir_r4.FhirString('Patient $patientId'),
      ),
      encounter: encounterId != null 
        ? fhir_r4.Reference(
            reference: fhir_r4.FhirString('Encounter/$encounterId'),
            display: fhir_r4.FhirString('Encounter $encounterId'),
          )
        : null,
      createdX: fhir_r4.FhirDateTime.fromString(timestamp.toIso8601String()),
      content: fhir_r4.Attachment(
        contentType: fhir_r4.FhirCode('application/pdf'),
        data: fhir_r4.FhirBase64Binary(base64Data),
        title: fhir_r4.FhirString(title),
        size: fhir_r4.FhirUnsignedInt(bytes.length.toString()),
      ),
      identifier: [
        fhir_r4.Identifier(
          system: fhir_r4.FhirUri('http://health-wallet.app/media-id'),
          value: fhir_r4.FhirString(_generateId()),
          use: fhir_r4.IdentifierUse.usual,
        ),
      ],
    );
  }

  /// Create a FHIR R4 Media resource from an image file
  Future<fhir_r4.Media> _createFhirR4Media({
    required String imagePath,
    required String patientId,
    String? encounterId,
    required String title,
  }) async {
    final file = File(imagePath);
    final bytes = await file.readAsBytes();
    final base64Data = base64Encode(bytes);
    final contentType = _getContentType(imagePath);
    final timestamp = DateTime.now();

    return fhir_r4.Media(
      id: fhir_r4.FhirString(_generateId()),
      status: fhir_r4.EventStatus.completed,
      type: fhir_r4.CodeableConcept(
        coding: [
          fhir_r4.Coding(
            system: fhir_r4.FhirUri(
                'http://terminology.hl7.org/CodeSystem/media-type'),
            code: fhir_r4.FhirCode('image'),
            display: fhir_r4.FhirString('Image'),
          ),
        ],
        text: fhir_r4.FhirString('Scanned Document Image'),
      ),
      subject: fhir_r4.Reference(
        reference: fhir_r4.FhirString('Patient/$patientId'),
        display: fhir_r4.FhirString('Patient $patientId'),
      ),
      encounter: encounterId != null
          ? fhir_r4.Reference(
              reference: fhir_r4.FhirString('Encounter/$encounterId'),
              display: fhir_r4.FhirString('Encounter $encounterId'),
            )
          : null,
      createdX: fhir_r4.FhirDateTime.fromString(timestamp.toIso8601String()),
      content: fhir_r4.Attachment(
        contentType: fhir_r4.FhirCode(contentType),
        data: fhir_r4.FhirBase64Binary(base64Data),
        title: fhir_r4.FhirString(title),
        size: fhir_r4.FhirUnsignedInt(bytes.length.toString()),
      ),
      identifier: [
        fhir_r4.Identifier(
          system: fhir_r4.FhirUri('http://health-wallet.app/media-id'),
          value: fhir_r4.FhirString(_generateId()),
          use: fhir_r4.IdentifierUse.usual,
        ),
      ],
    );
  }

  /// Save FHIR Media resource to the local database
  Future<String> _saveFhirMediaToDatabase({
    required fhir_r4.Media fhirMedia,
    required String sourceId,
    required String title,
  }) async {
    final resourceJson = fhirMedia.toJson();
    final resourceId = fhirMedia.id!.valueString!;

    final dto = FhirResourceCompanion.insert(
      id: '${sourceId}_$resourceId',
      sourceId: Value(sourceId),
      resourceId: Value(resourceId),
      resourceType: Value('Media'),
      title: Value(title),
      date: Value(_extractDateFromMedia(fhirMedia)),
      resourceRaw: jsonEncode(resourceJson), // Add this required field
    );

    await _database.into(_database.fhirResource).insertOnConflictUpdate(dto);

    return resourceId;
  }

  /// Extract date from FHIR Media resource
  DateTime? _extractDateFromMedia(fhir_r4.Media media) {
    if (media.createdX != null) {
      // Handle different types of createdX
      if (media.createdX is fhir_r4.FhirDateTime) {
        try {
          final dateTime = media.createdX as fhir_r4.FhirDateTime;
          return DateTime.parse(dateTime.valueString!);
        } catch (e) {
          return null;
        }
      }
      // Add other cases if needed (like Period)
    }
    return DateTime.now(); // Fallback to current time
  }

  /// Get all Media resources from database
  Future<List<FhirResourceLocalDto>> getAllMediaResources({
    String? sourceId,
  }) async {
    var query = (_database.select(_database.fhirResource)
      ..where((tbl) => tbl.resourceType.equals('Media')));

    if (sourceId != null) {
      query = query..where((tbl) => tbl.sourceId.equals(sourceId));
    }

    return query.get();
  }

  /// Get Media resources for a specific encounter
  Future<List<FhirResourceLocalDto>> getMediaResourcesForEncounter({
    required String encounterId,
    String? sourceId,
  }) async {
    final allMedia = await getAllMediaResources(sourceId: sourceId);

    return allMedia.where((media) {
      try {
        final resourceJson = jsonDecode(media.resourceRaw);
        final encounter = resourceJson['encounter'];
        if (encounter != null && encounter['reference'] != null) {
          return encounter['reference'] == 'Encounter/$encounterId';
        }
        return false;
      } catch (e) {
        return false;
      }
    }).toList();
  }

  /// Update Media resource to reference an encounter
  Future<void> linkMediaToEncounter({
    required String mediaResourceId,
    required String encounterId,
    String? sourceId,
  }) async {
    try {
      final mediaQuery = _database.select(_database.fhirResource)
        ..where((tbl) =>
            tbl.id.equals('${sourceId ?? 'scanner-app'}_$mediaResourceId'));

      final media = await mediaQuery.getSingleOrNull();

      if (media == null) {
        throw Exception('Media resource not found');
      }

      final resourceJson =
          jsonDecode(media.resourceRaw) as Map<String, dynamic>;

      // Add encounter reference
      resourceJson['encounter'] = {
        'reference': 'Encounter/$encounterId',
        'display': 'Encounter $encounterId',
      };

      final updateCompanion = FhirResourceCompanion(
        id: Value(media.id),
        resourceRaw: Value(jsonEncode(resourceJson)),
      );

      await (_database.update(_database.fhirResource)
            ..where((tbl) => tbl.id.equals(media.id)))
          .write(updateCompanion);
    } catch (e) {
      throw Exception('Failed to link Media to Encounter: $e');
    }
  }

  String _getContentType(String filePath) {
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

  String _generateId() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }
}
