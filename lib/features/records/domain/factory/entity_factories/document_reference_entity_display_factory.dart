import 'package:health_wallet/features/records/domain/entity/document_reference/document_reference.dart';
import 'package:health_wallet/features/records/domain/entity/i_fhir_resource.dart';
import 'package:health_wallet/features/records/domain/factory/base_entity_display_factory.dart';

/// Entity display factory for DocumentReference resources
class DocumentReferenceEntityDisplayFactory extends BaseEntityDisplayFactory {
  @override
  String get resourceType => 'DocumentReference';

  @override
  String extractPrimaryDisplay(IFhirResource entity) {
    final doc = entity as DocumentReference;

    final displayText =
        BaseEntityDisplayFactory.extractCodeableConceptTextNullable(doc.type);
    if (displayText != null) return displayText;

    return 'Document ${doc.id}';
  }

  @override
  String? extractSecondaryDisplay(IFhirResource entity) {
    final doc = entity as DocumentReference;

    final status = doc.status?.toString();
    final category =
        BaseEntityDisplayFactory.extractFirstCodeableConceptFromArray(
            doc.category);

    return BaseEntityDisplayFactory.joinNonNull([status, category], ' • ');
  }

  @override
  String? extractStatus(IFhirResource entity) {
    final doc = entity as DocumentReference;
    return doc.status?.toString();
  }

  @override
  String? extractCategory(IFhirResource entity) {
    final doc = entity as DocumentReference;
    return BaseEntityDisplayFactory.extractFirstCodeableConceptFromArray(
        doc.category);
  }

  @override
  String? extractDate(IFhirResource entity) {
    final doc = entity as DocumentReference;
    return doc.date?.toString();
  }

  @override
  List<String> buildAdditionalInfo(IFhirResource entity) {
    final doc = entity as DocumentReference;
    final additionalInfo = <String>[];

    // Status
    final status = doc.status?.toString();
    if (status != null) {
      additionalInfo.add('Status: $status');
    }

    // Category
    final category =
        BaseEntityDisplayFactory.extractFirstCodeableConceptFromArray(
            doc.category);
    if (category != null) {
      additionalInfo.add('Category: $category');
    }

    // Date
    final date = doc.date?.toString();
    if (date != null) {
      additionalInfo.add('Date: $date');
    }

    // Author
    if (doc.author?.isNotEmpty == true) {
      final author = doc.author!.first;
      final display = author.display?.toString();
      if (display != null) {
        additionalInfo.add('Author: $display');
      }
    }

    // Custodian
    if (doc.custodian?.display != null) {
      additionalInfo.add('Custodian: ${doc.custodian!.display}');
    }

    return additionalInfo;
  }
}
