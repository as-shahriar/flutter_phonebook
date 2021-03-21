String emailValidator(value) {
  if (!value.isEmpty &&
      RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+"
              r"@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(value)) {
    return null;
  }
  return 'Please enter valid email';
}

String passValidator(value) {
  if (value.isEmpty) {
    return 'Password can\'t be empty';
  }
  if (value.length < 8) {
    return 'Password can\'t be less than 8 characters';
  }
  return null;
}

String textValidator(value) {
  if (value.isEmpty) {
    return 'Field can\'t be empty';
  }

  return null;
}

String numberValidator(value) {
  if (value.isEmpty)
    return 'Field can\'t be empty';
  else if (RegExp(r"^(\+8801|01)+[0-9]{9}$").hasMatch(value))
    return null;
  else
    return "Please enter valid number";
}
