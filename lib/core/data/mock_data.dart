import 'package:flutter/material.dart';
import 'package:health_wallet/core/config/clinical_data_tags.dart';
import 'package:health_wallet/core/theme/app_color.dart';
import 'package:health_wallet/features/records/domain/entity/allergy/allergy.dart';
import 'package:health_wallet/features/records/data/dto/records_entry_dto.dart';
import 'package:health_wallet/features/home/domain/entities/overview_card.dart';
import 'package:health_wallet/features/home/domain/entities/recent_record.dart';
import 'package:health_wallet/features/home/domain/entities/vital_sign.dart';
import 'package:health_wallet/features/records/domain/entity/condition/condition.dart';
import 'package:health_wallet/features/records/domain/entity/immunization/immunization.dart';
import 'package:health_wallet/features/records/domain/entity/lab_result/lab_result.dart';
import 'package:health_wallet/features/records/domain/entity/medication/medication.dart';
import 'package:health_wallet/features/records/domain/entity/procedure/procedure.dart';

class MockData {
  static final List<Allergy> allergies = [
    const Allergy(
      dateRecorded: '2023-05-20',
      allergyType: 'Food',
      allergicTo: 'Peanuts',
      reaction: 'Anaphylaxis',
      onset: 'Childhood',
      resolutionAge: null,
    ),
    const Allergy(
      dateRecorded: '2022-09-12',
      allergyType: 'Medication',
      allergicTo: 'Penicillin',
      reaction: 'Hives',
      onset: 'Adulthood',
      resolutionAge: null,
    ),
  ];

  static final List<Medication> medications = [
    const Medication(
      name: 'Lisinopril',
      dosage: '10mg',
      frequency: 'Once a day',
    ),
    const Medication(
      name: 'Metformin',
      dosage: '500mg',
      frequency: 'Twice a day',
    ),
    const Medication(
      name: 'Atorvastatin',
      dosage: '20mg',
      frequency: 'Once a day',
    ),
    const Medication(
      name: 'Amlodipine',
      dosage: '5mg',
      frequency: 'Once a day',
    ),
    const Medication(
      name: 'Omeprazole',
      dosage: '20mg',
      frequency: 'Once a day',
    ),
  ];

  static final List<RecordsEntryDto> otherEntries = [
    RecordsEntryDto(
      icon: Icons.medical_services_outlined,
      title: 'Annual Physical Exam',
      date: '2024-03-15',
      description: 'Comprehensive annual health screening',
      doctors: ['Dr. Sarah Johnson', 'Dr. Mark Thompson'],
      location: 'Downtown Medical Center',
      tag: ClinicalDataTags.checkup,
      tagBgColor: AppColors.tagCheckupBackground,
      tagTextColor: AppColors.tagCheckupText,
    ),
    RecordsEntryDto(
      icon: Icons.bar_chart,
      title: 'Blood Work Results',
      date: '2024-03-10',
      description: 'Complete metabolic panel and lipid screening',
      doctors: ['Dr. Michael Chen'],
      location: 'Central Lab Services',
      tag: ClinicalDataTags.labResult,
      tagBgColor: AppColors.tagLabResultsBackground,
      tagTextColor: AppColors.tagLabResultsText,
    ),
    RecordsEntryDto(
      icon: Icons.favorite_border,
      title: 'Cardiology Consultation',
      date: '2024-02-28',
      description: 'Follow-up consultation for cardiac health',
      doctors: ['Dr. Emily Rodriguez', 'Dr. James Wilson'],
      location: 'Heart & Vascular Institute',
      tag: ClinicalDataTags.specialtyVisit,
      tagBgColor: AppColors.tagSpecialtyVisitBackground,
      tagTextColor: AppColors.tagSpecialtyVisitText,
    ),
    RecordsEntryDto(
      icon: Icons.healing_outlined,
      title: 'Dermatology Screening',
      date: '2024-01-22',
      description: 'Annual skin cancer screening',
      doctors: ['Dr. Lisa Park'],
      location: 'Skin Health Clinic',
      tag: ClinicalDataTags.preventiveCare,
      tagBgColor: AppColors.tagPreventiveCareBackground,
      tagTextColor: AppColors.tagPreventiveCareText,
    ),
    RecordsEntryDto(
      icon: Icons.local_hospital_outlined,
      title: 'Emergency Room Visit',
      date: '2023-12-18',
      description: 'Treatment for minor injury - left ankle sprain',
      doctors: ['Dr. Robert Kim', 'Dr. Amanda Foster'],
      location: 'General Hospital ER',
      tag: ClinicalDataTags.emergency,
      tagBgColor: AppColors.tagEmergencyBackground,
      tagTextColor: AppColors.tagEmergencyText,
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

  static final List<Condition> conditions = [];
  static final List<Immunization> immunizations = [];
  static final List<LabResult> labResults = [];
  static final List<Procedure> procedures = [];
}
