import 'package:flutter/services.dart';

class TextFieldDescriptor {
  TextFieldDescriptor({
    required this.label,
    required this.value,
    required this.confidenceLevel,
    this.validators,
    this.inputFormatters,
    this.keyboardType,
  });

  final String label;
  final String value;
  final double confidenceLevel;
  final List<String? Function(String?)>? validators;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;

  String? validate(String? value) {
    if (validators == null || validators!.isEmpty) {
      return null;
    }
    for (var validator in validators!) {
      String? message = validator(value);

      if (message != null) {
        return message;
      }
    }

    return null;
  }
}
