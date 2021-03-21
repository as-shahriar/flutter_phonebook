import 'package:phonebook/core/models/contact.dart';
import 'package:phonebook/utils/database_helper.dart';

import '../../service_locator.dart';
import 'base_model.dart';
import 'home_model.dart';

class EditModel extends BaseModel {
  DatabaseHelper _databaseHelper = DatabaseHelper.instance;
  BaseContact user = new BaseContact();
  Map numberList = {};
  Map emailList = {};
  Future<BaseContact> getContactDetails(int contactID) async {
    List<Map> data = await _databaseHelper.fetchUserInformation(contactID);
    user = BaseContact.fromMap(data[0]);
    return user;
  }

  void setPicture(value) {
    user.contact.picture = value;
    notifyListeners();
  }

  void setName(value) {
    user.contact.name = value;
    notifyListeners();
  }

  void setAddress(value) {
    user.contact.address = value;
    notifyListeners();
  }

  void setNumber(id, number) {
    numberList[id] = number;
    notifyListeners();
  }

  void setEmail(id, email) {
    emailList[id] = email;
    notifyListeners();
  }

  Future<int> updateContact(int id) async {
    int res2 = 0, res3 = 0;
    user.contact.contact_id = id;
    int res1 = await _databaseHelper.updateContact(user.contact);
    numberList.forEach((key, value) async {
      res2 += await _databaseHelper.updatePhone(id: key, phone: value);
    });

    emailList.forEach((key, value) async {
      res2 += await _databaseHelper.updateEmail(id: key, email: value);
    });
    if (res1 != -1 &&
        res2 == numberList.keys.length &&
        res3 == emailList.keys.length)
      return 1;
    else
      return -1;
  }

  Future<int> deleteNumber(int id) async {
    int res = await _databaseHelper.deleteNumber(id);
    return res;
  }

  Future<int> deleteEmail(int id) async {
    int res = await _databaseHelper.deleteEmail(id);
    return res;
  }
}
