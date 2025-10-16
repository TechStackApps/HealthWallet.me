import 'package:freezed_annotation/freezed_annotation.dart';
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
    @Default('') String reportName,
    @Default('') String conclusion,
    @Default('') String issuedDate,
  }) = _MappingDiagnosticReport;

  factory MappingDiagnosticReport.fromJson(Map<String, dynamic> json) {
    return MappingDiagnosticReport(
      reportName: json['reportName'] ?? '',
      conclusion: json['conclusion'] ?? '',
      issuedDate: json['issuedDate'] ?? '',
    );
  }

  @override
  IFhirResource toFhirResource() => const DiagnosticReport();

  @override
  Map<String, TextFieldDescriptor> getFieldDescriptors() => {
        'reportName':
            TextFieldDescriptor(label: 'Report Name', value: reportName),
        'conclusion':
            TextFieldDescriptor(label: 'Conclusion', value: conclusion),
        'issuedDate':
            TextFieldDescriptor(label: 'Issued Date', value: issuedDate),
      };

  @override
  MappingResource copyWithMap(Map<String, dynamic> newValues) =>
      MappingDiagnosticReport(
        reportName: newValues['reportName'] ?? reportName,
        conclusion: newValues['conclusion'] ?? conclusion,
        issuedDate: newValues['issuedDate'] ?? issuedDate,
      );

  @override
  String get label => 'Diagnostic Report';
}
