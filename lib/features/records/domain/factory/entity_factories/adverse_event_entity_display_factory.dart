import 'package:health_wallet/features/records/domain/entity/adverse_event/adverse_event.dart';
import 'package:health_wallet/features/records/domain/entity/i_fhir_resource.dart';
import 'package:health_wallet/features/records/domain/factory/base_entity_display_factory.dart';

/// Entity display factory for AdverseEvent resources
class AdverseEventEntityDisplayFactory extends BaseEntityDisplayFactory {
  @override
  String get resourceType => 'AdverseEvent';

  @override
  String extractPrimaryDisplay(IFhirResource entity) {
    final event = entity as AdverseEvent;

    final displayText =
        BaseEntityDisplayFactory.extractCodeableConceptTextNullable(
            event.event);
    if (displayText != null) return displayText;

    return 'Adverse Event ${event.id}';
  }

  @override
  String? extractSecondaryDisplay(IFhirResource entity) {
    final event = entity as AdverseEvent;

    final actuality = event.actuality?.toString();
    final seriousness =
        BaseEntityDisplayFactory.extractCodeableConceptTextNullable(
            event.seriousness);

    return BaseEntityDisplayFactory.joinNonNull(
        [actuality, seriousness], ' • ');
  }

  @override
  String? extractStatus(IFhirResource entity) {
    final event = entity as AdverseEvent;
    return event.actuality?.toString();
  }

  @override
  String? extractCategory(IFhirResource entity) {
    final event = entity as AdverseEvent;
    return BaseEntityDisplayFactory.extractFirstCodeableConceptFromArray(
        event.category);
  }

  @override
  String? extractDate(IFhirResource entity) {
    final event = entity as AdverseEvent;
    return event.date?.toString();
  }

  @override
  List<String> buildAdditionalInfo(IFhirResource entity) {
    final event = entity as AdverseEvent;
    final additionalInfo = <String>[];

    // Actuality
    final actuality = event.actuality?.toString();
    if (actuality != null) {
      additionalInfo.add('Actuality: $actuality');
    }

    // Seriousness
    final seriousness =
        BaseEntityDisplayFactory.extractCodeableConceptTextNullable(
            event.seriousness);
    if (seriousness != null) {
      additionalInfo.add('Seriousness: $seriousness');
    }

    // Category
    final category =
        BaseEntityDisplayFactory.extractFirstCodeableConceptFromArray(
            event.category);
    if (category != null) {
      additionalInfo.add('Category: $category');
    }

    // Date
    final date = event.date?.toString();
    if (date != null) {
      additionalInfo.add('Date: $date');
    }

    // Subject
    if (event.subject?.display != null) {
      additionalInfo.add('Patient: ${event.subject!.display}');
    }

    // Recorder
    if (event.recorder?.display != null) {
      additionalInfo.add('Recorder: ${event.recorder!.display}');
    }

    return additionalInfo;
  }
}
