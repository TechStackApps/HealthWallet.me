import 'package:flutter/material.dart';

class RecordsEntry {
  final IconData icon;
  final String title;
  final String date;
  final String description;
  final List<String> doctors;
  final String location;
  final String tag;
  final Color tagBgColor;
  final Color tagTextColor;

  RecordsEntry({
    required this.icon,
    required this.title,
    required this.date,
    required this.description,
    required this.doctors,
    required this.location,
    required this.tag,
    required this.tagBgColor,
    required this.tagTextColor,
  });
}
