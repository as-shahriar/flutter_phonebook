import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phonebook/Services/SharedPref.dart';
import 'package:phonebook/Services/utils.dart';
import 'package:phonebook/core/scoped_models/add_model.dart';
import 'package:phonebook/ui/widgets/formInputField.dart';
import 'package:phonebook/ui/widgets/submit_button.dart';
import 'package:phonebook/validators/validators.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import '../../service_locator.dart';
import '../../themeConfig.dart';
import 'base_view.dart';

class AddContact extends StatefulWidget {
  @override
  _AddContactState createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  final _formKey = GlobalKey<FormState>();
  Uint8List selectedImage;
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
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    children: [
                      Text(
                        "Create New Contact",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: primaryColor),
                        textAlign: TextAlign.center,
                      ),
                      Divider(
                        color: Colors.blueAccent[300],
                        height: 36,
                      ),
                      GestureDetector(
                        onTap: () async {
                          Uint8List img = await handleImageSelected();
                          model.setPicture(img);
                          setState(() {
                            selectedImage = img;
                          });
                        },
                        child: CircleAvatar(
                          radius: 50.0,
                          backgroundColor: Colors.blueAccent[200],
                          child: selectedImage != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Image.memory(
                                    selectedImage,
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
                        validationHandler: numberValidator,
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
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  'home', (Route<dynamic> route) => false);
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('All fields are required.'),
                              backgroundColor: Colors.red[300],
                            ));
                          }
                        },
                      ),
                    ],
                  ),
                ))));
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
