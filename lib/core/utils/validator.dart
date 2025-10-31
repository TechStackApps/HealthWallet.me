String? nonEmptyValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'This field cannot be empty';
  }
  return null;
}

String? dateValidator(String? value) {
  if (value == null || value.isEmpty) {
    return null;
  }

  if (DateTime.tryParse(value) == null) {
    return 'YYYY-MM-DD';
  }

  return null;
}
