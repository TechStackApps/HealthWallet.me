import 'package:health_wallet/features/records/domain/entity/service_request/service_request.dart';
import 'package:health_wallet/features/records/domain/entity/i_fhir_resource.dart';
import 'package:health_wallet/features/records/domain/factory/base_entity_display_factory.dart';

/// Entity display factory for ServiceRequest resources
class ServiceRequestEntityDisplayFactory extends BaseEntityDisplayFactory {
  @override
  String get resourceType => 'ServiceRequest';

  @override
  String extractPrimaryDisplay(IFhirResource entity) {
    final request = entity as ServiceRequest;

    final displayText =
        BaseEntityDisplayFactory.extractCodeableConceptTextNullable(
            request.code);
    if (displayText != null) return displayText;

    return 'Service Request ${request.id}';
  }

  @override
  String? extractSecondaryDisplay(IFhirResource entity) {
    final request = entity as ServiceRequest;

    final status = request.status?.toString();
    final intent = request.intent?.toString();

    return BaseEntityDisplayFactory.joinNonNull([status, intent], ' • ');
  }

  @override
  String? extractStatus(IFhirResource entity) {
    final request = entity as ServiceRequest;
    return request.status?.toString();
  }

  @override
  String? extractCategory(IFhirResource entity) {
    final request = entity as ServiceRequest;
    return BaseEntityDisplayFactory.extractFirstCodeableConceptFromArray(
        request.category);
  }

  @override
  String? extractDate(IFhirResource entity) {
    final request = entity as ServiceRequest;
    return request.authoredOn?.toString();
  }

  @override
  List<String> buildAdditionalInfo(IFhirResource entity) {
    final request = entity as ServiceRequest;
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

    return additionalInfo;
  }
}
