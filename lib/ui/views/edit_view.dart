import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phonebook/Services/SharedPref.dart';
import 'package:phonebook/Services/utils.dart';
import 'package:phonebook/core/models/contact.dart';
import 'package:phonebook/core/scoped_models/ediit_model.dart';
import 'package:phonebook/service_locator.dart';
import 'package:phonebook/ui/views/base_view.dart';
import 'package:phonebook/ui/widgets/formInputField.dart';
import 'package:phonebook/ui/widgets/submit_button.dart';
import 'package:phonebook/validators/validators.dart';

import '../../themeConfig.dart';

class EditView extends StatefulWidget {
  int contactID;
  EditView({@required this.contactID}) {}
  @override
  _EditViewState createState() => _EditViewState();
}

class _EditViewState extends State<EditView> {
  BaseContact user = new BaseContact();
  final SharedPrefs sharedPrefs = locator<SharedPrefs>();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    var myAppModel = locator<EditModel>();
    myAppModel.getContactDetails(widget.contactID).then((value) {
      print("value:");
      print(value.contact.name);
      setState(() => user = value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<EditModel>(
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
                              (user.contact?.name?.length != 0 &&
                                      user.contact.name != null)
                                  ? user.contact.name[0].toUpperCase()
                                  : '?',
                              style: TextStyle(
                                fontSize: 30.0,
                                color: Colors.white,
                              ),
                            ),
                    ),
                    Padding(padding: EdgeInsets.symmetric(vertical: 10.0)),
                    if (user.contact.name != null)
                      InputField(
                        validationHandler: textValidator,
                        onSaveHandler: ((value) => print(value)),
                        hintText: 'Full Name',
                        value: user.contact.name,
                        hideText: false,
                      ),
                    SizedBox(height: 25.0),
                    if (user.contact.address != null)
                      InputField(
                        validationHandler: textValidator,
                        onSaveHandler: ((value) => print(value)),
                        hintText: 'Address',
                        value: user.contact.address,
                        hideText: false,
                      ),
                    SizedBox(
                      height: 28.0,
                    ),
                    Text(
                      "Number",
                      style: TextStyle(color: Colors.grey[400]),
                    ),
                    Column(
                      children: [
                        for (Phone number in user.phones)
                          Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: InputField(
                                      validationHandler: textValidator,
                                      onSaveHandler: ((value) => print(value)),
                                      hintText: 'Mobile No.',
                                      hideText: false,
                                      value: number.phone),
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete,
                                      size: 30.0, color: Colors.grey[400]),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                    SizedBox(
                      height: 28.0,
                    ),
                    Text(
                      "Email",
                      style: TextStyle(color: Colors.grey[400]),
                    ),
                    Column(
                      children: [
                        for (Email email in user.emails)
                          Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: InputField(
                                      validationHandler: textValidator,
                                      onSaveHandler: ((value) => print(value)),
                                      hintText: 'Email Address',
                                      hideText: false,
                                      value: email.email),
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete,
                                      size: 30.0, color: Colors.grey[400]),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: 25.0),
                    SubmitButton(
                      text: "Update",
                      validationHandler: () async {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ));
  }
}
