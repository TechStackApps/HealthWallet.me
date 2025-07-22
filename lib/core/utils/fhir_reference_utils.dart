class FhirReferenceUtils {
  /// Extracts the referenced resource ID from a FHIR reference string.
  static String? extractReferenceId(String? reference) {
    if (reference == null) return null;
    if (reference.startsWith('urn:uuid:')) {
      return reference.substring('urn:uuid:'.length);
    }
    // Handles ResourceType/id or just id
    final parts = reference.split('/');
    return parts.isNotEmpty ? parts.last : reference;
  }
}
