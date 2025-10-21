import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/features/fhir_mapper/domain/entity/mapping_resources/mapped_property.dart';
import 'package:health_wallet/features/fhir_mapper/domain/entity/mapping_resources/mapping_resource.dart';
import 'package:health_wallet/features/fhir_mapper/domain/entity/text_field_descriptor.dart';
import 'package:health_wallet/features/records/domain/entity/entity.dart';

part 'mapping_diagnostic_report.freezed.dart';

@freezed
class MappingDiagnosticReport
    with _$MappingDiagnosticReport
    implements MappingResource {
  const MappingDiagnosticReport._();

  const factory MappingDiagnosticReport({
    @Default(MappedProperty()) MappedProperty reportName,
    @Default(MappedProperty()) MappedProperty conclusion,
    @Default(MappedProperty()) MappedProperty issuedDate,
  }) = _MappingDiagnosticReport;

  factory MappingDiagnosticReport.fromJson(Map<String, dynamic> json) {
    return MappingDiagnosticReport(
      reportName: MappedProperty(value: json['reportName'] ?? ''),
      conclusion: MappedProperty(value: json['conclusion'] ?? ''),
      issuedDate: MappedProperty(value: json['issuedDate'] ?? ''),
    );
  }

  @override
  IFhirResource toFhirResource() => const DiagnosticReport();

  @override
  Map<String, TextFieldDescriptor> getFieldDescriptors() => {
        'reportName': TextFieldDescriptor(
          label: 'Report Name',
          value: reportName.value,
          confidenceLevel: reportName.confidenceLevel,
        ),
        'conclusion': TextFieldDescriptor(
          label: 'Conclusion',
          value: conclusion.value,
          confidenceLevel: conclusion.confidenceLevel,
        ),
        'issuedDate': TextFieldDescriptor(
          label: 'Issued Date',
          value: issuedDate.value,
          confidenceLevel: issuedDate.confidenceLevel,
        ),
      };

  @override
  MappingResource copyWithMap(Map<String, dynamic> newValues) =>
      MappingDiagnosticReport(
        reportName:
            MappedProperty(value: newValues['reportName'] ?? reportName.value),
        conclusion:
            MappedProperty(value: newValues['conclusion'] ?? conclusion.value),
        issuedDate:
            MappedProperty(value: newValues['issuedDate'] ?? issuedDate.value),
      );

  @override
  String get label => 'Diagnostic Report';

  @override
  MappingResource populateConfidence(String inputText) => copyWith(
        reportName: reportName.calculateConfidence(inputText),
        conclusion: conclusion.calculateConfidence(inputText),
        issuedDate: issuedDate.calculateConfidence(inputText),
      );

  @override
  bool get isValid =>
      reportName.isValid || conclusion.isValid || issuedDate.isValid;
}
