String? notEmptyValidator(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'This field is required.';
  }
  return null;
}

String? emailValidator(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'This field is required.';
  } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
    return 'Please enter a valid email address.';
  }
  return null;
}

String? phoneNumberValidator(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'This field is required.';
  } else if (!RegExp(r'^\d{10}$').hasMatch(value)) {
    return 'Please enter a valid 10 digit phone number.';
  }
  return null;
}

String? alphanumericValidator(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'This field is required.';
  } else if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(value)) {
    return 'Please enter only letters and numbers.';
  }
  return null;
}

String? alphanumericWithSpaceValidator(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'This field is required.';
  } else if (!RegExp(r'^[a-zA-Z0-9 ]+$').hasMatch(value)) {
    return 'Please enter only letters, numbers and spaces.';
  }
  return null;
}

String? alphanumericWithSpecialCharsValidator(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'This field is required.';
  } else if (!RegExp(r'^[a-zA-Z0-9!@#\$&*~%^()\\/\-+,._\"\[\]{} ]+$')
      .hasMatch(value)) {
    return 'Please enter only letters, numbers, spaces and special characters.';
  }
  return null;
}

String? pincodeValidator(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'This field is required.';
  } else if (!RegExp(r'^\d{6}$').hasMatch(value)) {
    return 'Please enter a valid 6 digit pincode.';
  }
  return null;
}

String? fiveDigitValidator(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'This field is required.';
  } else if (!RegExp(r'^\d{5}$').hasMatch(value)) {
    return 'Please enter a valid 5 digit code.';
  }
  return null;
}

String? bankAccountNumberValidator(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'This field is required.';
  } else if (!RegExp(r'^[0-9]{9,18}$').hasMatch(value)) {
    return 'Please enter a valid Indian bank account number.';
  }
  return null;
}

String? ifscCodeValidator(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'This field is required.';
  } else if (!RegExp(r'^[A-Z]{4}[0][a-zA-Z0-9]{6}$').hasMatch(value)) {
    return 'Please enter a valid Indian bank IFSC code.';
  }
  return null;
}

String? confirmPasswordValidator(String? value, String? password) {
  if (value == null || value.trim().isEmpty) {
    return 'This field is required.';
  } else if (value != password) {
    return 'Passwords do not match.';
  }
  return null;
}

String? passwordValidator(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'This field is required.';
  }

  if (value.length < 8) {
    return 'Password should be at least 8 characters long.';
  }

  if (!RegExp(r'^(?=.*[a-z])').hasMatch(value)) {
    return 'Password should contain at least one lowercase letter.';
  }

  if (!RegExp(r'^(?=.*[A-Z])').hasMatch(value)) {
    return 'Password should contain at least one uppercase letter.';
  }

  if (!RegExp(r'^(?=.*\d)').hasMatch(value)) {
    return 'Password should contain at least one number.';
  }

  if (!RegExp(r'^(?=.*[@$!%*?&])').hasMatch(value)) {
    return 'Password should contain at least one special character.';
  }

  return null;
}

String? alphabeticWithSpaceValidator(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'This field is required.';
  } else if (!RegExp(r'^[a-zA-Z ]*$').hasMatch(value)) {
    return 'Please enter alphabetic characters only.';
  }
  return null;
}

String? numericValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter some text';
  }
  final RegExp nameExp = RegExp(r'^[0-9]+$');
  if (!nameExp.hasMatch(value)) {
    return 'Please enter only numeric characters';
  }
  return null;
}

String? decimalValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter some text';
  }
  final RegExp nameExp = RegExp(r'^\d+(\.\d+)?$');
  if (!nameExp.hasMatch(value)) {
    return 'Please enter a valid number';
  }
  return null;
}
