import 'package:health_wallet/features/records/domain/entity/care_team/care_team.dart';
import 'package:health_wallet/features/records/domain/entity/i_fhir_resource.dart';
import 'package:health_wallet/features/records/domain/factory/base_entity_display_factory.dart';

/// Entity display factory for CareTeam resources
class CareTeamEntityDisplayFactory extends BaseEntityDisplayFactory {
  @override
  String get resourceType => 'CareTeam';

  @override
  String extractPrimaryDisplay(IFhirResource entity) {
    final careTeam = entity as CareTeam;

    final name = careTeam.name?.toString();
    if (name != null && name.isNotEmpty) return name;

    return 'Care Team ${careTeam.id}';
  }

  @override
  String? extractSecondaryDisplay(IFhirResource entity) {
    final careTeam = entity as CareTeam;

    final status = careTeam.status?.toString();
    final category =
        BaseEntityDisplayFactory.extractFirstCodeableConceptFromArray(
            careTeam.category);

    return BaseEntityDisplayFactory.joinNonNull([status, category], ' • ');
  }

  @override
  String? extractStatus(IFhirResource entity) {
    final careTeam = entity as CareTeam;
    return careTeam.status?.toString();
  }

  @override
  String? extractCategory(IFhirResource entity) {
    final careTeam = entity as CareTeam;
    return BaseEntityDisplayFactory.extractFirstCodeableConceptFromArray(
        careTeam.category);
  }

  @override
  String? extractDate(IFhirResource entity) {
    return null; // Care teams don't have a specific date
  }

  @override
  List<String> buildAdditionalInfo(IFhirResource entity) {
    final careTeam = entity as CareTeam;
    final additionalInfo = <String>[];

    // Status
    final status = careTeam.status?.toString();
    if (status != null) {
      additionalInfo.add('Status: $status');
    }

    // Category
    final category =
        BaseEntityDisplayFactory.extractFirstCodeableConceptFromArray(
            careTeam.category);
    if (category != null) {
      additionalInfo.add('Category: $category');
    }

    // Subject
    if (careTeam.subject?.display != null) {
      additionalInfo.add('Patient: ${careTeam.subject!.display}');
    }

    // Encounter
    if (careTeam.encounter?.display != null) {
      additionalInfo.add('Encounter: ${careTeam.encounter!.display}');
    }

    // Managing Organization
    if (careTeam.managingOrganization?.isNotEmpty == true) {
      final org = careTeam.managingOrganization!.first;
      final display = org.display?.toString();
      if (display != null) {
        additionalInfo.add('Organization: $display');
      }
    }

    return additionalInfo;
  }
}
