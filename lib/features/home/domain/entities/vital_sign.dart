import 'package:flutter/material.dart';

class VitalSign {
  final IconData icon;
  final String title;
  final String value;
  final String unit;
  final String status;

  const VitalSign({
    required this.icon,
    required this.title,
    required this.value,
    required this.unit,
    required this.status,
  });
}
