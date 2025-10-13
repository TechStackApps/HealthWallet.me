// health_wallet/features/document_scanner/domain/services/media_integration_service.dart

import 'dart:convert';
import 'dart:io';
import 'package:drift/drift.dart';
import 'package:health_wallet/features/scan/presentation/services/pdf_generation_service.dart';
import 'package:injectable/injectable.dart';
import 'package:fhir_r4/fhir_r4.dart' as fhir_r4;
import 'package:health_wallet/core/data/local/app_database.dart';
import 'package:health_wallet/core/utils/fhir_reference_utils.dart';
import 'package:health_wallet/core/utils/logger.dart';
import 'package:health_wallet/features/records/domain/repository/records_repository.dart';

@injectable
class MediaIntegrationService {
  final AppDatabase _database;
  final PdfGenerationService _pdfGenerationService;
  final RecordsRepository _recordsRepository;

  MediaIntegrationService(
      this._database, this._pdfGenerationService, this._recordsRepository);

  Future<List<String>> saveGroupedDocumentsAsFhirRecords({
    required List<String> scannedImages,
    required List<String> importedImages,
    required List<String> importedPdfs,
    required String patientId,
    String? encounterId,
    required String sourceId, // Now required - must be a valid wallet sourceId
    String? title,
  }) async {
    try {
      logger.d(
          '🔍 MediaIntegrationService.saveGroupedDocumentsAsFhirRecords called');
      logger.d('  - patientId: $patientId');
      logger.d('  - encounterId: $encounterId');
      logger.d('  - sourceId: $sourceId');
      logger.d('  - title: $title');
      logger.d('  - scannedImages: ${scannedImages.length}');
      logger.d('  - importedImages: ${importedImages.length}');
      logger.d('  - importedPdfs: ${importedPdfs.length}');

      final List<String> savedResourceIds = [];

      // Get or create patient record
      final patientRecord = await _recordsRepository.getOrCreatePatientRecord(
        patientId: patientId,
        sourceId: sourceId,
      );

      logger.d('📋 Patient record: ${patientRecord.id}');

      // Group and convert documents to PDFs
      final documentGroups =
          await _pdfGenerationService.groupAndConvertDocuments(
        scannedImages: scannedImages,
        importedImages: importedImages,
        importedPdfs: importedPdfs,
      );

      logger.d('📄 Document groups created: ${documentGroups.length}');

      // Create FHIR Media resource and FHIR-compliant attachment for each group
      for (int i = 0; i < documentGroups.length; i++) {
        final group = documentGroups[i];
        logger.d('📄 Processing group $i: ${group.title}');

        // Create FHIR Media resource
        final fhirMedia = await _createFhirR4MediaFromPdf(
          pdfPath: group.pdfPath,
          patientId: patientId,
          encounterId: encounterId,
          title: group.title,
        );

        logger.d('🏥 FHIR Media created for group $i');
        logger.d('  - Media ID: ${fhirMedia.id?.valueString}');
        logger.d(
            '  - Encounter reference: ${fhirMedia.encounter?.reference?.valueString}');
        logger.d(
            '  - Subject reference: ${fhirMedia.subject?.reference?.valueString}');

        // Save FHIR Media resource to database
        final resourceId = await _saveFhirMediaToDatabase(
          fhirMedia: fhirMedia,
          sourceId: sourceId, // Use the provided wallet sourceId
          title: group.title,
        );

        logger
            .d('💾 FHIR Media saved to database with resourceId: $resourceId');

        // Create FHIR-compliant attachment
        final attachmentId = await _recordsRepository.addRecordAttachment(
          patientRecordId: patientRecord.id,
          mediaId: fhirMedia.id!.valueString!,
          contentType: 'application/pdf',
          title: group.title,
          size: await File(group.pdfPath).length(),
          filePath: group.pdfPath,
          subjectReference: fhirMedia.subject?.reference?.valueString,
          encounterReference: fhirMedia.encounter?.reference?.valueString,
          mediaType: 'document',
          mediaSubtype: 'medical-document',
          identifierSystem: 'http://health-wallet.app/media-id',
          identifierValue:
              fhirMedia.identifier?.first.value?.valueString ?? _generateId(),
          identifierUse: 'usual',
        );

        logger.d('📎 FHIR-compliant attachment created with ID: $attachmentId');
        savedResourceIds.add(resourceId);
      }

      logger.d(
          '✅ All FHIR Media records and attachments saved successfully. Total: ${savedResourceIds.length}');

      return savedResourceIds;
    } catch (e) {
      logger.e('❌ Failed to create grouped FHIR Media records: $e');
      throw Exception('Failed to create grouped FHIR Media records: $e');
    }
  }

