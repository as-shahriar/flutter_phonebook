import 'package:phonebook/core/models/contact.dart';
import 'package:phonebook/utils/database_helper.dart';

import '../../service_locator.dart';
import 'base_model.dart';
import 'home_model.dart';

class EditModel extends BaseModel {
  DatabaseHelper _databaseHelper = DatabaseHelper.instance;
  BaseContact user = new BaseContact();

  Future<BaseContact> getContactDetails(int contactID) async {
    List<Map> data = await _databaseHelper.fetchUserInformation(contactID);
    user = BaseContact.fromMap(data[0]);
    return user;
  }
}
