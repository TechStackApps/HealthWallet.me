import 'package:health_wallet/features/home/domain/entities/vital_sign.dart';

class MockData {
  static const List<VitalSign> vitalSigns = [
    VitalSign(
      title: 'Heart Rate',
      value: '72',
      unit: 'BPM',
      status: 'Normal',
    ),
    VitalSign(
      title: 'Blood Pressure',
      value: '140/90',
      unit: 'mmHg',
      status: 'High',
    ),
    VitalSign(
      title: 'Temperature',
      value: '101.2',
      unit: '°F',
      status: 'High',
    ),
    VitalSign(
      title: 'Blood Oxygen',
      value: '92',
      unit: '%',
      status: 'Low',
    ),
  ];
}
