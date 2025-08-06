import 'package:health_wallet/features/records/domain/entity/binary/binary.dart';
import 'package:health_wallet/features/records/domain/entity/i_fhir_resource.dart';
import 'package:health_wallet/features/records/domain/factory/base_entity_display_factory.dart';

/// Entity display factory for Binary resources
class BinaryEntityDisplayFactory extends BaseEntityDisplayFactory {
  @override
  String get resourceType => 'Binary';

  @override
  String extractPrimaryDisplay(IFhirResource entity) {
    final binary = entity as Binary;

    final contentType = binary.contentType?.toString();
    if (contentType != null && contentType.isNotEmpty) return contentType;

    return 'Binary ${binary.id}';
  }

  @override
  String? extractSecondaryDisplay(IFhirResource entity) {
    final binary = entity as Binary;

    final contentType = binary.contentType?.toString();
    final securityContext = binary.securityContext?.display?.toString();

    return BaseEntityDisplayFactory.joinNonNull(
        [contentType, securityContext], ' • ');
  }

  @override
  String? extractStatus(IFhirResource entity) {
    return null; // Binary resources don't have status
  }

  @override
  String? extractCategory(IFhirResource entity) {
    return null; // Binary resources don't have categories
  }

  @override
  String? extractDate(IFhirResource entity) {
    return null; // Binary resources don't have dates
  }

  @override
  List<String> buildAdditionalInfo(IFhirResource entity) {
    final binary = entity as Binary;
    final additionalInfo = <String>[];

    // Content Type
    final contentType = binary.contentType?.toString();
    if (contentType != null) {
      additionalInfo.add('Type: $contentType');
    }

    // Security Context
    if (binary.securityContext?.display != null) {
      additionalInfo.add('Security: ${binary.securityContext!.display}');
    }

    // Data (simplified - just show if present)
    if (binary.data != null) {
      additionalInfo.add('Data: Present');
    }

    return additionalInfo;
  }
}
