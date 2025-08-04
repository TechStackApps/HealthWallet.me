import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/features/sync/data/dto/fhir_resource_dto.dart';

part 'fhir_bundle.freezed.dart';
part 'fhir_bundle.g.dart';

@freezed
class FhirBundle with _$FhirBundle {
  const factory FhirBundle({
    required String resourceType,
    required String type,
    required int total,
    required List<BundleEntry> entry,
  }) = _FhirBundle;

  factory FhirBundle.fromJson(Map<String, dynamic> json) =>
      _$FhirBundleFromJson(json);
}

@freezed
class BundleEntry with _$BundleEntry {
  const factory BundleEntry({
    required FhirResourceDto resource,
  }) = _BundleEntry;

  factory BundleEntry.fromJson(Map<String, dynamic> json) =>
      _$BundleEntryFromJson(json);
}
