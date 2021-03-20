import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phonebook/ui/views/add_view.dart';
import 'package:phonebook/ui/views/details_view.dart';
import 'package:phonebook/ui/views/edit_view.dart';
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
      case 'details':
        return MaterialPageRoute(builder: (_) => DetailsView(contactID: args));
      case 'edit':
        return MaterialPageRoute(builder: (_) => EditView(contactID: args));
      default:
        return null;
    }
  }
}
