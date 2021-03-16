import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phonebook/Services/SharedPref.dart';
import 'package:phonebook/Services/utils.dart';
import 'package:phonebook/core/scoped_models/add_model.dart';
import 'package:phonebook/ui/widgets/formInputField.dart';
import 'package:phonebook/ui/widgets/submit_button.dart';
import 'package:phonebook/validators/validators.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../service_locator.dart';
import '../../themeConfig.dart';
import 'base_view.dart';

class AddContact extends StatefulWidget {
  @override
  _AddContactState createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  final _formKey = GlobalKey<FormState>();

  final SharedPrefs sharedPrefs = locator<SharedPrefs>();
  @override
  Widget build(BuildContext context) {
    return BaseView<AddContactModel>(
        builder: (context, child, model) => Scaffold(
            appBar: AppBar(
              title: Text('PhoneBook'),
              backgroundColor: primaryColor,
              actions: <Widget>[
                PopupMenuButton<String>(
                  onSelected: (String choice) {
                    if (choice == 'Logout') {
                      sharedPrefs.removeSharedPrefs();
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          'login', (Route<dynamic> route) => false);
                    }
                  },
                  itemBuilder: (BuildContext context) {
                    return {'Logout'}.map((String choice) {
                      return PopupMenuItem<String>(
                        value: choice,
                        child: Text(choice),
                      );
                    }).toList();
                  },
                ),
              ],
            ),
            body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Text(
                        "Add New Contact",
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(height: 15.0),
                      InputField(
                        validationHandler: textValidator,
                        onSaveHandler: ((value) => model.setName(value)),
                        hintText: "Full Name",
                      ),
                      SizedBox(height: 15.0),
                      InputField(
                        validationHandler: textValidator,
                        onSaveHandler: ((value) => model.setAddress(value)),
                        hintText: "Address",
                      ),
                      SizedBox(height: 15.0),
                      InputField(
                        validationHandler: emailValidator,
                        onSaveHandler: ((value) => model.setEmail(value)),
                        hintText: "Email Address",
                      ),
                      SizedBox(height: 15.0),
                      InputField(
                        validationHandler: textValidator,
                        onSaveHandler: ((value) => model.setNumber(value)),
                        hintText: "Mobile No.",
                      ),
                      SizedBox(height: 15.0),
                      SubmitButton(
                        text: "Save",
                        validationHandler: () async {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            int userID = await Utils.getUserID();
                            if (userID != -1) {
                              model.addContact(userID);
                              print("Added to DB");
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Invalid Credantials.'),
                              backgroundColor: Colors.red[300],
                            ));
                          }
                        },
                      ),
                    ],
                  ),
                ))));
  }

  Future<int> _getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int user = (prefs.getInt('userID') ?? -1);
    return user;
  }
}
