import 'package:health_wallet/features/records/domain/entity/specimen/specimen.dart';
import 'package:health_wallet/features/records/domain/entity/i_fhir_resource.dart';
import 'package:health_wallet/features/records/domain/factory/base_entity_display_factory.dart';

/// Entity display factory for Specimen resources
class SpecimenEntityDisplayFactory extends BaseEntityDisplayFactory {
  @override
  String get resourceType => 'Specimen';

  @override
  String extractPrimaryDisplay(IFhirResource entity) {
    final specimen = entity as Specimen;

    final displayText =
        BaseEntityDisplayFactory.extractCodeableConceptTextNullable(
            specimen.type);
    if (displayText != null) return displayText;

    return 'Specimen ${specimen.id}';
  }

  @override
  String? extractSecondaryDisplay(IFhirResource entity) {
    final specimen = entity as Specimen;

    final status = specimen.status?.toString();
    final type = BaseEntityDisplayFactory.extractCodeableConceptTextNullable(
        specimen.type);

    return BaseEntityDisplayFactory.joinNonNull([status, type], ' • ');
  }

  @override
  String? extractStatus(IFhirResource entity) {
    final specimen = entity as Specimen;
    return specimen.status?.toString();
  }

  @override
  String? extractCategory(IFhirResource entity) {
    return null; // Specimens don't have categories
  }

  @override
  String? extractDate(IFhirResource entity) {
    final specimen = entity as Specimen;
    return specimen.receivedTime?.toString();
  }

  @override
  List<String> buildAdditionalInfo(IFhirResource entity) {
    final specimen = entity as Specimen;
    final additionalInfo = <String>[];

    // Status
    final status = specimen.status?.toString();
    if (status != null) {
      additionalInfo.add('Status: $status');
    }

    // Type
    final type = BaseEntityDisplayFactory.extractCodeableConceptTextNullable(
        specimen.type);
    if (type != null) {
      additionalInfo.add('Type: $type');
    }

    // Received Time
    final receivedTime = specimen.receivedTime?.toString();
    if (receivedTime != null) {
      additionalInfo.add('Received: $receivedTime');
    }

    // Collector
    if (specimen.collection?.collector?.display != null) {
      additionalInfo
          .add('Collector: ${specimen.collection!.collector!.display}');
    }

    // Subject
    if (specimen.subject?.display != null) {
      additionalInfo.add('Patient: ${specimen.subject!.display}');
    }

    return additionalInfo;
  }
}
