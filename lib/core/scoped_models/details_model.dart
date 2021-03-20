import 'package:phonebook/core/models/contact.dart';
import 'package:phonebook/core/scoped_models/home_model.dart';
import 'package:phonebook/utils/database_helper.dart';
import 'base_model.dart';

class DetailsModel extends BaseModel {
  DatabaseHelper _databaseHelper = DatabaseHelper.instance;
  BaseContact user = new BaseContact();

  Future<BaseContact> getContactDetails(int contactID) async {
    List<Map> data = await _databaseHelper.fetchUserInformation(contactID);
    user = BaseContact.fromMap(data[0]);
    return user;
  }
}
