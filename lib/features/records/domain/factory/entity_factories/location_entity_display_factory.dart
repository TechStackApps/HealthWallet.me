import 'package:health_wallet/features/records/domain/entity/location/location.dart';
import 'package:health_wallet/features/records/domain/entity/i_fhir_resource.dart';
import 'package:health_wallet/features/records/domain/factory/base_entity_display_factory.dart';
import 'package:health_wallet/features/records/domain/utils/fhir_field_extractor.dart';

/// Entity display factory for Location resources
class LocationEntityDisplayFactory extends BaseEntityDisplayFactory {
  @override
  String get resourceType => 'Location';

  @override
  String extractPrimaryDisplay(IFhirResource entity) {
    final location = entity as Location;

    // ✅ KEEP: Resource-specific logic for name extraction
    final name = location.name?.toString();
    if (name != null && name.isNotEmpty) return name;

    return 'Unknown Location';
  }

  @override
  String? extractSecondaryDisplay(IFhirResource entity) {
    final location = entity as Location;

    // ✅ USE: Common pattern for CodeableConcept extraction
    final type =
        FhirFieldExtractor.extractFirstCodeableConceptFromArray(location.type);
    // ✅ USE: Common pattern for status extraction
    final status = FhirFieldExtractor.extractStatus(location.status);

    return FhirFieldExtractor.joinNonNull([type, status], ' • ');
  }

  @override
  String? extractStatus(IFhirResource entity) {
    final location = entity as Location;
    // ✅ USE: Common pattern for status extraction
    return FhirFieldExtractor.extractStatus(location.status);
  }

  @override
  String? extractCategory(IFhirResource entity) {
    return null; // Locations don't have categories
  }

  @override
  String? extractDate(IFhirResource entity) {
    return null; // Locations don't have a specific date
  }

  @override
  List<String> buildAdditionalInfo(IFhirResource entity) {
    final location = entity as Location;
    final additionalInfo = <String>[];

    // ✅ USE: Common pattern for CodeableConcept extraction
    final type =
        FhirFieldExtractor.extractFirstCodeableConceptFromArray(location.type);
    if (type != null) {
      additionalInfo.add('Type: $type');
    }

    // ✅ USE: Common pattern for status extraction
    final status = FhirFieldExtractor.extractStatus(location.status);
    if (status != null) {
      additionalInfo.add('Status: $status');
    }

    // ✅ KEEP: Resource-specific logic for address formatting
    if (location.address != null) {
      final addressText = FhirFieldExtractor.formatAddress(location.address);
      if (addressText != null) {
        additionalInfo.add('Address: $addressText');
      }
    }

    // ✅ KEEP: Resource-specific logic for telecom
    if (location.telecom?.isNotEmpty == true) {
      for (final contact in location.telecom!) {
        final value = contact.value?.toString();
        final system = contact.system?.toString();
        if (value != null && system != null) {
          additionalInfo.add('$system: $value');
        }
      }
    }

    // ✅ USE: Common pattern for reference display
    final managingOrganization = FhirFieldExtractor.extractReferenceDisplay(
        location.managingOrganization);
    if (managingOrganization != null) {
      additionalInfo.add('Managing Organization: $managingOrganization');
    }

    // ✅ KEEP: Resource-specific logic for position
    if (location.position?.longitude != null &&
        location.position?.latitude != null) {
      additionalInfo.add(
          'Position: ${location.position!.latitude}, ${location.position!.longitude}');
    }

    return additionalInfo;
  }
}
