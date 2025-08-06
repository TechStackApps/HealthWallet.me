import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/features/records/domain/entity/i_fhir_resource.dart';
import 'package:health_wallet/core/data/local/app_database.dart';

part 'general_resource.freezed.dart';

@freezed
class GeneralResource with _$GeneralResource implements IFhirResource {
  const GeneralResource._();

  factory GeneralResource({
    @Default('') String id,
    @Default('') String sourceId,
    @Default('') String resourceId,
    @Default('') String title,
    DateTime? date,
  }) = _GeneralResource;

  @override
  FhirType get fhirType => FhirType.GeneralResource;

  factory GeneralResource.fromLocalData(FhirResourceLocalDto data) {
    return GeneralResource(
      id: data.id,
      sourceId: data.sourceId ?? '',
      resourceId: data.resourceId ?? '',
      title: data.title ?? '',
      date: data.date,
    );
  }
}
