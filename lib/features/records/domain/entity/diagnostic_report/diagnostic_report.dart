import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/features/records/domain/entity/i_fhir_resource.dart';

part 'diagnostic_report.freezed.dart';

@freezed
class DiagnosticReport with _$DiagnosticReport implements IFhirResource {
  const DiagnosticReport._();

  factory DiagnosticReport({
    @Default('') String id,
    @Default('') String sourceId,
    @Default('') String resourceId,
    @Default('') String title,
    required DateTime date,
  }) = _DiagnosticReport;

  @override
  FhirType get fhirType => FhirType.DiagnosticReport;
}
