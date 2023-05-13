import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noteapp/controllers/app_controller.dart';
import 'package:noteapp/models/settings_model.dart';
import 'package:noteapp/utils/storage_utils.dart';

class ThemeService {
  switchTheme(bool isLight) {
    // Get.find<AppController>().switchTheme(isLight);
    // Get.changeThemeMode(isLight ? ThemeMode.light : ThemeMode.dark);

    SettingsModel settingsModel = StorageUtils.getSettingsItem();
    settingsModel.isLightTheme = isLight;
    StorageUtils.saveSettingsItem(settingsModel);
  }
}
