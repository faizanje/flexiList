import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:noteapp/constant/constant.dart';
import 'package:noteapp/models/item_entity.dart';
import 'package:noteapp/models/settings_model.dart';

class StorageUtils {
  static SettingsModel getSettingsItem() {
    final settingsStr = GetStorage().read(kKeySettings);
    return SettingsModel.fromString(settingsStr);
  }

  static void saveSettingsItem(SettingsModel settingsModel) async {
    await GetStorage().write(
      kKeySettings,
      jsonEncode(
        settingsModel.toJson(),
      ),
    );
  }
}
