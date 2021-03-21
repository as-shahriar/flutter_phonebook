import 'package:flutter/gestures.dart';
import 'package:phonebook/core/scoped_models/auth_model.dart';
import 'package:phonebook/ui/views/base_view.dart';
import 'package:flutter/material.dart';
import 'package:phonebook/ui/widgets/formInputField.dart';
import 'package:phonebook/ui/widgets/submit_button.dart';
import 'package:phonebook/utils/database_helper.dart';
import 'package:phonebook/validators/validators.dart';

import '../../themeConfig.dart';
import 'login_view.dart';

class SignupView extends StatelessWidget {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  final _formKey = GlobalKey<FormState>();
  DatabaseHelper _databaseHelper = DatabaseHelper.instance;
  String email;
  String pass;

  @override
  Widget build(BuildContext context) {
    return BaseView<AuthnModel>(
        builder: (context, child, model) => Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(36.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.lock, size: 48.0, color: primaryColor),
                          Text(
                            "Sign Up",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 35,
                                color: primaryColor),
                          ),
                        ],
                      ),
                      SizedBox(height: 25.0),
                      InputField(
                        validationHandler: emailValidator,
                        onSaveHandler: ((value) => model.setEmail(value)),
                        hintText: "Email",
                      ),
                      SizedBox(height: 25.0),
                      InputField(
                        validationHandler: passValidator,
                        onSaveHandler: ((value) => model.setPassword(value)),
                        hintText: 'Password',
                        hideText: true,
                      ),
                      SizedBox(
                        height: 35.0,
                      ),
                      SubmitButton(
                        text: "Sign Up",
                        validationHandler: () async {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            if (await model.uniqueEmail()) {
                              model.insertUser();
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  'login', (Route<dynamic> route) => false);
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text('Email Address Already Exists.'),
                                backgroundColor: Colors.red[300],
                              ));
                            }
                          }
                        },
                      ),
                      SizedBox(
                        height: 28.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RichText(
                            text: TextSpan(
                                text: "Back to ",
                                style: TextStyle(color: Colors.black),
                                children: [
                                  TextSpan(
                                      text: "Login",
                                      style: TextStyle(color: Colors.blue),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () => Navigator.of(context)
                                            .pushNamed('login')),
                                ]),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ));
  }
}
