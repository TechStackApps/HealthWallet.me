import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_wallet/features/records/domain/entity/records_entry.dart';

part 'records_entry_dto.freezed.dart';

@freezed
class RecordsEntryDto with _$RecordsEntryDto {
  const factory RecordsEntryDto({
    required IconData icon,
    required String title,
    required String date,
    required String description,
    required List<String> doctors,
    required String location,
    required String tag,
    required Color tagBgColor,
    required Color tagTextColor,
  }) = _RecordsEntryDto;

  const RecordsEntryDto._();

  RecordsEntry toEntity() {
    return RecordsEntry(
      icon: icon,
      title: title,
      date: date,
      description: description,
      doctors: doctors,
      location: location,
      tag: tag,
      tagBgColor: tagBgColor,
      tagTextColor: tagTextColor,
    );
  }
}
