import 'package:phonebook/core/scoped_models/auth_model.dart';
import 'package:phonebook/ui/views/base_view.dart';
import 'package:flutter/material.dart';
import 'package:phonebook/ui/widgets/formInputField.dart';
import 'package:phonebook/ui/widgets/submit_button.dart';
import 'package:phonebook/utils/database_helper.dart';
import 'package:phonebook/validators/validators.dart';

import '../../themeConfig.dart';

class LoginView extends StatelessWidget {
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
                            "Login",
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
                      Text(model.getPassword()),
                      SizedBox(
                        height: 35.0,
                      ),
                      SubmitButton(
                        validationHandler: () async {
                          if (_formKey.currentState.validate()) {
                            // If the form is valid, display a Snackbar.
                            _formKey.currentState.save();
                            model.insertUser();
                            model.getUsers();
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text('OK'),
                                backgroundColor: primaryColor));
                            // await _databaseHelper.insertUser(user);
                            // print(email);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }
}
