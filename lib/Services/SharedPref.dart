import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  String userData = 'userInfo';
  String initial = "initial";

  void storeInSharedPrefs(Map data) async {
    //userId, email
    final prefs = await SharedPreferences.getInstance();
    String info = jsonEncode(data);
    prefs.setString(userData, info);
  }

  Future<Map> checkIfPresentInSharedPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'user': prefs.containsKey(userData),
      'isInit': prefs.containsKey(initial)
    };
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

  void setInit() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(initial, "true");
  }
}
