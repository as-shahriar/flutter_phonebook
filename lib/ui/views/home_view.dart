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
    var myAppModel = locator<HomeModel>();
    if (!myAppModel.loaded) myAppModel.getContacts(Utils.getUserID());
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
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed('details',
                        arguments: model.contacts[index].contact.contact_id);
                  },
                  child: Card(
                    elevation: 0.0,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 25.0,
                            backgroundColor: Utils.randomColorPicker().shade200,
                            child: model.contacts[index].contact.picture != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Image.memory(
                                      model.contacts[index].contact.picture,
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : Text(
                                    (model.contacts[index].contact.name
                                                .length !=
                                            0)
                                        ? model.contacts[index].contact.name[0]
                                            .toUpperCase()
                                        : '?',
                                    style: TextStyle(
                                      fontSize: 30.0,
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Container(
                              width: 140.0,
                              child: Text(
                                model.contacts[index].contact.name,
                                // textAlign: TextAlign.start,
                                style: TextStyle(fontSize: 15.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
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
