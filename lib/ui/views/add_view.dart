import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phonebook/Services/SharedPref.dart';
import 'package:phonebook/core/scoped_models/home_model.dart';
import 'package:phonebook/ui/widgets/formInputField.dart';
import 'package:phonebook/ui/widgets/multiFields.dart';
import 'package:phonebook/validators/validators.dart';

import '../../service_locator.dart';
import '../../themeConfig.dart';
import 'base_view.dart';

class AddContact extends StatefulWidget {
  @override
  _AddContactState createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  final SharedPrefs sharedPrefs = locator<SharedPrefs>();
  @override
  Widget build(BuildContext context) {
    return BaseView<HomeModel>(
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
              child: Column(
                children: [
                  Text(
                    "Add New Contact",
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 15.0),
                  InputField(
                    validationHandler: textValidator,
                    onSaveHandler: ((value) => print(value)),
                    hintText: "Full Name",
                  ),
                  SizedBox(height: 15.0),
                  InputField(
                    validationHandler: textValidator,
                    onSaveHandler: ((value) => print(value)),
                    hintText: "Address",
                  ),
                  SizedBox(height: 15.0),
                  Row(
                    children: [
                      Expanded(
                        child: InputField(
                          validationHandler: textValidator,
                          onSaveHandler: ((value) => print(value)),
                          hintText: "Address",
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.add,
                          size: 35.0,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  )
                ],
              ),
            )));
  }
}
