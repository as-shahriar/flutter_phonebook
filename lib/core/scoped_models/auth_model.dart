import 'package:phonebook/core/models/user.dart';
import 'package:phonebook/utils/database_helper.dart';
import 'base_model.dart';

class AuthnModel extends BaseModel {
  User user = new User();
  List<User> users;
  DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  void setEmail(value) {
    user.email = value;
    notifyListeners();
  }

  String getEmail() {
    if (user.email != null) {
      return user.email;
    } else
      return 'empty';
  }

  String getPassword() {
    if (user.password != null) {
      return user.password;
    } else
      return 'empty';
  }

  void setPassword(value) {
    user.password = value;
    notifyListeners();
  }

  void insertUser() async {
    await _databaseHelper.insertUser(user);
  }

  Future<int> login() async {
    return await _databaseHelper.isSignedIn(user.email, user.password);
  }

  Future<bool> uniqueEmail() async {
    return await _databaseHelper.uniqueEmail(user.email);
  }

  void getUsers() async {
    List<User> x = await _databaseHelper.fetchContacts();
    x.forEach((element) {
      print('${element.id},${element.email},${element.password}');
    });
    users = x;
  }

  void getUserList() {
    print(users);
  }
}
