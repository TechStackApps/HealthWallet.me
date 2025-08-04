import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fhir_r4/fhir_r4.dart';
import 'package:health_wallet/features/records/domain/entity/i_fhir_resource.dart';

part 'medication_dispense.freezed.dart';

@freezed
class MedicationDispense with _$MedicationDispense implements IFhirResource {
  const MedicationDispense._();

  factory MedicationDispense({
    @Default('') String id,
    @Default('') String sourceId,
    @Default('') String resourceId,
    @Default('') String title,
    required DateTime date,
    Narrative? text,
    List<Identifier>? identifier,
    List<Reference>? partOf,
    StatusReasonXMedicationDispense? statusReason,
    CodeableConcept? category,
    MedicationXMedicationDispense? medicationX,
    Reference? subject,
    Reference? context,
    List<Reference>? supportingInformation,
    List<MedicationDispensePerformer>? performer,
    Reference? location,
    List<Reference>? authorizingPrescription,
    CodeableConcept? type,
    Quantity? quantity,
    Quantity? daysSupply,
    FhirDateTime? whenPrepared,
    FhirDateTime? whenHandedOver,
    Reference? destination,
    List<Reference>? receiver,
    List<Annotation>? note,
    List<Dosage>? dosageInstruction,
    MedicationDispenseSubstitution? substitution,
    List<Reference>? detectedIssue,
    List<Reference>? eventHistory,
  }) = _MedicationDispense;

  @override
  FhirType get fhirType => FhirType.MedicationDispense;
}
