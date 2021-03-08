import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final Function validationHandler;
  final Function onSaveHandler;

  final String hintText;
  final bool hideText;
  const InputField(
      {this.validationHandler,
      this.onSaveHandler,
      this.hintText,
      this.hideText = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validationHandler,
      onSaved: onSaveHandler,
      obscureText: hideText,
      style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: hintText,
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
    );
  }
}
