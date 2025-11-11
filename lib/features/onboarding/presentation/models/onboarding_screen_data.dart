import 'package:flutter/material.dart';
import 'package:health_wallet/gen/assets.gen.dart';

class OnboardingScreenData {
  final String title;
  final String subtitle;
  final String description;
  final SvgGenImage image;
  final bool showBiometricToggle;
  final Widget? customWidget; // Custom content for specific screens

  const OnboardingScreenData({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.image,
    this.showBiometricToggle = false,
    this.customWidget,
  });
}
