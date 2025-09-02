import 'dart:convert';
import 'package:fhir_ips_export/fhir_ips_export.dart';
import 'package:fhir_r4/fhir_r4.dart' as fhir_r4;
import 'package:health_wallet/core/constants/blood_types.dart';
import 'package:health_wallet/core/data/local/app_database.dart';
import 'package:health_wallet/core/utils/logger.dart';
import 'package:health_wallet/features/records/data/datasource/fhir_resource_datasource.dart';
import 'package:health_wallet/features/records/domain/entity/entity.dart';
import 'package:health_wallet/features/records/domain/entity/record_attachment/record_attachment.dart';
import 'package:health_wallet/features/records/domain/entity/record_note/record_note.dart';
import 'package:health_wallet/features/records/domain/repository/records_repository.dart';
import 'package:health_wallet/features/sync/data/data_source/local/sync_local_data_source.dart';
import 'package:health_wallet/features/sync/data/dto/fhir_resource_dto.dart';
import 'package:health_wallet/features/sync/domain/services/demo_data_extractor.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter/services.dart';

@Injectable(as: RecordsRepository)
class RecordsRepositoryImpl implements RecordsRepository {
  final FhirResourceDatasource _datasource;
  final SyncLocalDataSource _syncLocalDataSource;

  RecordsRepositoryImpl(AppDatabase database, this._syncLocalDataSource)
      : _datasource = FhirResourceDatasource(database);

  @override
  Future<List<IFhirResource>> getResources({
    List<FhirType> resourceTypes = const [],
    String? sourceId,
    int limit = 20,
    int offset = 0,
  }) async {
    final localDtos = await _datasource.getResources(
      resourceTypes: resourceTypes.map((fhirType) => fhirType.name).toList(),
      sourceId: sourceId,
      limit: limit,
      offset: offset,
    );

    return localDtos.map(IFhirResource.fromLocalDto).toList();
  }

  /// Get related resources for an encounter
  @override
  Future<List<IFhirResource>> getRelatedResourcesForEncounter({
    required String encounterId,
    String? sourceId,
  }) async {
    final localDtos = await _datasource.getResourcesByEncounterId(
      encounterId: encounterId,
      sourceId: sourceId,
    );

    return localDtos.map(IFhirResource.fromLocalDto).toList();
  }

  @override
  Future<List<IFhirResource>> getRelatedResources({
    required IFhirResource resource,
  }) async {
    List<IFhirResource> resources = [];

    for (String? reference in resource.resourceReferences) {
      IFhirResource? resource = await resolveReference(reference!);
      if (resource == null) continue;

      resources.add(resource);
    }

    return resources;
  }

  @override
  Future<IFhirResource?> resolveReference(String reference) async {
    FhirResourceLocalDto? localDto =
        await _datasource.resolveReference(reference);
    if (localDto == null) return null;
    return IFhirResource.fromLocalDto(localDto);
  }

  @override
  Future<int> addRecordAttachment({
    required String resourceId,
    required String filePath,
  }) async {
    return _datasource.addRecordAttachment(
      resourceId: resourceId,
      filePath: filePath,
    );
  }

  @override
  Future<List<RecordAttachment>> getRecordAttachments(String resourceId) async {
    List<RecordAttachmentDto> dtos =
        await _datasource.getRecordAttachments(resourceId);

    return dtos.map(RecordAttachment.fromDto).toList();
  }

  @override
  Future<int> deleteRecordAttachment(RecordAttachment attachment) async {
    return _datasource.deleteRecordAttachment(attachment.id);
  }

  @override
  Future<int> addRecordNote({
    required String resourceId,
    required String content,
  }) async {
    return _datasource.addRecordNote(resourceId: resourceId, content: content);
  }

  @override
  Future<List<RecordNote>> getRecordNotes(String resourceId) async {
    List<RecordNoteDto> dtos = await _datasource.getRecordNotes(resourceId);

    return dtos.map(RecordNote.fromDto).toList();
  }

  @override
  Future<int> editRecordNote(RecordNote note) async {
    return _datasource.updateRecordNote(id: note.id, content: note.content);
  }

  @override
  Future<int> deleteRecordNote(RecordNote note) async {
    return _datasource.deleteRecordNote(note.id);
  }

  @override
  Future<void> loadDemoData() async {
    try {
      // Load demo data from assets
      final String demoDataJson =
          await rootBundle.loadString('assets/demo_data.json');
      final Map<String, dynamic> demoData = json.decode(demoDataJson);

      // Handle both FHIR Bundle format and simple resources format
      List<dynamic> resources;
      if (demoData['entry'] != null) {
        // FHIR Bundle format - extract resources from entry array
        final List<dynamic> entries = demoData['entry'] as List<dynamic>;
        resources = entries
            .map((entry) => entry['resource'])
            .where((resource) => resource != null)
            .toList();
      } else if (demoData['resources'] != null) {
        // Simple resources format
        resources = demoData['resources'] as List<dynamic>;
      } else {
        throw Exception(
            'Demo data file has invalid format: neither "entry" nor "resources" key found');
      }

      final processedResources = resources
          .map((resource) => FhirResourceDto.fromJson({
                'id': resource['id'],
                'source_id': 'demo_data',
                'source_resource_type': resource['resourceType'],
                'source_resource_id': resource['id'],
                'sort_title': DemoDataExtractor.extractTitle(resource),
                'sort_date': DemoDataExtractor.extractDate(resource),
                'resource_raw': resource,
                'change_type': 'created',
              }).populateEncounterIdFromRaw().populateSubjectIdFromRaw())
          .toList();

      _syncLocalDataSource.cacheFhirResources(processedResources);
    } catch (e, stackTrace) {
      logger.e('❌ Failed to load demo data: $e');
      logger.e('❌ Stack trace: $stackTrace');
      throw Exception('Failed to load demo data: $e');
    }
  }

