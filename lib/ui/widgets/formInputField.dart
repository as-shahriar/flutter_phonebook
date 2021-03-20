import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final Function validationHandler;
  final Function onSaveHandler;

  final String hintText;
  final bool hideText;
  final String value;
  const InputField(
      {this.validationHandler,
      this.onSaveHandler,
      this.hintText,
      this.value,
      this.hideText = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: value,
      validator: validationHandler,
      onSaved: onSaveHandler,
      obscureText: hideText,
      decoration: InputDecoration(
        labelText: hintText,
        border: OutlineInputBorder(),
      ),
    );
  }
}
