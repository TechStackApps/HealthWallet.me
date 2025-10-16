import 'package:flutter/services.dart';

class TextFieldDescriptor {
  TextFieldDescriptor({
    required this.label,
    required this.value,
    this.validator,
    this.inputFormatters,
    this.keyboardType,
  });

  final String label;
  final String value;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
}
