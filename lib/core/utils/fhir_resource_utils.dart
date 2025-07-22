const List<String> fhirResourceTypes = [
  'Encounter',
  'AllergyIntolerance',
  'Condition',
  'Procedure',
  'MedicationRequest',
  'Observation',
  'DiagnosticReport',
  'Immunization',
  'CarePlan',
  'Goal',
  'DocumentReference',
  'Media',
  'Patient',
  'Practitioner',
  'Organization',
  'Location',
];

const Map<String, String> fhirResourceTypeDisplayNames = {
  'AllergyIntolerance': 'Allergy',
  'MedicationRequest': 'Medication request',
  'DiagnosticReport': 'Diagnostic report',
  'DocumentReference': 'Document reference',
  'CarePlan': 'Care plan',
};

String getFhirResourceDisplay(String resourceType) {
  return fhirResourceTypeDisplayNames[resourceType] ?? resourceType;
}
