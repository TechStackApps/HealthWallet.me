import 'package:health_wallet/features/records/domain/entity/organization/organization.dart';
import 'package:health_wallet/features/records/domain/entity/i_fhir_resource.dart';
import 'package:health_wallet/features/records/domain/factory/base_entity_display_factory.dart';

/// Entity display factory for Organization resources
class OrganizationEntityDisplayFactory extends BaseEntityDisplayFactory {
  @override
  String get resourceType => 'Organization';

  @override
  String extractPrimaryDisplay(IFhirResource entity) {
    final organization = entity as Organization;

    final name = organization.name?.toString();
    if (name != null && name.isNotEmpty) return name;

    return 'Unknown Organization';
  }

  @override
  String? extractSecondaryDisplay(IFhirResource entity) {
    final organization = entity as Organization;

    final type = BaseEntityDisplayFactory.extractFirstCodeableConceptFromArray(
        organization.type);
    final identifier = organization.identifier?.firstOrNull?.value?.toString();

    return BaseEntityDisplayFactory.joinNonNull([type, identifier], ' • ');
  }

  @override
  String? extractStatus(IFhirResource entity) {
    final organization = entity as Organization;
    final active = organization.active;
    return active == true ? 'Active' : 'Inactive';
  }

  @override
  String? extractCategory(IFhirResource entity) {
    return null; // Organizations don't have categories
  }

  @override
  String? extractDate(IFhirResource entity) {
    return null; // Organizations don't have a specific date
  }

  @override
  List<String> buildAdditionalInfo(IFhirResource entity) {
    final organization = entity as Organization;
    final additionalInfo = <String>[];

    // Type
    final type = BaseEntityDisplayFactory.extractFirstCodeableConceptFromArray(
        organization.type);
    if (type != null) {
      additionalInfo.add('Type: $type');
    }

    // Identifier
    if (organization.identifier?.isNotEmpty == true) {
      final identifier = organization.identifier!.first;
      final system = identifier.system?.toString();
      final value = identifier.value?.toString();
      if (system != null && value != null) {
        additionalInfo.add('ID: $system - $value');
      }
    }

    // Contact
    if (organization.telecom?.isNotEmpty == true) {
      final contact = organization.telecom!.first;
      final value = contact.value?.toString();
      final system = contact.system?.toString();
      if (value != null && system != null) {
        additionalInfo.add('$system: $value');
      }
    }

    // Address
    if (organization.address?.isNotEmpty == true) {
      final addr = organization.address!.first;
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
