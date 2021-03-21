import 'package:phonebook/core/scoped_models/splash.dart';
import 'package:phonebook/routes/RouteBuilder.dart';
import 'package:phonebook/themeConfig.dart';
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
      title: 'PhoneBook',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder<Map>(
        future: sharedPrefs.checkIfPresentInSharedPrefs(),
        builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            print(snapshot.data);
            if (!snapshot.data['isInit']) {
              sharedPrefs.setInit();
              return Splash();
            } else if (snapshot.data['user'])
              return HomeView();
            else
              return LoginView();
          } else {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.white,
              ),
            );
          }
        },
      ),
      onGenerateRoute: RouteBuilder.generateRoute,
    );
  }
}
