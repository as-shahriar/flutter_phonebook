import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phonebook/Services/SharedPref.dart';
import 'package:phonebook/Services/utils.dart';
import 'package:phonebook/core/models/contact.dart';
import 'package:phonebook/core/scoped_models/details_model.dart';
import 'package:phonebook/service_locator.dart';

import '../../themeConfig.dart';
import 'base_view.dart';

class DetailsView extends StatefulWidget {
  int contactID;
  DetailsView({@required this.contactID}) {}

  @override
  _DetailsViewState createState() => _DetailsViewState();
}

class _DetailsViewState extends State<DetailsView> {
  final _formKey = GlobalKey<FormState>();

  final SharedPrefs sharedPrefs = locator<SharedPrefs>();
  BaseContact user = new BaseContact();

  @override
  void initState() {
    super.initState();
    var myAppModel = locator<DetailsModel>();
    myAppModel.getContactDetails(widget.contactID).then((value) {
      setState(() => user = value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<DetailsModel>(
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
                padding: EdgeInsets.all(16.0),
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  children: [
                    CircleAvatar(
                      radius: 50.0,
                      backgroundColor: Utils.randomColorPicker().shade200,
                      child: user.contact.picture != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.memory(
                                user.contact.picture,
                                width: 100,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Text(
                              (user.contact.name.length != 0)
                                  ? user.contact.name[0].toUpperCase()
                                  : '?',
                              style: TextStyle(
                                fontSize: 30.0,
                                color: Colors.white,
                              ),
                            ),
                    ),
                    Padding(padding: EdgeInsets.symmetric(vertical: 10.0)),
                    Text(
                      user.contact.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30.0,
                      ),
                    ),
                    if (user.contact.address.isNotEmpty)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.home, color: Colors.grey[400]),
                          Text(
                            user.contact.address,
                            style: TextStyle(color: Colors.grey[400]),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    Divider(
                      height: 30,
                    ),
                    Text(
                      "Number",
                      style: TextStyle(color: Colors.grey[400]),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("01719563829"),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                    Divider(
                      height: 30,
                    ),
                    Text(
                      "Email",
                      style: TextStyle(color: Colors.grey[400]),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("asif@gmail.com"),
                        IconButton(
                          icon: Icon(Icons.mail),
                          onPressed: () {},
                          color: Colors.redAccent[400],
                          padding: EdgeInsets.all(0.0),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ));
  }
}
