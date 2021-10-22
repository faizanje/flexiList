import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noteapp/controllers/app_controller.dart';

class ThemeService {
  switchTheme(bool isLight) {
    // Get.find<AppController>().switchTheme(isLight);
    Get.changeThemeMode(isLight ? ThemeMode.light : ThemeMode.dark);
  }
}
