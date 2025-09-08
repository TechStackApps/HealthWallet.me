/// Utility functions for identifying demo data
class DemoDataIdentifier {
  /// The source ID used for demo data
  static const String demoSourceId = 'demo_data';

  /// Check if a source ID represents demo data
  static bool isDemoData(String? sourceId) {
    return sourceId == demoSourceId;
  }

  /// Get a user-friendly description for demo data
  static String getDemoDescription() {
    return 'Demo';
  }

  /// Check if a resource is demo data based on its source ID
  static bool isDemoResource(String? sourceId) {
    return isDemoData(sourceId);
  }
}
