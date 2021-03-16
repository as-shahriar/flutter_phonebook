import 'package:phonebook/core/models/contact.dart';
import 'package:phonebook/utils/database_helper.dart';

import '../../service_locator.dart';
import 'base_model.dart';
import 'home_model.dart';

class AddContactModel extends BaseModel {
  Contact contact = new Contact();
  Email email = new Email();
  Phone phone = new Phone();
  DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  void setName(value) {
    contact.name = value;
    notifyListeners();
  }

  void setAddress(value) {
    contact.address = value;
    notifyListeners();
  }

  void setEmail(value) {
    email.email = value;
    notifyListeners();
  }

  void setNumber(value) {
    phone.phone = value;
    notifyListeners();
  }

  Future<int> addContact(id) async {
    contact.user_id = id;
    await _databaseHelper.fetchContactsByUser(id);

    int res = await _databaseHelper.insertContact(contact, email, phone);
    if (res != -1) {
      var myAppModel = locator<HomeModel>();
      myAppModel.addContact(contact);
    }
    return res;
  }
}
