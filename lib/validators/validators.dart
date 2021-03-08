String emailValidator(value) {
  return null;
  if (!value.isEmpty &&
      RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+"
              r"@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(value)) {
    return null;
  }
  return 'Please enter valid email';
}

String passValidator(value) {
  return null;
  if (value.isEmpty) {
    return 'Password can\'t be empty';
  }
  if (value.length < 8) {
    return 'Password can\'t be less than 8 characters';
  }
  return null;
}
