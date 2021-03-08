import 'package:flutter/material.dart';

import '../../themeConfig.dart';

class SubmitButton extends StatelessWidget {
  final Function validationHandler;
  final String text;

  const SubmitButton({this.validationHandler, this.text});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(10.0),
      color: primaryColor,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: validationHandler,
        child: Text(text,
            textAlign: TextAlign.center,
            style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0)
                .copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
