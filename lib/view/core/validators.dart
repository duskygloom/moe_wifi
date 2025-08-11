typedef ValidatorType = String? Function(String? text);

String? emptyValidator(String? text) {
  if (text == null) {
    return 'Cannot be null.';
  } else if (text.isEmpty) {
    return 'Cannot be empty.';
  } else {
    return null;
  }
}

String? numberValidator(String? text, [bool allowEmpty = false]) {
  if (text == null) {
    return 'Cannot be null.';
  } else if (text.isEmpty && !allowEmpty) {
    return 'Cannot be empty.';
  } else if (int.tryParse(text) == null) {
    return 'Must be a number.';
  } else {
    return null;
  }
}
