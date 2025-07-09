class ClinicalDataTags {
  static const String allergy = 'Allergy';
  static const String medication = 'Medication';
  static const String condition = 'Condition';
  static const String immunization = 'Immunization';
  static const String labResult = 'Lab Result';
  static const String procedure = 'Procedure';
  static const String checkup = 'Checkup';
  static const String specialtyVisit = 'Specialty Visit';
  static const String preventiveCare = 'Preventive Care';
  static const String emergency = 'Emergency';

  static const Map<String, String> resourceTypeMap = {
    allergy: 'AllergyIntolerance',
    medication: 'MedicationRequest',
    condition: 'Condition',
    immunization: 'Immunization',
    labResult: 'Observation',
    procedure: 'Procedure',
  };
}
