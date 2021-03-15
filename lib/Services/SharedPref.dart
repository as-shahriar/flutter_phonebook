import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  String userData = 'userInfo';
  void storeInSharedPrefs(Map data) async {
    //userId, email
    final prefs = await SharedPreferences.getInstance();
    String info = jsonEncode(data);
    prefs.setString(userData, info);
  }

  Future<bool> checkIfPresentInSharedPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(userData);
  }

  Future<Map> getUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    String encodedData = prefs.getString(userData);
    Map userInfo = jsonDecode(encodedData);
    return userInfo;
  }

  void removeSharedPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(userData);
    return;
  }
}
