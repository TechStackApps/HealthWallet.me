import 'dart:convert';
import 'package:health_wallet/core/data/local/app_database.dart';
import 'package:drift/drift.dart';
import 'package:health_wallet/features/sync/data/data_source/local/fhir_resource_table.dart';

/// Single datasource for all FHIR resource operations using Drift with optimizations
class FhirResourceDatasource {
  final AppDatabase db;

  // Simple in-memory cache for frequently accessed resources
  final Map<String, Map<String, dynamic>> _resourceCache = {};
  final Map<String, DateTime> _cacheTimestamps = {};
  static const Duration _cacheExpiry = Duration(minutes: 10);

  FhirResourceDatasource(this.db);

  /// Insert or update a single FHIR resource
  Future<void> insertResource(
      String resourceType, String id, Map<String, dynamic> resourceJson) async {
    await db.into(db.fhirResource).insert(
          FhirResourceCompanion(
            id: Value(id),
            resourceType: Value(resourceType),
            resourceRaw: Value(jsonEncode(resourceJson)),
          ),
          mode: InsertMode.insertOrReplace,
        );

    // Invalidate cache for this resource
    _invalidateCache('$resourceType:$id');
  }

  /// Bulk insert FHIR resources (efficient for bundle imports)
  Future<void> bulkInsertResources(String resourceType,
      List<Map<String, dynamic>> resources, String sourceId) async {
    await db.batch((batch) {
      batch.insertAllOnConflictUpdate(
        db.fhirResource,
        resources
            .map((resource) => FhirResourceCompanion(
                  id: Value(resource['id'] ?? ''),
                  resourceType: Value(resourceType),
                  resourceRaw: Value(jsonEncode(resource)),
                  sourceId: Value(sourceId),
                ))
            .toList(),
      );
    });

    // Clear cache for this resource type
    _clearCacheByType(resourceType);
  }

  /// Get a single resource by ID and type with caching
  Future<Map<String, dynamic>?> getResource(
      String resourceType, String id) async {
    final cacheKey = '$resourceType:$id';

    // Check cache first
    if (_isCacheValid(cacheKey)) {
      return _resourceCache[cacheKey];
    }

    final query = db.select(db.fhirResource)
      ..where(
          (tbl) => tbl.resourceType.equals(resourceType) & tbl.id.equals(id))
      ..limit(1);

    final result = await query.getSingleOrNull();
    if (result?.resourceRaw == null) return null;

    final resource = jsonDecode(result!.resourceRaw) as Map<String, dynamic>;

    // Cache the result
    _cacheResource(cacheKey, resource);

    return resource;
  }

  /// Get all resources of a specific type with pagination support
  Future<List<Map<String, dynamic>>> getAllResources(
    String resourceType, {
    int? limit,
    int? offset,
    String? sourceId,
  }) async {
    print(
        'DEBUG: getAllResources called with resourceType: $resourceType, sourceId: $sourceId');

    if (limit != null && offset != null) {
      // Use optimized pagination method
      final results = await db.getPaginatedResourcesByType(
        resourceType,
        limit: limit,
        offset: offset,
        sourceId: sourceId,
      );

      return results
          .map((row) => jsonDecode(row.resourceRaw) as Map<String, dynamic>)
          .toList();
    }

    // For non-paginated queries, combine the where conditions properly
    final query = db.select(db.fhirResource);

    if (sourceId != null) {
      query.where((tbl) =>
          tbl.resourceType.equals(resourceType) &
          tbl.sourceId.equals(sourceId));
    } else {
      query.where((tbl) => tbl.resourceType.equals(resourceType));
    }

    query.orderBy([(t) => OrderingTerm.desc(t.date)]);

    final results = await query.get();
    print(
        'DEBUG: Found ${results.length} resources of type $resourceType with sourceId $sourceId');

    return results
        .map((row) => jsonDecode(row.resourceRaw) as Map<String, dynamic>)
        .toList();
  }

  /// Get resource count by type efficiently
  Future<int> getResourceCountByType(String resourceType) async {
    return await db.getResourceCountByType(resourceType);
  }

  /// Get available resource types efficiently
  Future<List<String>> getAvailableResourceTypes() async {
    return await db.getAvailableResourceTypes();
  }

