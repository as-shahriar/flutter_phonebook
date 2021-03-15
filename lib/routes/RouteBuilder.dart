import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phonebook/ui/views/add_view.dart';
import 'package:phonebook/ui/views/home_view.dart';
import 'package:phonebook/ui/views/login_view.dart';
import 'package:phonebook/ui/views/signup_view.dart';

class RouteBuilder {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case 'login':
        return MaterialPageRoute(builder: (_) => LoginView());
      case 'signUp':
        return MaterialPageRoute(builder: (_) => SignupView());
      case 'home':
        return MaterialPageRoute(builder: (_) => HomeView());
      case 'addContact':
        return MaterialPageRoute(builder: (_) => AddContact());

      default:
        return null;
    }
  }
}
