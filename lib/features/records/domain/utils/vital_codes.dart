const String kLoincHeartRate = '8867-4';
const String kLoincBloodPressurePanel = '85354-9';
const String kLoincBloodPressurePanelAlt = '55284-4';
const String kLoincTemperature = '8310-5';
const String kLoincBloodOxygen = '2708-6';
const String kLoincBloodOxygenPulseOx = '59408-5';
const String kLoincWeight = '29463-7';
const String kLoincHeight = '8302-2';
const String kLoincBmi = '39156-5';
const String kLoincSystolic = '8480-6';
const String kLoincDiastolic = '8462-4';
const String kLoincRespiratoryRate = '9279-1';
const String kLoincBloodGlucose = '2710-2';

const Set<String> kVitalLoincCodes = {
  kLoincHeartRate,
  kLoincBloodPressurePanel,
  kLoincBloodPressurePanelAlt,
  kLoincTemperature,
  kLoincBloodOxygen,
  kLoincBloodOxygenPulseOx,
  kLoincWeight,
  kLoincHeight,
  kLoincBmi,
  kLoincSystolic,
  kLoincDiastolic,
  kLoincRespiratoryRate,
  kLoincBloodGlucose,
};

const Set<String> kBpPanelCodes = {
  kLoincBloodPressurePanel,
  kLoincBloodPressurePanelAlt,
};

bool isVitalLoinc(String code) => kVitalLoincCodes.contains(code);
bool isBpPanelCode(String code) => kBpPanelCodes.contains(code);
