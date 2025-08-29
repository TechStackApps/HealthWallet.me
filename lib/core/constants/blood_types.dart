// lib/core/constants/blood_types.dart
class BloodTypes {
  // LOINC Codes - USA FHIR Standards
  static const String aboLoincCode = '883-9'; // ABO group [Type] in Blood
  static const String rhLoincCode = '10331-7'; // Rh [Type] in Blood
  static const String combinedLoincCode =
      '34530-6'; // ABO and Rh group [Type] in Blood - USA standard

  // Blood Type Values
  static const List<String> aboTypes = ['A', 'B', 'AB', 'O'];
  static const List<String> rhTypes = ['+', '-'];
  static const List<String> allBloodTypes = [
    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-',
    'O+',
    'O-'
  ];

  // SNOMED CT Codes - Updated based on Swiss FHIR Profile
  static const Map<String, String> snomedCodes = {
    'A+': '278149003', // Blood group A Rh(D) positive
    'A-': '278150003', // Blood group A Rh(D) negative
    'B+': '278151004', // Blood group B Rh(D) positive
    'B-': '278152006', // Blood group B Rh(D) negative
    'AB+': '278153001', // Blood group AB Rh(D) positive
    'AB-': '278154007', // Blood group AB Rh(D) negative
    'O+': '278155008', // Blood group O Rh(D) positive
    'O-': '278156009', // Blood group O Rh(D) negative
  };

  // Component-based SNOMED CT Codes (Swiss FHIR Profile)
  static const Map<String, String> aboComponentSnomedCodes = {
    'A': '165743006', // Blood group A (finding)
    'B': '165744000', // Blood group B (finding)
    'AB': '165743006', // Blood group AB (finding)
    'O': '165744000', // Blood group O (finding)
  };

  static const Map<String, String> rhComponentSnomedCodes = {
    '+': '165747007', // RhD positive (finding)
    '-': '165748002', // RhD negative (finding)
  };

  // Display Names
  static const Map<String, String> displayNames = {
    'A+': 'A positive',
    'A-': 'A negative',
    'B+': 'B positive',
    'B-': 'B negative',
    'AB+': 'AB positive',
    'AB-': 'AB negative',
    'O+': 'O positive',
    'O-': 'O negative',
  };

  // Component Display Names (Swiss FHIR Profile)
  static const Map<String, String> aboComponentDisplayNames = {
    'A': 'Blood group A (finding)',
    'B': 'Blood group B (finding)',
    'AB': 'Blood group AB (finding)',
    'O': 'Blood group O (finding)',
  };

  static const Map<String, String> rhComponentDisplayNames = {
    '+': 'RhD positive (finding)',
    '-': 'RhD negative (finding)',
  };

  // FHIR Display Text Mapping
  static const Map<String, String> fhirDisplayMapping = {
    'Blood group A Rh(D) positive': 'A+',
    'Blood group A Rh(D) negative': 'A-',
    'Blood group B Rh(D) positive': 'B+',
    'Blood group B Rh(D) negative': 'B-',
    'Blood group AB Rh(D) positive': 'AB+',
    'Blood group AB Rh(D) negative': 'AB-',
    'Blood group O Rh(D) positive': 'O+',
    'Blood group O Rh(D) negative': 'O-',
    // Variations
    'A Rh(D) positive': 'A+',
    'A Rh(D) negative': 'A-',
    'B Rh(D) positive': 'B+',
    'B Rh(D) negative': 'B-',
    'AB Rh(D) positive': 'AB+',
    'AB Rh(D) negative': 'AB-',
    'O Rh(D) positive': 'O+',
    'O Rh(D) negative': 'O-',
  };

  // Utility Methods
  static List<String> getAllBloodTypes() => allBloodTypes;

  static String getDisplayName(String bloodType) =>
      displayNames[bloodType] ?? bloodType;

  static String getSnomedCode(String bloodType) =>
      snomedCodes[bloodType] ?? '278149003';

  static String? getBloodTypeFromFhirDisplay(String fhirDisplay) =>
      fhirDisplayMapping[fhirDisplay];

  static bool isValidBloodType(String bloodType) =>
      allBloodTypes.contains(bloodType);

  // Component-based methods (Swiss FHIR Profile)
  static String getAboComponent(String bloodType) {
    if (bloodType.isNotEmpty) {
      final abo = bloodType.substring(0, bloodType.length - 1);
      if (abo == 'AB') return 'AB';
      return abo;
    }
    return 'A'; // default
  }

  static String getRhComponent(String bloodType) {
    if (bloodType.isNotEmpty) {
      return bloodType.substring(bloodType.length - 1);
    }
    return '+'; // default
  }

  static String getAboComponentSnomedCode(String bloodType) {
    final abo = getAboComponent(bloodType);
    return aboComponentSnomedCodes[abo] ?? '165743006';
  }

  static String getRhComponentSnomedCode(String bloodType) {
    final rh = getRhComponent(bloodType);
    return rhComponentSnomedCodes[rh] ?? '165747007';
  }

  static String getAboComponentDisplayName(String bloodType) {
    final abo = getAboComponent(bloodType);
    return aboComponentDisplayNames[abo] ?? 'Blood group A (finding)';
  }

  static String getRhComponentDisplayName(String bloodType) {
    final rh = getRhComponent(bloodType);
    return rhComponentDisplayNames[rh] ?? 'RhD positive (finding)';
  }

  // Swiss FHIR Profile specific constants
  static const String swissProfileUrl =
      'http://fhir.ch/ig/ch-lab-report/StructureDefinition/ChLab-observation-single-test';
  static const String bloodBankingCategoryCode = '421661004';
  static const String bloodBankingCategoryDisplay =
      'Blood banking and transfusion medicine (specialty) (qualifier value)';
  static const String bloodBankStudiesCode = '18717-9';
  static const String bloodBankStudiesDisplay = 'Blood bank studies (set)';
  static const String serotypingMethodCode = '258075003';
  static const String serotypingMethodDisplay = 'Serotyping (qualifier value)';
}
