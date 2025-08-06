import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fhir_r4/fhir_r4.dart' as fhir_r4;
import 'package:fhir_r4/fhir_r4.dart';
import 'package:health_wallet/features/records/domain/entity/i_fhir_resource.dart';
import 'package:health_wallet/core/data/local/app_database.dart';

part 'binary.freezed.dart';

@freezed
class Binary with _$Binary implements IFhirResource {
  const Binary._();

  factory Binary({
    @Default('') String id,
    @Default('') String sourceId,
    @Default('') String resourceId,
    @Default('') String title,
    FhirCode? contentType,
    Reference? securityContext,
    FhirBase64Binary? data,
  }) = _Binary;

  @override
  FhirType get fhirType => FhirType.Binary;

  factory Binary.fromLocalData(FhirResourceLocalDto data) {
    final resourceJson = jsonDecode(data.resourceRaw);
    final fhirBinary = fhir_r4.Binary.fromJson(resourceJson);

    return Binary(
      id: data.id,
      sourceId: data.sourceId ?? '',
      resourceId: data.resourceId ?? '',
      title: data.title ?? '',
      contentType: fhirBinary.contentType,
      securityContext: fhirBinary.securityContext,
      data: fhirBinary.data,
    );
  }
}
