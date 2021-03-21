import 'package:phonebook/core/models/contact.dart';
import 'package:phonebook/core/scoped_models/home_model.dart';
import 'package:phonebook/utils/database_helper.dart';
import 'base_model.dart';

class DetailsModel extends BaseModel {
  DatabaseHelper _databaseHelper = DatabaseHelper.instance;
  BaseContact user = new BaseContact();
  Email email = new Email();
  Phone phone = new Phone();

  setPhone(value) {
    this.phone.phone = value;
  }

  setEmail(value) {
    this.email.email = value;
  }

  Future<Phone> addPhone(int contactId) async {
    Phone tempPhone = new Phone();
    tempPhone.contact_id = contactId;
    tempPhone.phone = phone.phone;

    try {
      var res = await _databaseHelper.insertPhoneNumber(tempPhone);
      tempPhone.phone_id = res;
    } catch (exception) {
      print('Number saving error');
    }
    return tempPhone;
  }

  Future<Email> addEmail(int contactId) async {
    Email tempEmail = new Email();
    tempEmail.email = email.email;
    tempEmail.contact_id = contactId;
    var res = await _databaseHelper.insertEmail(tempEmail);
    tempEmail.email_id = res;
    return tempEmail;
  }

  Future<BaseContact> getContactDetails(int contactID) async {
    List<Map> data = await _databaseHelper.fetchUserInformation(contactID);
    user = BaseContact.fromMap(data[0]);
    return user;
  }
}
