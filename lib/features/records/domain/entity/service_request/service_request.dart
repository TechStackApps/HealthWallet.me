import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/features/records/domain/entity/i_fhir_resource.dart';

part 'service_request.freezed.dart';

@freezed
class ServiceRequest with _$ServiceRequest implements IFhirResource {
  const ServiceRequest._();

  factory ServiceRequest({
    @Default('') String id,
    @Default('') String sourceId,
    @Default('') String resourceId,
    @Default('') String title,
    required DateTime date,
  }) = _ServiceRequest;

  @override
  FhirType get fhirType => FhirType.ServiceRequest;
}
