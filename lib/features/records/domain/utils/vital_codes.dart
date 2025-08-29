import 'package:health_wallet/core/constants/blood_types.dart';

const String kLoincHeartRate = '8867-4';
const String kLoincBloodPressurePanel = '85354-9';
const String kLoincBloodPressurePanelAlt = '55284-4';
const String kLoincTemperature = '8310-5';
const String kLoincBloodOxygen = '2708-6';
const String kLoincWeight = '29463-7';
const String kLoincHeight = '8302-2';
const String kLoincBmi = '39156-5';
const String kLoincSystolic = '8480-6';
const String kLoincDiastolic = '8462-4';
const String kLoincRespiratoryRate = '9279-1';
const String kLoincBloodGlucose = '2339-0';
const String kLoincAboBloodGroup = '883-9';
const String kLoincRhBloodGroup = '10331-7';

const Set<String> kVitalLoincCodes = {
  kLoincHeartRate,
  kLoincBloodPressurePanel,
  kLoincBloodPressurePanelAlt,
  kLoincTemperature,
  kLoincBloodOxygen,
  kLoincWeight,
  kLoincHeight,
  kLoincBmi,
  kLoincSystolic,
  kLoincDiastolic,
  kLoincRespiratoryRate,
  kLoincBloodGlucose,
};

final Set<String> kBloodTypeLoincCodes = {
  kLoincAboBloodGroup,
  kLoincRhBloodGroup,
  BloodTypes.combinedLoincCode,
};

const Set<String> kBpPanelCodes = {
  kLoincBloodPressurePanel,
  kLoincBloodPressurePanelAlt,
};

bool isVitalLoinc(String code) => kVitalLoincCodes.contains(code);
bool isBpPanelCode(String code) => kBpPanelCodes.contains(code);
bool isBloodTypeLoinc(String code) => kBloodTypeLoincCodes.contains(code);
