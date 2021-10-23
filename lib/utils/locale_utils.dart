import 'dart:ui';

import 'package:get/get.dart';
import 'package:noteapp/constant/constant.dart';
import 'package:noteapp/models/item_entity.dart';
import 'package:noteapp/utils/storage_utils.dart';

class LocaleUtils {
  static Locale getLocaleByItem(Item countryItem) {
    return kMyLocales.firstWhere((element) =>
        element['name'].toString().toLowerCase() ==
        countryItem.name.toLowerCase())['locale'];
  }

  static updateLanguageByLocale(Locale locale) {
    // Get.back();
    Get.updateLocale(locale);
  }

  static updateLanguageByItem(Item countryItem) {
    Get.updateLocale(getLocaleByItem(countryItem));
  }

  static Locale getLocaleFromStorage() {
    return getLocaleByItem(StorageUtils.getSettingsItem().countryItem);
  }
}
