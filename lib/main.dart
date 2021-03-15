import 'package:phonebook/routes/RouteBuilder.dart';
import 'package:phonebook/ui/views/home_view.dart';
import 'package:phonebook/ui/views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:phonebook/ui/views/signup_view.dart';
import 'Services/SharedPref.dart';
import 'service_locator.dart';

void main() {
  //setup locator
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final SharedPrefs sharedPrefs = locator<SharedPrefs>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder<bool>(
        future: sharedPrefs.checkIfPresentInSharedPrefs(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            return snapshot.data ? HomeView() : LoginView();
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      onGenerateRoute: RouteBuilder.generateRoute,
    );
  }
}
