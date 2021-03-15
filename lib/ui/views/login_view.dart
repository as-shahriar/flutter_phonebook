import 'package:flutter/gestures.dart';
import 'package:phonebook/core/scoped_models/auth_model.dart';
import 'package:phonebook/ui/views/base_view.dart';
import 'package:flutter/material.dart';
import 'package:phonebook/ui/widgets/formInputField.dart';
import 'package:phonebook/ui/widgets/submit_button.dart';
import 'package:phonebook/utils/database_helper.dart';
import 'package:phonebook/validators/validators.dart';
import '../../service_locator.dart';
import '../../themeConfig.dart';
import 'package:phonebook/Services/SharedPref.dart';

class LoginView extends StatelessWidget {
  final SharedPrefs sharedPrefs = locator<SharedPrefs>();
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
                      SizedBox(
                        height: 35.0,
                      ),
                      SubmitButton(
                        text: "Login",
                        validationHandler: () async {
                          if (_formKey.currentState.validate()) {
                            // If the form is valid, display a Snackbar.
                            _formKey.currentState.save();
                            int userID = await model.login();
                            if (userID >= 0) {
                              sharedPrefs
                                  .storeInSharedPrefs({'userId': userID});
                              Navigator.of(context).pushNamed('home');
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text('Invalid Credantials.'),
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
                                text: "Don't have an account? ",
                                style: TextStyle(color: Colors.black),
                                children: [
                                  TextSpan(
                                      text: "Sign Up",
                                      style: TextStyle(color: Colors.blue),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () => Navigator.of(context)
                                            .pushNamed('signUp')),
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
