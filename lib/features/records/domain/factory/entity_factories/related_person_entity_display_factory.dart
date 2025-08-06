import 'package:health_wallet/features/records/domain/entity/related_person/related_person.dart';
import 'package:health_wallet/features/records/domain/entity/i_fhir_resource.dart';
import 'package:health_wallet/features/records/domain/factory/base_entity_display_factory.dart';

/// Entity display factory for RelatedPerson resources
class RelatedPersonEntityDisplayFactory extends BaseEntityDisplayFactory {
  @override
  String get resourceType => 'RelatedPerson';

  @override
  String extractPrimaryDisplay(IFhirResource entity) {
    final person = entity as RelatedPerson;

    if (person.name?.isNotEmpty == true) {
      final name = person.name!.first;
      final humanName = BaseEntityDisplayFactory.extractHumanName(name);
      if (humanName != null) return humanName;
    }

    return 'Related Person ${person.id}';
  }

  @override
  String? extractSecondaryDisplay(IFhirResource entity) {
    final person = entity as RelatedPerson;

    final relationship =
        BaseEntityDisplayFactory.extractFirstCodeableConceptFromArray(
            person.relationship);
    final gender = person.gender?.toString();

    return BaseEntityDisplayFactory.joinNonNull([relationship, gender], ' • ');
  }

  @override
  String? extractStatus(IFhirResource entity) {
    final person = entity as RelatedPerson;
    final active = person.active;
    return active == true ? 'Active' : 'Inactive';
  }

  @override
  String? extractCategory(IFhirResource entity) {
    return null; // Related persons don't have categories
  }

  @override
  String? extractDate(IFhirResource entity) {
    return null; // Related persons don't have dates
  }

  @override
  List<String> buildAdditionalInfo(IFhirResource entity) {
    final person = entity as RelatedPerson;
    final additionalInfo = <String>[];

    // Gender
    final gender = person.gender?.toString();
    if (gender != null) {
      additionalInfo.add('Gender: $gender');
    }

    // Relationship
    final relationship =
        BaseEntityDisplayFactory.extractFirstCodeableConceptFromArray(
            person.relationship);
    if (relationship != null) {
      additionalInfo.add('Relationship: $relationship');
    }

    // Patient
    if (person.patient?.display != null) {
      additionalInfo.add('Patient: ${person.patient!.display}');
    }

    // Contact
    if (person.telecom?.isNotEmpty == true) {
      final contact = person.telecom!.first;
      final value = contact.value?.toString();
      final system = contact.system?.toString();
      if (value != null && system != null) {
        additionalInfo.add('$system: $value');
      }
    }

    // Address
    if (person.address?.isNotEmpty == true) {
      final addr = person.address!.first;
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
