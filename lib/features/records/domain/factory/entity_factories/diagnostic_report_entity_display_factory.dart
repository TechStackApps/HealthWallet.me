import 'package:health_wallet/features/records/domain/entity/diagnostic_report/diagnostic_report.dart';
import 'package:health_wallet/features/records/domain/entity/i_fhir_resource.dart';
import 'package:health_wallet/features/records/domain/factory/base_entity_display_factory.dart';
import 'package:health_wallet/features/records/domain/utils/fhir_field_extractor.dart';

/// Entity display factory for DiagnosticReport resources
class DiagnosticReportEntityDisplayFactory extends BaseEntityDisplayFactory {
  @override
  String get resourceType => 'DiagnosticReport';

  @override
  String extractPrimaryDisplay(IFhirResource entity) {
    final report = entity as DiagnosticReport;

    // ✅ USE: Common pattern for CodeableConcept extraction
    final displayText =
        FhirFieldExtractor.extractCodeableConceptText(report.code);
    if (displayText != null) return displayText;

    return 'Diagnostic Report ${report.id}';
  }

  @override
  String? extractSecondaryDisplay(IFhirResource entity) {
    final report = entity as DiagnosticReport;

    // ✅ USE: Common pattern for status extraction
    final status = FhirFieldExtractor.extractStatus(report.status);
    // ✅ USE: Common pattern for CodeableConcept extraction
    final category = FhirFieldExtractor.extractFirstCodeableConceptFromArray(
        report.category);

    return FhirFieldExtractor.joinNonNull([status, category], ' • ');
  }

  @override
  String? extractStatus(IFhirResource entity) {
    final report = entity as DiagnosticReport;
    // ✅ USE: Common pattern for status extraction
    return FhirFieldExtractor.extractStatus(report.status);
  }

  @override
  String? extractCategory(IFhirResource entity) {
    final report = entity as DiagnosticReport;
    // ✅ USE: Common pattern for CodeableConcept extraction
    return FhirFieldExtractor.extractFirstCodeableConceptFromArray(
        report.category);
  }

  @override
  String? extractDate(IFhirResource entity) {
    final report = entity as DiagnosticReport;
    // ✅ USE: Common pattern for date extraction
    return FhirFieldExtractor.extractDate(report.date);
  }

  @override
  List<String> buildAdditionalInfo(IFhirResource entity) {
    final report = entity as DiagnosticReport;
    final additionalInfo = <String>[];

    // ✅ USE: Common pattern for status extraction
    final status = FhirFieldExtractor.extractStatus(report.status);
    if (status != null) {
      additionalInfo.add('Status: $status');
    }

    // ✅ USE: Common pattern for CodeableConcept extraction
    final category = FhirFieldExtractor.extractFirstCodeableConceptFromArray(
        report.category);
    if (category != null) {
      additionalInfo.add('Category: $category');
    }

    // ✅ KEEP: Resource-specific logic for issued date
    final issuedDate = FhirFieldExtractor.extractDate(report.issued);
    if (issuedDate != null) {
      additionalInfo.add('Issued: $issuedDate');
    }

    // ✅ KEEP: Resource-specific logic for multiple performers
    if (report.performer?.isNotEmpty == true) {
      final performers =
          FhirFieldExtractor.extractMultipleReferenceDisplays(report.performer);
      if (performers != null) {
        additionalInfo.add('Performers: $performers');
      }
    }

    // ✅ USE: Common pattern for reference display
    final subject = FhirFieldExtractor.extractReferenceDisplay(report.subject);
    if (subject != null) {
      additionalInfo.add('Patient: $subject');
    }

    // ✅ USE: Common pattern for reference display
    final encounter =
        FhirFieldExtractor.extractReferenceDisplay(report.encounter);
    if (encounter != null) {
      additionalInfo.add('Encounter: $encounter');
    }

    // ✅ KEEP: Resource-specific logic for results
    if (report.result?.isNotEmpty == true) {
      final results =
          FhirFieldExtractor.extractMultipleReferenceDisplays(report.result);
      if (results != null) {
        additionalInfo.add('Results: $results');
      }
    }

    // ✅ KEEP: Resource-specific logic for imaging study
    if (report.imagingStudy?.isNotEmpty == true) {
      final studies = FhirFieldExtractor.extractMultipleReferenceDisplays(
          report.imagingStudy);
      if (studies != null) {
        additionalInfo.add('Imaging Studies: $studies');
      }
    }

    return additionalInfo;
  }
}
