import 'package:health_wallet/features/records/domain/entity/practitioner_role/practitioner_role.dart';
import 'package:health_wallet/features/records/domain/entity/i_fhir_resource.dart';
import 'package:health_wallet/features/records/domain/factory/base_entity_display_factory.dart';

/// Entity display factory for PractitionerRole resources
class PractitionerRoleEntityDisplayFactory extends BaseEntityDisplayFactory {
  @override
  String get resourceType => 'PractitionerRole';

  @override
  String extractPrimaryDisplay(IFhirResource entity) {
    final role = entity as PractitionerRole;

    if (role.code?.isNotEmpty == true) {
      final code = role.code!.first;
      final displayText =
          BaseEntityDisplayFactory.extractCodeableConceptTextNullable(code);
      if (displayText != null) return displayText;
    }

    return 'Practitioner Role ${role.id}';
  }

  @override
  String? extractSecondaryDisplay(IFhirResource entity) {
    final role = entity as PractitionerRole;

    final active = role.active?.toString();
    final organization = role.organization?.display?.toString();

    return BaseEntityDisplayFactory.joinNonNull([active, organization], ' • ');
  }

  @override
  String? extractStatus(IFhirResource entity) {
    final role = entity as PractitionerRole;
    final active = role.active;
    return active == true ? 'Active' : 'Inactive';
  }

  @override
  String? extractCategory(IFhirResource entity) {
    return null; // Practitioner roles don't have categories
  }

  @override
  String? extractDate(IFhirResource entity) {
    return null; // Practitioner roles don't have dates
  }

  @override
  List<String> buildAdditionalInfo(IFhirResource entity) {
    final role = entity as PractitionerRole;
    final additionalInfo = <String>[];

    // Active Status
    final active = role.active;
    if (active != null) {
      additionalInfo.add('Active: ${active == true ? 'Yes' : 'No'}');
    }

    // Practitioner
    if (role.practitioner?.display != null) {
      additionalInfo.add('Practitioner: ${role.practitioner!.display}');
    }

    // Organization
    if (role.organization?.display != null) {
      additionalInfo.add('Organization: ${role.organization!.display}');
    }

    // Code (Role)
    if (role.code?.isNotEmpty == true) {
      final code = role.code!.first;
      final displayText =
          BaseEntityDisplayFactory.extractCodeableConceptTextNullable(code);
      if (displayText != null) {
        additionalInfo.add('Role: $displayText');
      }
    }

    // Specialty
    if (role.specialty?.isNotEmpty == true) {
      final specialty = role.specialty!.first;
      final displayText =
          BaseEntityDisplayFactory.extractCodeableConceptTextNullable(
              specialty);
      if (displayText != null) {
        additionalInfo.add('Specialty: $displayText');
      }
    }

    return additionalInfo;
  }
}