  Future<fhir_r4.Media> _createFhirR4MediaFromPdf({
    required String pdfPath,
    required String patientId,
    String? encounterId,
    required String title,
  }) async {
    logger.d('🏗️ Creating FHIR Media from PDF');
    logger.d('  - pdfPath: $pdfPath');
    logger.d('  - patientId: $patientId');
    logger.d('  - encounterId: $encounterId');
    logger.d('  - title: $title');

    final file = File(pdfPath);
    final bytes = await file.readAsBytes();
    final base64Data = base64Encode(bytes);
    final timestamp = DateTime.now();

    final mediaId = _generateId();
    logger.d('  - Generated Media ID: $mediaId');

    final encounterReference = encounterId != null
        ? fhir_r4.Reference(
            reference: fhir_r4.FhirString('Encounter/$encounterId'),
            display: fhir_r4.FhirString('Encounter $encounterId'),
          )
        : null;

    final subjectReference = fhir_r4.Reference(
      reference: fhir_r4.FhirString('Patient/$patientId'),
      display: fhir_r4.FhirString('Patient $patientId'),
    );

    logger.d(
        '  - Encounter reference: ${encounterReference?.reference?.valueString}');
    logger
        .d('  - Subject reference: ${subjectReference.reference?.valueString}');

    return fhir_r4.Media(
      id: fhir_r4.FhirString(mediaId),
      status: fhir_r4.EventStatus.completed,
      type: fhir_r4.CodeableConcept(
        coding: [
          fhir_r4.Coding(
            system: fhir_r4.FhirUri(
                'http://terminology.hl7.org/CodeSystem/media-type'),
            code: fhir_r4.FhirCode('document'),
            display: fhir_r4.FhirString('Document'),
          ),
        ],
        text: fhir_r4.FhirString('Medical Document'),
      ),
      subject: subjectReference,
      encounter: encounterReference,
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

  /// Save FHIR Media resource to the local database
  Future<String> _saveFhirMediaToDatabase({
    required fhir_r4.Media fhirMedia,
    required String sourceId,
    required String title,
  }) async {
    final resourceJson = fhirMedia.toJson();
    final resourceId = fhirMedia.id!.valueString!;

    // Extract encounterId and subjectId from FHIR references
    String? encounterId;
    String? subjectId;

    if (fhirMedia.encounter?.reference?.valueString != null) {
      encounterId = FhirReferenceUtils.extractReferenceId(
          fhirMedia.encounter!.reference!.valueString!);
    }

    if (fhirMedia.subject?.reference?.valueString != null) {
      subjectId = FhirReferenceUtils.extractReferenceId(
          fhirMedia.subject!.reference!.valueString!);
    }

    final dto = FhirResourceCompanion.insert(
      id: '${sourceId}_$resourceId',
      sourceId: Value(sourceId),
      resourceId: Value(resourceId),
      resourceType: Value('Media'),
      title: Value(title),
      date: Value(_extractDateFromMedia(fhirMedia)),
      resourceRaw: jsonEncode(resourceJson),
      encounterId:
          encounterId != null ? Value(encounterId) : const Value.absent(),
      subjectId: subjectId != null ? Value(subjectId) : const Value.absent(),
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

  String _generateId() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }
}
