import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fhir_r4/fhir_r4.dart' as fhir_r4;
import 'package:fhir_r4/fhir_r4.dart';
import 'package:health_wallet/features/records/domain/entity/i_fhir_resource.dart';
import 'package:health_wallet/core/data/local/app_database.dart';

part 'specimen.freezed.dart';

@freezed
class Specimen with _$Specimen implements IFhirResource {
  const Specimen._();

  factory Specimen({
    @Default('') String id,
    @Default('') String sourceId,
    @Default('') String resourceId,
    @Default('') String title,
    Narrative? text,
    List<Identifier>? identifier,
    Identifier? accessionIdentifier,
    SpecimenStatus? status,
    CodeableConcept? type,
    Reference? subject,
    FhirDateTime? receivedTime,
    List<Reference>? parent,
    List<Reference>? request,
    SpecimenCollection? collection,
    List<SpecimenProcessing>? processing,
    List<SpecimenContainer>? container,
    List<CodeableConcept>? condition,
    List<Annotation>? note,
  }) = _Specimen;

  @override
  FhirType get fhirType => FhirType.Specimen;

  factory Specimen.fromLocalData(FhirResourceLocalDto data) {
    final resourceJson = jsonDecode(data.resourceRaw);
    final fhirSpecimen = fhir_r4.Specimen.fromJson(resourceJson);

    return Specimen(
      id: data.id,
      sourceId: data.sourceId ?? '',
      resourceId: data.resourceId ?? '',
      title: data.title ?? '',
      text: fhirSpecimen.text,
      identifier: fhirSpecimen.identifier,
      accessionIdentifier: fhirSpecimen.accessionIdentifier,
      status: fhirSpecimen.status,
      type: fhirSpecimen.type,
      subject: fhirSpecimen.subject,
      receivedTime: fhirSpecimen.receivedTime,
      parent: fhirSpecimen.parent,
      request: fhirSpecimen.request,
      collection: fhirSpecimen.collection,
      processing: fhirSpecimen.processing,
      container: fhirSpecimen.container,
      condition: fhirSpecimen.condition,
      note: fhirSpecimen.note,
    );
  }
}
