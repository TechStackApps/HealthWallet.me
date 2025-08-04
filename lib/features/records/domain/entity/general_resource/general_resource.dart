import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/features/records/domain/entity/i_fhir_resource.dart';

part 'general_resource.freezed.dart';

@freezed
class GeneralResource with _$GeneralResource implements IFhirResource {
  const GeneralResource._();

  factory GeneralResource({
    @Default('') String id,
    @Default('') String sourceId,
    @Default('') String resourceId,
    @Default('') String title,
    required DateTime date,
  }) = _GeneralResource;

  @override
  FhirType get fhirType => FhirType.GeneralResource;
}
