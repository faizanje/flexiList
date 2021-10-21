import 'dart:convert';

import 'package:noteapp/models/item_entity.dart';

class SettingsModel {
  Item currencyItem;
  Item countryItem;
  bool isDarkTheme;

  SettingsModel(
      {required this.currencyItem,
      required this.countryItem,
      this.isDarkTheme = false});

  Map<String, dynamic> toJson() {
    return {
      "currencyItem": this.currencyItem,
      "countryItem": this.countryItem,
      "isDarkTheme": this.isDarkTheme,
    };
  }

  factory SettingsModel.fromJson(Map<String, dynamic> json) {
    return SettingsModel(
      currencyItem: Item.fromJson(json["currencyItem"]),
      countryItem: Item.fromJson(json["countryItem"]),
      isDarkTheme: json["isDarkTheme"],
    );
  }

  factory SettingsModel.fromString(String object) {
    return SettingsModel.fromJson(jsonDecode(object));
  }
}
