import 'dart:math';

import 'package:flutter/material.dart';

import '../service_locator.dart';
import 'SharedPref.dart';

class Utils {
  static final SharedPrefs sharedPrefs = locator<SharedPrefs>();

  static Future<int> getUserID() async {
    Map info = await sharedPrefs.getUserInfo();
    return info['userID'];
  }

  static MaterialColor randomColorPicker() {
    return Colors.primaries[Random().nextInt(Colors.primaries.length)];
  }
}
