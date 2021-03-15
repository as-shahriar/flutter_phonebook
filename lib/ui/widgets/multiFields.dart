import 'package:flutter/material.dart';

import 'formInputField.dart';

class MultiField extends StatelessWidget {
  final Function validationHandler;
  final Function onSaveHandler;
  final Function validator;

  final String hintText;
  final bool hideText;
  const MultiField(
      {this.validationHandler,
      this.onSaveHandler,
      this.hintText,
      this.validator,
      this.hideText = false});

  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
      InputField(
        validationHandler: validator,
        onSaveHandler: ((value) => print(value)),
        hintText: "Full Name",
      ),
      IconButton(
        icon: Icon(
          Icons.add,
          size: 30.0,
        ),
        onPressed: () {},
      ),
    ]);
  }
}
