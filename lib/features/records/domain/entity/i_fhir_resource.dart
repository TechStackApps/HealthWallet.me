// ignore_for_file: constant_identifier_names

import 'package:health_wallet/features/home/domain/entities/overview_card.dart';
import 'package:health_wallet/gen/assets.gen.dart';

abstract class IFhirResource {
  String get id;
  String get sourceId;
  FhirType get fhirType;
  String get resourceId;
  String get title;
  DateTime get date;
}

enum FhirType {
  AdverseEvent("Adverse Event"),
  AllergyIntolerance("Allergy"),
  Binary("Binary"),
  CareTeam("Care Team"),
  Condition("Condition"),
  DiagnosticReport("Diagnostic Report"),
  DocumentReference("Document"),
  Encounter("Encounter"),
  Goal("Goal"),
  Immunization("Immunization"),
  Location("Location"),
  Media("Media"),
  Medication("Medication"),
  MedicationAdministration("Medication Administration"),
  MedicationDispense("Medication Dispense"),
  MedicationRequest("Medication Request"),
  MedicationStatement("MedicationStatement"),
  Observation("Observation"),
  Organization("Organization"),
  Patient("Patient"),
  Practitioner("Practitioner"),
  PractitionerRole("Practitioner Role"),
  Procedure("Procedure"),
  RelatedPerson("Related Person"),
  ServiceRequest("Service Request"),
  Specimen("Specimen"),
  GeneralResource("Resource");

  const FhirType(this.display);

  final String display;

  SvgGenImage get icon {
    if (this == FhirType.GeneralResource) return Assets.icons.stethoscope;

    return HomeRecordsCategory.values
        .firstWhere((category) => category.resourceTypes.contains(this))
        .icon;
  }
}
