import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
                child: Form(
                  key: _formKey,
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          Uint8List img = await handleImageSelected();
                          model.setPicture(img);
                          setState(() {
                            user.contact.picture = img;
                          });
                        },
                        child: CircleAvatar(
                          radius: 50.0,
                          backgroundColor: Colors.blueAccent[200],
                          child: user.contact.picture != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Image.memory(
                                    user.contact.picture,
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Container(
                                  decoration: BoxDecoration(
                                    color: Colors.lightBlueAccent.shade100,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  width: 100,
                                  height: 100,
                                  child: Icon(
                                    Icons.camera_alt,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.symmetric(vertical: 10.0)),
                      if (user.contact.name != null)
                        InputField(
                          validationHandler: textValidator,
                          onSaveHandler: ((value) => model.setName(value)),
                          hintText: 'Full Name',
                          value: user.contact.name,
                          hideText: false,
                        ),
                      SizedBox(height: 25.0),
                      if (user.contact.address != null)
                        InputField(
                          validationHandler: textValidator,
                          onSaveHandler: ((value) => model.setAddress(value)),
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
                          for (int i = 0; i < user.phones.length; i++)
                            Padding(
                              padding: const EdgeInsets.only(top: 16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: InputField(
                                        validationHandler: textValidator,
                                        onSaveHandler: ((value) =>
                                            model.setNumber(
                                                user.phones[i].phone_id,
                                                value)),
                                        hintText: 'Mobile No.',
                                        hideText: false,
                                        value: user.phones[i].phone),
                                  ),
                                  (i != 0)
                                      ? IconButton(
                                          icon: Icon(Icons.delete,
                                              size: 30.0,
                                              color: Colors.grey[400]),
                                          onPressed: () {
                                            if (model.deleteNumber(
                                                    user.phones[i].phone_id) !=
                                                -1) {
                                              setState(() {
                                                user.phones
                                                    .remove(user.phones[i]);
                                              });
                                            }
                                          },
                                        )
                                      : Container(),
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
                          for (int i = 0; i < user.emails.length; i++)
                            Padding(
                              padding: const EdgeInsets.only(top: 16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: InputField(
                                        validationHandler: textValidator,
                                        onSaveHandler: ((value) =>
                                            model.setEmail(
                                                user.emails[i].email_id,
                                                value)),
                                        hintText: 'Email Address',
                                        hideText: false,
                                        value: user.emails[i].email),
                                  ),
                                  (i != 0)
                                      ? IconButton(
                                          icon: Icon(Icons.delete,
                                              size: 30.0,
                                              color: Colors.grey[400]),
                                          onPressed: () {
                                            if (model.deleteEmail(
                                                    user.emails[i].email_id) !=
                                                -1) {
                                              setState(() {
                                                user.emails
                                                    .remove(user.emails[i]);
                                              });
                                            }
                                          },
                                        )
                                      : Container(),
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
                            if (model.user.contact.picture == null)
                              model.setPicture(user.contact.picture);
                            if (model.updateContact(widget.contactID) != -1) {
                              print("updated");
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  'home', (Route<dynamic> route) => false);
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }

  Future<Uint8List> handleImageSelected() async {
    final picker = ImagePicker();
    PickedFile file =
        await picker.getImage(source: ImageSource.gallery, imageQuality: 50);
    if (file != null) {
      return File(file.path).readAsBytesSync();
    } else
      return null;
  }
}
