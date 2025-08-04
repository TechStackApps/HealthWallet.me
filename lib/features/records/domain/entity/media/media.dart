import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/features/records/domain/entity/i_fhir_resource.dart';

part 'media.freezed.dart';

@freezed
class Media with _$Media implements IFhirResource {
  const Media._();

  factory Media({
    @Default('') String id,
    @Default('') String sourceId,
    @Default('') String resourceId,
    @Default('') String title,
    required DateTime date,
  }) = _Media;

  @override
  FhirType get fhirType => FhirType.Media;
}
