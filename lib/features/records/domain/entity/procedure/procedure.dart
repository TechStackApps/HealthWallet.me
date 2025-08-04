import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/features/records/domain/entity/i_fhir_resource.dart';

part 'procedure.freezed.dart';

@freezed
class Procedure with _$Procedure implements IFhirResource {
  const Procedure._();

  factory Procedure({
    @Default('') String id,
    @Default('') String sourceId,
    @Default('') String resourceId,
    @Default('') String title,
    required DateTime date,
  }) = _Procedure;

  @override
  FhirType get fhirType => FhirType.Procedure;
}
