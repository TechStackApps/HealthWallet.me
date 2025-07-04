import 'package:flutter/material.dart';
import 'package:health_wallet/core/config/clinical_data_tags.dart';
import 'package:health_wallet/core/theme/app_color.dart';
import 'package:health_wallet/features/home/domain/entities/recent_record.dart';
import 'package:health_wallet/features/home/domain/entities/vital_sign.dart';
import 'package:health_wallet/features/records/domain/entity/fhir_resource.dart';

class MockData {
  static final List<FhirResource> allergies = [
    const FhirResource(
      id: '1',
      resourceType: 'AllergyIntolerance',
      resource: {
        'clinicalStatus': 'active',
        'verificationStatus': 'confirmed',
        'code': {'text': 'Peanuts'}
      },
    ),
    const FhirResource(
      id: '2',
      resourceType: 'AllergyIntolerance',
      resource: {
        'clinicalStatus': 'active',
        'verificationStatus': 'confirmed',
        'code': {'text': 'Penicillin'}
      },
    ),
  ];

  static final List<FhirResource> medications = [
    const FhirResource(
      id: '3',
      resourceType: 'MedicationRequest',
      resource: {
        'medicationCodeableConcept': {'text': 'Lisinopril'},
        'dosageInstruction': [
          {'text': '10mg Once a day'}
        ]
      },
    ),
    const FhirResource(
      id: '4',
      resourceType: 'MedicationRequest',
      resource: {
        'medicationCodeableConcept': {'text': 'Metformin'},
        'dosageInstruction': [
          {'text': '500mg Twice a day'}
        ]
      },
    ),
    const FhirResource(
      id: '5',
      resourceType: 'MedicationRequest',
      resource: {
        'medicationCodeableConcept': {'text': 'Atorvastatin'},
        'dosageInstruction': [
          {'text': '20mg Once a day'}
        ]
      },
    ),
  ];

  static final List<VitalSign> vitalSigns = [
    const VitalSign(
      icon: Icons.favorite_border,
      title: 'Heart Rate',
      value: '72',
      unit: 'BPM',
      status: 'Normal',
    ),
    const VitalSign(
      icon: Icons.show_chart,
      title: 'Blood Pressure',
      value: '140/90',
      unit: 'mmHg',
      status: 'High',
    ),
    const VitalSign(
      icon: Icons.thermostat_outlined,
      title: 'Temperature',
      value: '101.2',
      unit: '°F',
      status: 'High',
    ),
    const VitalSign(
      icon: Icons.waves_outlined,
      title: 'Blood Oxygen',
      value: '92',
      unit: '%',
      status: 'Low',
    ),
  ];

  static final List<RecentRecord> recentRecords = [
    const RecentRecord(
      title: 'Annual Physical Exam',
      doctor: 'Dr. Sarah Johnson',
      date: 'March 15, 2024',
      tag: ClinicalDataTags.checkup,
      tagBackgroundColor: AppColors.tagCheckupBackground,
      tagTextColor: AppColors.tagCheckupText,
      status: 'Completed',
      statusColor: AppColors.tagCompletedText,
    ),
    const RecentRecord(
      title: 'Blood Work Results',
      doctor: 'Dr. Michael Chen',
      date: 'March 10, 2024',
      tag: ClinicalDataTags.labResult,
      tagBackgroundColor: AppColors.tagLabResultsBackground,
      tagTextColor: AppColors.tagLabResultsText,
      status: 'Reviewed',
      statusColor: AppColors.primaryBlue,
    ),
    const RecentRecord(
      title: 'Cardiology Consultation',
      doctor: 'Dr. Emily Rodriguez',
      date: 'February 28, 2024',
      tag: ClinicalDataTags.specialtyVisit,
      tagBackgroundColor: AppColors.tagSpecialtyVisitBackground,
      tagTextColor: AppColors.tagSpecialtyVisitText,
      status: 'Follow-up Needed',
      statusColor: AppColors.tagFollowUpNeededText,
    ),
  ];
}
