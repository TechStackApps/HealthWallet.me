import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fhir_r4/fhir_r4.dart' as fhir_r4;
import 'package:fhir_r4/fhir_r4.dart';
import 'package:health_wallet/features/records/domain/entity/i_fhir_resource.dart';
import 'package:health_wallet/core/data/local/app_database.dart';

part 'medication.freezed.dart';

@freezed
class Medication with _$Medication implements IFhirResource {
  const Medication._();

  factory Medication({
    @Default('') String id,
    @Default('') String sourceId,
    @Default('') String resourceId,
    @Default('') String title,
    DateTime? date,
    Narrative? text,
    List<Identifier>? identifier,
    CodeableConcept? code,
    MedicationStatusCodes? status,
    Reference? manufacturer,
    CodeableConcept? form,
    Ratio? amount,
    List<MedicationIngredient>? ingredient,
    MedicationBatch? batch,
  }) = _Medication;

  @override
  FhirType get fhirType => FhirType.Medication;

  factory Medication.fromLocalData(FhirResourceLocalDto data) {
    final resourceJson = jsonDecode(data.resourceRaw);
    final fhirMedication = fhir_r4.Medication.fromJson(resourceJson);

    return Medication(
      id: data.id,
      sourceId: data.sourceId ?? '',
      resourceId: data.resourceId ?? '',
      title: data.title ?? '',
      date: data.date,
      text: fhirMedication.text,
      identifier: fhirMedication.identifier,
      code: fhirMedication.code,
      status: fhirMedication.status,
      manufacturer: fhirMedication.manufacturer,
      form: fhirMedication.form,
      amount: fhirMedication.amount,
      ingredient: fhirMedication.ingredient,
      batch: fhirMedication.batch,
    );
  }
}
