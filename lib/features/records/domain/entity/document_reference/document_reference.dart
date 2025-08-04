import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/features/records/domain/entity/i_fhir_resource.dart';

part 'document_reference.freezed.dart';

@freezed
class DocumentReference with _$DocumentReference implements IFhirResource {
  const DocumentReference._();

  factory DocumentReference({
    @Default('') String id,
    @Default('') String sourceId,
    @Default('') String resourceId,
    @Default('') String title,
    required DateTime date,
  }) = _DiagnosticReport;

  @override
  FhirType get fhirType => FhirType.DocumentReference;
}