  @override
  Future<void> clearDemoData() async {
    await _datasource.deleteResourcesBySourceId('demo_data');
  }

  @override
  Future<bool> hasDemoData() async {
    final resources = await _datasource.getResources(
        sourceId: 'demo_data', resourceTypes: [], limit: 1);
    return resources.isNotEmpty;
  }

  @override
  Future<List<IFhirResource>> getBloodTypeObservations({
    required String patientId,
    String? sourceId,
  }) async {
    List<IFhirResource> observations;

    if (sourceId != null && sourceId.isNotEmpty) {
      observations = await getResources(
        resourceTypes: [FhirType.Observation],
        sourceId: sourceId,
        limit: 100,
        offset: 0,
      );

      if (observations.isEmpty) {
        observations = await getResources(
          resourceTypes: [FhirType.Observation],
          limit: 100,
          offset: 0,
        );
      }
    } else {
      observations = await getResources(
        resourceTypes: [FhirType.Observation],
        limit: 100,
        offset: 0,
      );
    }

    final patients = await getResources(
      resourceTypes: [FhirType.Patient],
      limit: 100,
      offset: 0,
    );

    final patientList = patients.whereType<Patient>().toList();
    final targetPatient = patientList.firstWhere(
      (p) => p.id == patientId,
      orElse: () =>
          patientList.isNotEmpty ? patientList.first : patientList.first,
    );

    final bloodTypeObservations = observations.where((resource) {
      if (resource is! Observation) {
        return false;
      }

      final coding = resource.code?.coding;
      if (coding == null || coding.isEmpty) {
        return false;
      }

      bool hasBloodTypeCode = false;
      for (final code in coding) {
        if (code.code == null) continue;

        final loincCode = code.code.toString();

        if (loincCode == BloodTypes.aboLoincCode ||
            loincCode == BloodTypes.rhLoincCode ||
            loincCode == BloodTypes.combinedLoincCode) {
          hasBloodTypeCode = true;
          break;
        }
      }

      if (!hasBloodTypeCode) {
        return false;
      }

      final subject = resource.subject?.reference?.valueString;

      if (subject == null) {
        return false;
      }

      String subjectPatientId;
      if (subject.contains('/')) {
        subjectPatientId = subject.split('/').last;
      } else if (subject.startsWith('urn:uuid:')) {
        subjectPatientId = subject.replaceFirst('urn:uuid:', '');
      } else {
        subjectPatientId = subject;
      }

      final matches = subjectPatientId == targetPatient.resourceId ||
          subjectPatientId == targetPatient.id ||
          subject == targetPatient.resourceId ||
          subject == targetPatient.id;

      return matches;
    }).toList();

    return bloodTypeObservations;
  }

  @override
  Future<String> saveObservation(IFhirResource observation) async {
    if (observation is! Observation) {
      throw Exception('Expected Observation resource type');
    }

    final dto = FhirResourceLocalDto(
      id: observation.id,
      sourceId: observation.sourceId,
      resourceType: observation.fhirType.name,
      resourceId: observation.resourceId,
      title: observation.title,
      date: observation.date,
      resourceRaw: jsonEncode(observation.rawResource),
      encounterId: null,
      subjectId: null,
    );

    final id = await _datasource.insertResource(dto);
    return id.toString();
  }

  @override
  Future<void> updatePatient(IFhirResource patient) async {
    if (patient is! Patient) {
      throw Exception('Expected Patient resource type');
    }

    final dto = FhirResourceLocalDto(
      id: patient.id,
      sourceId: patient.sourceId,
      resourceType: patient.fhirType.name,
      resourceId: patient.resourceId,
      title: patient.title,
      date: patient.date,
      resourceRaw: jsonEncode(patient.rawResource),
      encounterId: null,
      subjectId: null,
    );

    await _datasource.insertResource(dto);
  }

  @override
  Future<List<IFhirResource>> searchResources({
    required String query,
    List<FhirType> resourceTypes = const [],
    String? sourceId,
    int limit = 50,
  }) async {
    final localDtos = await _datasource.searchResources(
      query: query,
      resourceTypes: resourceTypes.map((fhirType) => fhirType.name).toList(),
      sourceId: sourceId,
      limit: limit,
    );

    return localDtos.map(IFhirResource.fromLocalDto).toList();
  }

  @override
  Future<Uint8List> buildIpsExport({required String? sourceId}) async {
    List<FhirResourceLocalDto> resourceDtos = await _datasource.getResources(
      resourceTypes: [],
      sourceId: sourceId,
    );

    List<IFhirResource> resources =
        resourceDtos.map(IFhirResource.fromLocalDto).toList();

    Patient? patient = resources.whereType<Patient>().firstOrNull;

    if (patient == null) {
      throw Exception("Patient not found");
    }

    FhirIpsBuilder builder = FhirIpsBuilder();
    FhirIpsPdfRenderer renderer = FhirIpsPdfRenderer();

    final ipsData = await builder.buildFromRawResources(
      rawResources: resources.map((r) => r.rawResource).toList(),
      rawPatient: patient.rawResource,
    );

    return renderer.render(ipsData: ipsData);
  }
}
