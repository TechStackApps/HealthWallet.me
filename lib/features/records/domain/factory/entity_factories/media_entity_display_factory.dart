import 'package:health_wallet/features/records/domain/entity/media/media.dart';
import 'package:health_wallet/features/records/domain/entity/i_fhir_resource.dart';
import 'package:health_wallet/features/records/domain/factory/base_entity_display_factory.dart';

/// Entity display factory for Media resources
class MediaEntityDisplayFactory extends BaseEntityDisplayFactory {
  @override
  String get resourceType => 'Media';

  @override
  String extractPrimaryDisplay(IFhirResource entity) {
    final media = entity as Media;

    final displayText =
        BaseEntityDisplayFactory.extractCodeableConceptTextNullable(media.type);
    if (displayText != null) return displayText;

    return 'Media ${media.id}';
  }

  @override
  String? extractSecondaryDisplay(IFhirResource entity) {
    final media = entity as Media;

    final status = media.status?.toString();
    final modality =
        BaseEntityDisplayFactory.extractCodeableConceptTextNullable(
            media.modality);

    return BaseEntityDisplayFactory.joinNonNull([status, modality], ' • ');
  }

  @override
  String? extractStatus(IFhirResource entity) {
    final media = entity as Media;
    return media.status?.toString();
  }

  @override
  String? extractCategory(IFhirResource entity) {
    return null; // Media don't have categories
  }

  @override
  String? extractDate(IFhirResource entity) {
    final media = entity as Media;
    return media.issued?.toString();
  }

  @override
  List<String> buildAdditionalInfo(IFhirResource entity) {
    final media = entity as Media;
    final additionalInfo = <String>[];

    // Status
    final status = media.status?.toString();
    if (status != null) {
      additionalInfo.add('Status: $status');
    }

    // Type
    final type =
        BaseEntityDisplayFactory.extractCodeableConceptTextNullable(media.type);
    if (type != null) {
      additionalInfo.add('Type: $type');
    }

    // Modality
    final modality =
        BaseEntityDisplayFactory.extractCodeableConceptTextNullable(
            media.modality);
    if (modality != null) {
      additionalInfo.add('Modality: $modality');
    }

    // Issued Date
    final issuedDate = media.issued?.toString();
    if (issuedDate != null) {
      additionalInfo.add('Issued: $issuedDate');
    }

    // Subject
    if (media.subject?.display != null) {
      additionalInfo.add('Patient: ${media.subject!.display}');
    }

    // Operator
    if (media.operator_?.display != null) {
      additionalInfo.add('Operator: ${media.operator_!.display}');
    }

    return additionalInfo;
  }
}
