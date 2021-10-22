import 'dart:convert';

import 'package:noteapp/models/item_entity.dart';

class SettingsModel {
  Item currencyItem;
  Item countryItem;
  bool isLightTheme;

  SettingsModel(
      {required this.currencyItem,
      required this.countryItem,
      this.isLightTheme = false});

  Map<String, dynamic> toJson() {
    return {
      "currencyItem": this.currencyItem,
      "countryItem": this.countryItem,
      "isLightTheme": this.isLightTheme,
    };
  }

  factory SettingsModel.fromJson(Map<String, dynamic> json) {
    return SettingsModel(
      currencyItem: Item.fromJson(json["currencyItem"]),
      countryItem: Item.fromJson(json["countryItem"]),
      isLightTheme: json["isLightTheme"],
    );
  }

  factory SettingsModel.fromString(String object) {
    return SettingsModel.fromJson(jsonDecode(object));
  }
}
