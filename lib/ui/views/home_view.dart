import 'package:phonebook/core/scoped_models/home_model.dart';
import 'package:phonebook/enums/view_state.dart';
import 'package:phonebook/ui/views/base_view.dart';
import 'package:phonebook/ui/widgets/busy_overlay.dart';
import 'package:flutter/material.dart';

import 'login_view.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<HomeModel>(
      builder: (context, child, model) => BusyOverlay(
        child: Scaffold(
          body: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _getBodyUi(model.state),
              Text(model.title),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              var whereToNavigate = await model.saveData();
              if (whereToNavigate) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginView()));
              } else {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginView()));
              }
            },
            child: Icon(Icons.navigation_rounded),
            backgroundColor: Colors.green,
          ),
        ),
      ),
    );
  }

  Widget _getBodyUi(ViewState state) {
    switch (state) {
      case ViewState.Busy:
        return CircularProgressIndicator();
      case ViewState.Retrieved:
      default:
        return Text('Done');
    }
  }
}
