import 'package:phonebook/Services/SharedPref.dart';
import 'package:phonebook/Services/utils.dart';
import 'package:phonebook/core/scoped_models/home_model.dart';
import 'package:phonebook/enums/view_state.dart';
import 'package:phonebook/themeConfig.dart';
import 'package:phonebook/ui/views/base_view.dart';
import 'package:flutter/material.dart';
import 'package:phonebook/ui/widgets/formInputField.dart';
import 'package:phonebook/validators/validators.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../service_locator.dart';
import 'login_view.dart';

class HomeView extends StatelessWidget {
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
                  // Navigator.of(context).pushNamed('login');
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
            children: <Widget>[
              InputField(
                validationHandler: emailValidator,
                onSaveHandler: ((value) => print(value)),
                hintText: 'Search',
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed('addContact');
          },
          child: Icon(Icons.add),
          backgroundColor: primaryColor,
        ),
      ),
    );
  }
}
