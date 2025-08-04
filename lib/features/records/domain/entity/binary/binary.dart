import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/features/records/domain/entity/i_fhir_resource.dart';

part 'binary.freezed.dart';

@freezed
class Binary with _$Binary implements IFhirResource {
  const Binary._();

  factory Binary({
    @Default('') String id,
    @Default('') String sourceId,
    @Default('') String resourceId,
    @Default('') String title,
    required DateTime date,
  }) = _Binary;

  @override
  FhirType get fhirType => FhirType.Binary;
}
