import 'package:phonebook/core/models/contact.dart';
import 'package:phonebook/core/services/storage_service.dart';
import 'package:phonebook/enums/view_state.dart';
import 'package:phonebook/service_locator.dart';
import 'package:phonebook/utils/database_helper.dart';

import 'base_model.dart';

class HomeModel extends BaseModel {
  StorageService storageService = locator<StorageService>();
  String title = "HomeModel";
  DatabaseHelper _databaseHelper = DatabaseHelper.instance;
  List<BaseContact> contacts = [];

  void getContacts(Future<int> id) async {
    int userId = await id;
    List<Map> data = await _databaseHelper.fetchContactsByUser(userId);
    setTitle("setter");
    for (var contact in data) {
      contacts.add(BaseContact.contact(new Contact.fromMap(contact)));
    }
    print("Contacts");
    print(contacts);
    notifyListeners();
  }

  Future<bool> saveData() async {
    setState(ViewState.Busy);
    setTitle("Saving Data");
    await storageService.saveData();
    setTitle("Data Saved");
    setState(ViewState.Retrieved);

    return true;
  }

  void setTitle(String value) {
    title = value;
  }

  void addContact(Contact contact) {
    contacts.add(BaseContact.contact(contact));
    notifyListeners();
  }
}

class BaseContact {
  Contact contact = new Contact();
  List<Email> emails = [];
  List<Phone> phones = [];
  BaseContact.contact(this.contact);
}
