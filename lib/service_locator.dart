import 'package:get_it/get_it.dart';
import 'package:phonebook/core/scoped_models/add_model.dart';

import 'Services/SharedPref.dart';
import 'core/scoped_models/auth_model.dart';
import 'core/scoped_models/details_model.dart';
import 'core/scoped_models/ediit_model.dart';
import 'core/scoped_models/home_model.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  // Register services
  locator.registerFactory<SharedPrefs>(() => SharedPrefs());

  // Register models
  locator.registerFactory<HomeModel>(() => HomeModel());
  locator.registerFactory<AuthnModel>(() => AuthnModel());
  locator.registerFactory<AddContactModel>(() => AddContactModel());
  locator.registerFactory<DetailsModel>(() => DetailsModel());
  locator.registerFactory<EditModel>(() => EditModel());
}
