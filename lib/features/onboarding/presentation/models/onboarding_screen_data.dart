import 'package:flutter/material.dart';

class OnboardingScreenData {
  final String title;
  final String subtitle;
  final String description;
  final IconData icon;
  final bool showScanButton;
  final bool showBiometricToggle;

  const OnboardingScreenData({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.icon,
    this.showScanButton = false,
    this.showBiometricToggle = false,
  });
}