  /// Resolve a FHIR reference (e.g., "Patient/123" or "urn:uuid:...") with caching
  Future<Map<String, dynamic>?> resolveReference(String reference) async {
    print('DEBUG: Resolving reference: $reference');

    // Handle urn:uuid: references
    if (reference.startsWith('urn:uuid:')) {
      final uuid = reference.substring(9); // Remove "urn:uuid:"
      print('DEBUG: Looking for UUID: $uuid');

      // Check cache first
      final cachedResource = _findInCacheByUuid(uuid);
      if (cachedResource != null) {
        print('DEBUG: Found cached resource for UUID: $uuid');
        return cachedResource;
      }

      final query = db.select(db.fhirResource)
        ..where((tbl) => tbl.id.equals(uuid))
        ..limit(1);

      final result = await query.getSingleOrNull();
      if (result?.resourceRaw == null) {
        print('DEBUG: UUID not found: $uuid');
        return null;
      }

      final resource = jsonDecode(result!.resourceRaw) as Map<String, dynamic>;
      final resourceType = resource['resourceType'] as String? ?? 'Unknown';

      // Cache the result
      _cacheResource('$resourceType:$uuid', resource);

      print('DEBUG: Found resource for UUID $uuid: $resourceType');
      return resource;
    }

    // Handle ResourceType/id references
    final parts = reference.split('/');
    if (parts.length == 2) {
      print('DEBUG: Looking for ResourceType/id: ${parts[0]}/${parts[1]}');
      final resource = await getResource(parts[0], parts[1]);
      if (resource != null) {
        print('DEBUG: Found resource: ${parts[0]}/${parts[1]}');
      } else {
        print('DEBUG: Resource not found: ${parts[0]}/${parts[1]}');
      }
      return resource;
    }

    print('DEBUG: Invalid reference format: $reference');
    return null;
  }

  /// Delete a resource
  Future<void> deleteResource(String resourceType, String id) async {
    final query = db.delete(db.fhirResource)
      ..where(
          (tbl) => tbl.resourceType.equals(resourceType) & tbl.id.equals(id));
    await query.go();

    // Invalidate cache
    _invalidateCache('$resourceType:$id');
  }

  /// Get optimized encounter with references using database indexes
  Future<List<Map<String, dynamic>>> getEncounterWithReferences(
      String encounterId) async {
    final results = await db.getEncounterWithReferences(encounterId);
    return results
        .map((row) => jsonDecode(row.resourceRaw) as Map<String, dynamic>)
        .toList();
  }

  // Cache management methods

  bool _isCacheValid(String key) {
    if (!_resourceCache.containsKey(key) ||
        !_cacheTimestamps.containsKey(key)) {
      return false;
    }

    final timestamp = _cacheTimestamps[key]!;
    return DateTime.now().difference(timestamp) < _cacheExpiry;
  }

  void _cacheResource(String key, Map<String, dynamic> resource) {
    _resourceCache[key] = resource;
    _cacheTimestamps[key] = DateTime.now();

    // Limit cache size (simple LRU by removing oldest entries)
    if (_resourceCache.length > 1000) {
      _evictOldestCacheEntries();
    }
  }

  void _invalidateCache(String key) {
    _resourceCache.remove(key);
    _cacheTimestamps.remove(key);
  }

  void _clearCacheByType(String resourceType) {
    final keysToRemove = _resourceCache.keys
        .where((key) => key.startsWith('$resourceType:'))
        .toList();

    for (final key in keysToRemove) {
      _resourceCache.remove(key);
      _cacheTimestamps.remove(key);
    }
  }

  Map<String, dynamic>? _findInCacheByUuid(String uuid) {
    for (final entry in _resourceCache.entries) {
      final resource = entry.value;
      if (resource['id'] == uuid) {
        return resource;
      }
    }
    return null;
  }

  void _evictOldestCacheEntries() {
    final sortedEntries = _cacheTimestamps.entries.toList()
      ..sort((a, b) => a.value.compareTo(b.value));

    // Remove oldest 20% of entries
    final entriesToRemove = sortedEntries.take(sortedEntries.length ~/ 5);
    for (final entry in entriesToRemove) {
      _resourceCache.remove(entry.key);
      _cacheTimestamps.remove(entry.key);
    }
  }

  /// Clear all cache (useful for testing or memory management)
  void clearCache() {
    _resourceCache.clear();
    _cacheTimestamps.clear();
  }

  Future<List<FhirResourceLocalDto>> getResources({
    required List<String> resourceTypes,
    String? sourceId,
    int? limit,
    int? offset,
  }) async {
    SimpleSelectStatement<FhirResource, FhirResourceLocalDto> query =
        db.select(db.fhirResource)..orderBy([(f) => OrderingTerm.desc(f.date)]);

    if (sourceId != null) {
      query.where((f) => f.sourceId.equals(sourceId));
    }

    if (resourceTypes.isNotEmpty) {
      query.where((f) => f.resourceType.isIn(resourceTypes));
    }

    if (limit != null) {
      query.limit(limit, offset: offset);
    }
    
    return await query.get();
  }

  Future<List<FhirResourceLocalDto>> getResourcesByEncounterId({
    required String encounterId,
    String? sourceId,
  }) async {
    SimpleSelectStatement<FhirResource, FhirResourceLocalDto> query = db
        .select(db.fhirResource)
      ..where((f) => f.encounterId.equals(encounterId));

    if (sourceId != null) {
      query.where((f) => f.sourceId.equals(sourceId));
    }

    return await query.get();
  }
}
