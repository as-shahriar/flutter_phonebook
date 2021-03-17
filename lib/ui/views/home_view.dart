import 'package:phonebook/Services/SharedPref.dart';
import 'package:phonebook/Services/utils.dart';
import 'package:phonebook/core/models/contact.dart';
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

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final SharedPrefs sharedPrefs = locator<SharedPrefs>();
  List<Contact> contacts = [];
  @override
  Widget build(BuildContext context) {
    var myAppModel = locator<HomeModel>();
    myAppModel.getContacts(Utils.getUserID());
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
            return Card(
                child: ListTile(
              title: Text('${index}'),
            ));
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            print("Number of contact ${myAppModel.contacts.length}");
            Navigator.of(context).pushNamed('addContact');
          },
          child: Icon(Icons.add),
          backgroundColor: primaryColor,
        ),
      ),
    );
  }

  Widget _contactCard(BuildContext context, int index) {
    var myAppModel = locator<HomeModel>();
    print(myAppModel.contacts[index].contact.name);
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(myAppModel.contacts[index].contact.name ?? '',
              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold)),
          Text(myAppModel.contacts[index].contact.address ?? '',
              style: TextStyle(fontSize: 16.0)),
          // Text(
          //   contacts[index].phone ?? '',
          //   style: TextStyle(fontSize: 18.0)),
        ],
      ),
    );
  }
}
