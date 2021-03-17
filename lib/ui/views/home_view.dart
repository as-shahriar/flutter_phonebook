import 'dart:math';

import 'package:phonebook/Services/SharedPref.dart';
import 'package:phonebook/Services/utils.dart';
import 'package:phonebook/core/models/contact.dart';
import 'package:phonebook/core/scoped_models/home_model.dart';
import 'package:phonebook/enums/view_state.dart';
import 'package:phonebook/service_locator.dart';
import 'package:phonebook/themeConfig.dart';
import 'package:phonebook/ui/views/base_view.dart';
import 'package:flutter/material.dart';
import 'package:phonebook/ui/widgets/formInputField.dart';
import 'package:phonebook/validators/validators.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_view.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final SharedPrefs sharedPrefs = locator<SharedPrefs>();
  List<Contact> contacts = [];

  @override
  void initState() {
    super.initState();
    // _getAllContacts();
  }

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
        body: ListView.builder(
            itemCount: model.contacts.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 0.0,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          radius: 25.0,
                          backgroundColor: randomColorPicker().shade300,
                          child: Text(
                            model.contacts[index].contact.name[0].toUpperCase(),
                            style: TextStyle(
                              fontSize: 30.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          width: 140.0,
                          child: Text(
                            model.contacts[index].contact.name,
                            // textAlign: TextAlign.start,
                            style: TextStyle(fontSize: 15.0),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: Icon(Icons.call),
                              onPressed: () {},
                              color: Colors.green,
                              padding: EdgeInsets.all(0.0),
                            ),
                            IconButton(
                              icon: Icon(Icons.message),
                              onPressed: () {},
                              color: Colors.lightBlueAccent[400],
                              padding: EdgeInsets.all(0.0),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            print("Number of contact ${model.contacts.length}");
            Navigator.of(context).pushNamed('addContact');
          },
          child: Icon(Icons.add),
          backgroundColor: primaryColor,
        ),
      ),
    );
  }

  MaterialColor randomColorPicker() {
    return Colors.primaries[Random().nextInt(Colors.primaries.length)];
  }
}
