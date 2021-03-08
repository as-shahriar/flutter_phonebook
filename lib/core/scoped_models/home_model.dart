import 'package:phonebook/core/services/storage_service.dart';
import 'package:phonebook/enums/view_state.dart';
import 'package:phonebook/service_locator.dart';

import 'base_model.dart';

class HomeModel extends BaseModel {
  StorageService storageService = locator<StorageService>();
  String title = "HomeModel";

  Future<bool> saveData() async {
    setState(ViewState.Busy);
    setTitle("Saving Data");
    await storageService.saveData();
    setTitle("Data Saved");
    setState(ViewState.Retrieved);

    return true;
  }

  void setTitle(String value) {
    title = value;
  }
}
