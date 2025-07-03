import 'package:flutter/material.dart';

class RecentRecord {
  final String title;
  final String doctor;
  final String date;
  final String tag;
  final Color tagBackgroundColor;
  final Color tagTextColor;
  final String? status;
  final Color? statusColor;

  const RecentRecord({
    required this.title,
    required this.doctor,
    required this.date,
    required this.tag,
    required this.tagBackgroundColor,
    required this.tagTextColor,
    this.status,
    this.statusColor,
  });
}
