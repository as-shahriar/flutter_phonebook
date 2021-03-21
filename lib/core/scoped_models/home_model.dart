import 'package:phonebook/Services/utils.dart';
import 'package:phonebook/core/models/contact.dart';
import 'package:phonebook/enums/view_state.dart';
import 'package:phonebook/service_locator.dart';
import 'package:phonebook/utils/database_helper.dart';

import 'base_model.dart';

class HomeModel extends BaseModel {
  bool loaded = false;

  HomeModel() {
    getContacts(Utils.getUserID());
  }
  DatabaseHelper _databaseHelper = DatabaseHelper.instance;
  List<BaseContact> contacts = [];

  void sortAZ() {
    contacts.sort((a, b) =>
        a.contact.name.toLowerCase().compareTo(b.contact.name.toLowerCase()));
    notifyListeners();
  }

  void sortZA() {
    contacts.sort((a, b) =>
        b.contact.name.toLowerCase().compareTo(a.contact.name.toLowerCase()));
    notifyListeners();
  }

  void getContacts(Future<int> id) async {
    int userId = await id;
    List<Map> data = await _databaseHelper.fetchContactsByUser(userId);
    for (var contact in data) {
      contacts.add(BaseContact.contact(new Contact.fromMap(contact)));
    }
    notifyListeners();
  }

  void addContact(Contact contact) {
    contacts.add(BaseContact.contact(contact));
    notifyListeners();
  }
}
