import 'dart:convert';
import 'package:health_wallet/core/data/local/app_database.dart';
import 'package:health_wallet/features/records/data/datasource/fhir_resource_datasource.dart';
import 'package:health_wallet/features/records/domain/entity/entity.dart';
import 'package:health_wallet/features/records/domain/entity/record_attachment/record_attachment.dart';
import 'package:health_wallet/features/records/domain/entity/record_note/record_note.dart';
import 'package:health_wallet/features/records/domain/repository/records_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter/services.dart';

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

  // Demo Data Management Implementation
  @override
  Future<void> loadDemoData() async {
    try {
      // Load demo data from assets
      final String demoDataJson = await rootBundle.loadString('assets/demo_data.json');
      final Map<String, dynamic> demoData = json.decode(demoDataJson);
      
      final List<dynamic> resources = demoData['resources'] as List<dynamic>;
      
      for (final resource in resources) {
        try {
          // Validate required fields first
          if (resource['resourceType'] == null || resource['id'] == null) {
            print('⚠️ Skipping resource with missing required fields: resourceType=${resource['resourceType']}, id=${resource['id']}');
            continue;
          }
          
          final String resourceType = resource['resourceType'] as String;
          final String resourceId = resource['id'] as String;
          final String resourceRaw = json.encode(resource);
          
          // Extract title from resource with detailed logging
          String? title;
          
          // Debug logging
          print('🔍 Processing resource: $resourceType ($resourceId)');
          print('🔍 Resource keys: ${resource.keys.toList()}');
          
          // Safe title extraction with comprehensive type checking
          title = _extractTitleSafely(resource, resourceType, resourceId);
          
          // Extract date from various fields with type checking
          DateTime? date = _extractDateSafely(resource);
          
          // Extract encounter ID if available
          String? encounterId = _extractReferenceIdSafely(resource, 'encounter');
          
          // Extract subject ID if available
          String? subjectId = _extractReferenceIdSafely(resource, 'subject') ?? 
                              _extractReferenceIdSafely(resource, 'patient');
          
          // Create FhirResourceLocalDto
          final fhirResource = FhirResourceLocalDto(
            id: 'demo_${resourceType}_$resourceId',
            sourceId: 'demo',
            resourceType: resourceType,
            resourceId: resourceId,
            title: title,
            date: date,
            resourceRaw: resourceRaw,
            encounterId: encounterId,
            subjectId: subjectId,
          );
          
          print('🔍 Created FhirResourceLocalDto: ${fhirResource.id}');
          
          // Validate that the resource can be properly parsed before inserting
          try {
            // Try to create the entity to ensure it can be parsed
            final entity = IFhirResource.fromLocalDto(fhirResource);
            print('🔍 Successfully validated entity: ${entity.fhirType.display}');
            
            // Insert into database only if validation passes
            await _datasource.insertResource(fhirResource);
            print('✅ Successfully inserted resource: ${fhirResource.id}');
          } catch (e, stackTrace) {
            print('❌ Validation failed for resource ${fhirResource.id}: $e');
            print('❌ Stack trace: $stackTrace');
            print('❌ Skipping this resource to prevent UI crashes');
            // Skip this resource instead of failing completely
            continue;
          }
          
        } catch (e, stackTrace) {
          print('❌ Error processing resource: $e');
          print('❌ Stack trace: $stackTrace');
          print('❌ Resource data: $resource');
          // Continue with next resource instead of failing completely
          continue;
        }
      }
      
      print('✅ Demo data loading completed successfully');
    } catch (e, stackTrace) {
      print('❌ Failed to load demo data: $e');
      print('❌ Stack trace: $stackTrace');
      throw Exception('Failed to load demo data: $e');
    }
  }

  @override
  Future<void> clearDemoData() async {
    await _datasource.deleteResourcesBySourceId('demo');
  }

  @override
  Future<bool> hasDemoData() async {
    final resources = await _datasource.getResources(sourceId: 'demo', resourceTypes: [], limit: 1);
    return resources.isNotEmpty;
  }

  /// Extract text content from HTML div
  String _extractTextFromHtml(String html) {
    // Simple HTML tag removal - in production you might want a proper HTML parser
    return html
        .replaceAll(RegExp(r'<[^>]*>'), '')
        .replaceAll('&nbsp;', ' ')
        .trim();
  }

  /// Safely extract title from resource with comprehensive type checking
  String _extractTitleSafely(Map<String, dynamic> resource, String resourceType, String resourceId) {
    String? title;
    
    // Try to extract from text.div first
    if (resource['text'] != null && resource['text'] is Map<String, dynamic>) {
      final textMap = resource['text'] as Map<String, dynamic>;
      if (textMap['div'] != null && textMap['div'] is String) {
        title = _extractTextFromHtml(textMap['div'] as String);
        print('🔍 Extracted title from text.div: $title');
      }
    }
    
    // Try to extract from name if title not found
    if (title == null && resource['name'] != null && resource['name'] is List) {
      final nameList = resource['name'] as List;
      if (nameList.isNotEmpty) {
        final name = nameList[0];
        if (name is Map<String, dynamic>) {
          if (name['text'] != null && name['text'] is String) {
            title = name['text'] as String;
            print('🔍 Extracted title from name.text: $title');
          } else if (name['family'] != null && name['given'] != null && 
                     name['family'] is String && name['given'] is List) {
            final given = name['given'] as List;
            final family = name['family'] as String;
            if (given.isNotEmpty && given[0] is String) {
              title = '${given[0]} $family';
              print('🔍 Extracted title from name.given+family: $title');
            }
          }
        }
      }
    }
    
    // Try to extract from title field
    if (title == null && resource['title'] != null && resource['title'] is String) {
      title = resource['title'] as String;
      print('🔍 Extracted title from title field: $title');
    }
    
    // Fallback title if none extracted
    if (title == null || title.isEmpty) {
      title = '$resourceType $resourceId';
      print('🔍 Using fallback title: $title');
    }
    
    return title;
  }

  /// Safely extract date from resource with comprehensive type checking
  DateTime? _extractDateSafely(Map<String, dynamic> resource) {
    final dateFields = [
      'effectiveDateTime',
      'issued',
      'performedDateTime',
      'occurrenceDateTime',
      'created',
      'recordedDate',
      'onsetDateTime'
    ];
    
    for (final field in dateFields) {
      if (resource[field] != null && resource[field] is String) {
        try {
          final date = DateTime.parse(resource[field] as String);
          print('🔍 Parsed date from $field: $date');
          return date;
        } catch (e) {
          print('⚠️ Failed to parse date from $field: ${resource[field]} - $e');
        }
      }
    }
    
    return null;
  }

  /// Safely extract reference ID from resource with comprehensive type checking
  String? _extractReferenceIdSafely(Map<String, dynamic> resource, String fieldName) {
    if (resource[fieldName] != null && resource[fieldName] is Map<String, dynamic>) {
      final refMap = resource[fieldName] as Map<String, dynamic>;
      if (refMap['reference'] != null && refMap['reference'] is String) {
        final reference = refMap['reference'] as String;
        final id = reference.split('/').last;
        print('🔍 Extracted $fieldName ID: $id');
        return id;
      }
    }
    return null;
  }
}
