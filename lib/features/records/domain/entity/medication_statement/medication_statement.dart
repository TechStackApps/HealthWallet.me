import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fhir_r4/fhir_r4.dart';
import 'package:health_wallet/features/records/domain/entity/i_fhir_resource.dart';

part 'medication_statement.freezed.dart';

@freezed
class MedicationStatement with _$MedicationStatement implements IFhirResource {
  const MedicationStatement._();

  factory MedicationStatement({
    @Default('') String id,
    @Default('') String sourceId,
    @Default('') String resourceId,
    @Default('') String title,
    required DateTime date,
    Narrative? text,
    List<Identifier>? identifier,
    List<Reference>? basedOn,
    List<Reference>? partOf,
    MedicationStatementStatusCodes? status,
    List<CodeableConcept>? statusReason,
    CodeableConcept? category,
    MedicationXMedicationStatement? medicationX,
    Reference? subject,
    Reference? context,
    EffectiveXMedicationStatement? effectiveX,
    FhirDateTime? dateAsserted,
    Reference? informationSource,
    List<Reference>? derivedFrom,
    List<CodeableConcept>? reasonCode,
    List<Reference>? reasonReference,
    List<Annotation>? note,
    List<Dosage>? dosage,
  }) = _MedicationStatement;

  @override
  FhirType get fhirType => FhirType.MedicationStatement;
}
