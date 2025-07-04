import 'package:flutter/material.dart';
import 'package:health_wallet/core/config/clinical_data_tags.dart';
import 'package:health_wallet/core/data/mock_data.dart';
import 'package:health_wallet/core/theme/app_color.dart';
import 'package:health_wallet/features/records/domain/entity/allergy/allergy.dart';
import 'package:health_wallet/features/records/data/dto/records_entry_dto.dart';
import 'package:injectable/injectable.dart';

abstract class RecordsLocalDataSource {
  Future<List<RecordsEntryDto>> getTimelineEntries({String? filter});
  Future<List<RecordsEntryDto>> getTimelineEntriesForAllergy(Allergy allergy);
}

@LazySingleton(as: RecordsLocalDataSource)
class RecordsLocalDataSourceImpl implements RecordsLocalDataSource {
  @override
  Future<List<RecordsEntryDto>> getTimelineEntries({String? filter}) async {
    // Simulate a network delay
    // await Future.delayed(const Duration(seconds: 1));

    final allergyEntries = MockData.allergies
        .map(
          (allergy) => RecordsEntryDto(
            icon: Icons.warning_amber_outlined,
            title: 'Allergy: ${allergy.allergicTo}',
            date: allergy.dateRecorded,
            description: 'Reaction: ${allergy.reaction ?? 'None'}',
            doctors: ['Dr. Self Reported'],
            location: 'Home',
            tag: ClinicalDataTags.allergy,
            tagBgColor: AppColors.tagEmergencyBackground,
            tagTextColor: AppColors.tagEmergencyText,
          ),
        )
        .toList();

    final medicationEntries = MockData.medications
        .map(
          (medication) => RecordsEntryDto(
            icon: Icons.receipt_long,
            title: 'Prescription: ${medication.name}',
            date: '2024-02-15', // This should be dynamic in a real app
            description: '${medication.dosage}, ${medication.frequency}',
            doctors: ['Dr. Sarah Johnson'],
            location: 'Downtown Medical Center',
            tag: ClinicalDataTags.medication,
            tagBgColor: AppColors.tagMedicationBackground,
            tagTextColor: AppColors.tagMedicationText,
          ),
        )
        .toList();

    final allEntries = [
      ...allergyEntries,
      ...medicationEntries,
      ...MockData.otherEntries,
    ];
    allEntries.sort((a, b) => b.date.compareTo(a.date));

    if (filter != null) {
      return allEntries.where((entry) => entry.tag == filter).toList();
    }

    return allEntries;
  }

  @override
  Future<List<RecordsEntryDto>> getTimelineEntriesForAllergy(
    Allergy allergy,
  ) async {
    return getTimelineEntries();
  }
}
