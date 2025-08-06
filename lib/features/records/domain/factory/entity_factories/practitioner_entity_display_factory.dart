import 'package:health_wallet/features/records/domain/entity/practitioner/practitioner.dart';
import 'package:health_wallet/features/records/domain/entity/i_fhir_resource.dart';
import 'package:health_wallet/features/records/domain/factory/base_entity_display_factory.dart';

/// Entity display factory for Practitioner resources
class PractitionerEntityDisplayFactory extends BaseEntityDisplayFactory {
  @override
  String get resourceType => 'Practitioner';

  @override
  String extractPrimaryDisplay(IFhirResource entity) {
    final practitioner = entity as Practitioner;

    if (practitioner.name?.isNotEmpty == true) {
      final name = practitioner.name!.first;
      final humanName = BaseEntityDisplayFactory.extractHumanName(name);
      if (humanName != null) return humanName;
    }

    return 'Unknown Practitioner';
  }

  @override
  String? extractSecondaryDisplay(IFhirResource entity) {
    final practitioner = entity as Practitioner;

    final gender = practitioner.gender?.toString();
    final identifier = practitioner.identifier?.firstOrNull?.value?.toString();

    return BaseEntityDisplayFactory.joinNonNull([gender, identifier], ' • ');
  }

  @override
  String? extractStatus(IFhirResource entity) {
    final practitioner = entity as Practitioner;
    final active = practitioner.active;
    return active == true ? 'Active' : 'Inactive';
  }

  @override
  String? extractCategory(IFhirResource entity) {
    return null; // Practitioners don't have categories
  }

  @override
  String? extractDate(IFhirResource entity) {
    return null; // Practitioners don't have a specific date
  }

  @override
  List<String> buildAdditionalInfo(IFhirResource entity) {
    final practitioner = entity as Practitioner;
    final additionalInfo = <String>[];

    // Gender
    final gender = practitioner.gender?.toString();
    if (gender != null) {
      additionalInfo.add('Gender: $gender');
    }

    // Identifier
    if (practitioner.identifier?.isNotEmpty == true) {
      final identifier = practitioner.identifier!.first;
      final system = identifier.system?.toString();
      final value = identifier.value?.toString();
      if (system != null && value != null) {
        additionalInfo.add('ID: $system - $value');
      }
    }

    // Contact
    if (practitioner.telecom?.isNotEmpty == true) {
      final contact = practitioner.telecom!.first;
      final value = contact.value?.toString();
      final system = contact.system?.toString();
      if (value != null && system != null) {
        additionalInfo.add('$system: $value');
      }
    }

    // Address
    if (practitioner.address?.isNotEmpty == true) {
      final addr = practitioner.address!.first;
      final city = addr.city?.toString();
      final state = addr.state?.toString();
      final country = addr.country?.toString();
      final location =
          BaseEntityDisplayFactory.joinNonNull([city, state, country], ', ');
      if (location != null) {
        additionalInfo.add('Location: $location');
      }
    }

    return additionalInfo;
  }
}
