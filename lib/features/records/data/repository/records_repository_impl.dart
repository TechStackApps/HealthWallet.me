import 'package:health_wallet/core/data/local/app_database.dart';
import 'package:health_wallet/features/records/data/datasource/fhir_resource_datasource.dart';
import 'package:health_wallet/features/records/domain/entity/entity.dart';
import 'package:health_wallet/features/records/domain/entity/record_attachment/record_attachment.dart';
import 'package:health_wallet/features/records/domain/entity/record_note/record_note.dart';
import 'package:health_wallet/features/records/domain/repository/records_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: RecordsRepository)
class RecordsRepositoryImpl implements RecordsRepository {
  final FhirResourceDatasource _datasource;

  RecordsRepositoryImpl(AppDatabase database)
      : _datasource = FhirResourceDatasource(database);

  /// Get resources with pagination and filtering
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
}
