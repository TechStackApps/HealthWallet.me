import 'package:flutter/material.dart';

class VitalSign {
  final Widget? icon;
  final String title;
  final String value;
  final String unit;
  final String status;

  const VitalSign({
    this.icon,
    required this.title,
    required this.value,
    required this.unit,
    required this.status,
  });
}
