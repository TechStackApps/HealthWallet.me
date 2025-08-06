import 'package:health_wallet/features/records/domain/entity/medication_request/medication_request.dart';
import 'package:health_wallet/features/records/domain/entity/i_fhir_resource.dart';
import 'package:health_wallet/features/records/domain/factory/base_entity_display_factory.dart';

/// Entity display factory for MedicationRequest resources
class MedicationRequestEntityDisplayFactory extends BaseEntityDisplayFactory {
  @override
  String get resourceType => 'MedicationRequest';

  @override
  String extractPrimaryDisplay(IFhirResource entity) {
    final request = entity as MedicationRequest;

    // Simplified for now (medicationX is complex union type)
    return 'Medication Request ${request.id}';
  }

  @override
  String? extractSecondaryDisplay(IFhirResource entity) {
    final request = entity as MedicationRequest;

    final status = request.status?.toString();
    final intent = request.intent?.toString();

    return BaseEntityDisplayFactory.joinNonNull([status, intent], ' • ');
  }

  @override
  String? extractStatus(IFhirResource entity) {
    final request = entity as MedicationRequest;
    return request.status?.toString();
  }

  @override
  String? extractCategory(IFhirResource entity) {
    final request = entity as MedicationRequest;
    return BaseEntityDisplayFactory.extractFirstCodeableConceptFromArray(
        request.category);
  }

  @override
  String? extractDate(IFhirResource entity) {
    final request = entity as MedicationRequest;
    return request.authoredOn?.toString();
  }

  @override
  List<String> buildAdditionalInfo(IFhirResource entity) {
    final request = entity as MedicationRequest;
    final additionalInfo = <String>[];

    // Status
    final status = request.status?.toString();
    if (status != null) {
      additionalInfo.add('Status: $status');
    }

    // Intent
    final intent = request.intent?.toString();
    if (intent != null) {
      additionalInfo.add('Intent: $intent');
    }

    // Priority
    final priority = request.priority?.toString();
    if (priority != null) {
      additionalInfo.add('Priority: $priority');
    }

    // Category
    final category =
        BaseEntityDisplayFactory.extractFirstCodeableConceptFromArray(
            request.category);
    if (category != null) {
      additionalInfo.add('Category: $category');
    }

    // Authored Date
    final authoredDate = request.authoredOn?.toString();
    if (authoredDate != null) {
      additionalInfo.add('Authored: $authoredDate');
    }

    // Requester
    if (request.requester?.display != null) {
      additionalInfo.add('Requester: ${request.requester!.display}');
    }

    // Dosage Instructions
    if (request.dosageInstruction?.isNotEmpty == true) {
      additionalInfo.add('Dosage: Specified');
    }

    return additionalInfo;
  }
}
