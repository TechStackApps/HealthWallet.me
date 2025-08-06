import 'package:health_wallet/features/records/domain/entity/allergy_intolerance/allergy_intolerance.dart';
import 'package:health_wallet/features/records/domain/entity/i_fhir_resource.dart';
import 'package:health_wallet/features/records/domain/factory/base_entity_display_factory.dart';

/// Entity display factory for AllergyIntolerance resources
class AllergyIntoleranceEntityDisplayFactory extends BaseEntityDisplayFactory {
  @override
  String get resourceType => 'AllergyIntolerance';

  @override
  String extractPrimaryDisplay(IFhirResource entity) {
    final allergy = entity as AllergyIntolerance;

    final displayText =
        BaseEntityDisplayFactory.extractCodeableConceptTextNullable(
            allergy.code);
    if (displayText != null) return displayText;

    return 'Allergy ${allergy.id}';
  }

  @override
  String? extractSecondaryDisplay(IFhirResource entity) {
    final allergy = entity as AllergyIntolerance;

    final clinicalStatus = allergy.clinicalStatus?.toString();
    final verificationStatus = allergy.verificationStatus?.toString();

    return BaseEntityDisplayFactory.joinNonNull(
        [clinicalStatus, verificationStatus], ' • ');
  }

  @override
  String? extractStatus(IFhirResource entity) {
    final allergy = entity as AllergyIntolerance;
    return allergy.clinicalStatus?.toString();
  }

  @override
  String? extractCategory(IFhirResource entity) {
    final allergy = entity as AllergyIntolerance;
    return BaseEntityDisplayFactory.extractFirstCodeableConceptFromArray(
        allergy.category);
  }

  @override
  String? extractDate(IFhirResource entity) {
    final allergy = entity as AllergyIntolerance;
    return allergy.recordedDate?.toString();
  }

  @override
  List<String> buildAdditionalInfo(IFhirResource entity) {
    final allergy = entity as AllergyIntolerance;
    final additionalInfo = <String>[];

    // Clinical Status
    final clinicalStatus = allergy.clinicalStatus?.toString();
    if (clinicalStatus != null) {
      additionalInfo.add('Status: $clinicalStatus');
    }

    // Verification Status
    final verificationStatus = allergy.verificationStatus?.toString();
    if (verificationStatus != null) {
      additionalInfo.add('Verification: $verificationStatus');
    }

    // Category
    final category =
        BaseEntityDisplayFactory.extractFirstCodeableConceptFromArray(
            allergy.category);
    if (category != null) {
      additionalInfo.add('Category: $category');
    }

    // Type
    final type = allergy.type?.toString();
    if (type != null) {
      additionalInfo.add('Type: $type');
    }

    // Criticality
    final criticality = allergy.criticality?.toString();
    if (criticality != null) {
      additionalInfo.add('Criticality: $criticality');
    }

    return additionalInfo;
  }
}
