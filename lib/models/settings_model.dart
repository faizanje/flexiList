import 'dart:convert';

import 'package:noteapp/constant/constant.dart';
import 'package:noteapp/models/item_entity.dart';

class SettingsModel {
  Item currencyItem;
  Item countryItem;
  bool isLightTheme;
  bool hasWatchedTutorial;
  String dateFormat;
  bool isCurrencyEnableGlobally;

  SettingsModel(
      {required this.currencyItem,
      required this.countryItem,
      this.isLightTheme = true,
      this.hasWatchedTutorial = false,
      this.isCurrencyEnableGlobally = true,
      this.dateFormat = 'dd/MM/yyyy'});

  Map<String, dynamic> toJson() {
    return {
      "currencyItem": this.currencyItem,
      "countryItem": this.countryItem,
      "isLightTheme": this.isLightTheme,
      "hasWatchedTutorial": this.hasWatchedTutorial,
      "dateFormat": this.dateFormat,
      "isCurrencyEnableGlobally": this.isCurrencyEnableGlobally
    };
  }

  factory SettingsModel.fromJson(Map<String, dynamic> json) {
    return SettingsModel(
      currencyItem: Item.fromJson(json["currencyItem"]),
      countryItem: Item.fromJson(json["countryItem"]),
      isLightTheme: json["isLightTheme"],
      hasWatchedTutorial: json["hasWatchedTutorial"],
      dateFormat: json["dateFormat"],
      isCurrencyEnableGlobally: json["isCurrencyEnableGlobally"],
    );
  }

  factory SettingsModel.fromString(String object) {
    return SettingsModel.fromJson(jsonDecode(object));
  }
}
