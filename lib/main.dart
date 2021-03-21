import 'package:phonebook/ui/views/splash.dart';
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
            if (!snapshot.data['isInit']) {
              sharedPrefs.setInit();
              return Splash();
            } else if (snapshot.data['user'])
              return HomeView();
            else
              return LoginView();
          } else {
            return Scaffold(
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Welcome To",
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    "PhoneBook",
                    style: TextStyle(
                        color: primaryColor,
                        fontSize: 50,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 25.0),
                  Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.grey[200],
                      valueColor:
                          new AlwaysStoppedAnimation<Color>(primaryColor),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
      onGenerateRoute: RouteBuilder.generateRoute,
    );
  }
}
