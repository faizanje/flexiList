import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:noteapp/constant/constant.dart';
import 'package:noteapp/models/item_entity.dart';
import 'package:noteapp/models/settings_model.dart';

class StorageUtils {
  static SettingsModel getSettingsItem() {
    final settingsStr = GetStorage().read(kKeySettings);
    if (settingsStr != null) {
      print('settingsStr not null');
      print('settingsStr = $settingsStr');
      return SettingsModel.fromString(settingsStr);
    }

    print('settingsStr is null');

    return SettingsModel(
        currencyItem: Item('AUD', 'assets/images/aud.svg'),
        countryItem: Item('English', 'assets/images/english.svg'),
        isLightTheme: true);
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
