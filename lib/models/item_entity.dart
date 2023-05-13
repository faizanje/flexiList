import 'dart:collection';

import 'dart:convert';

class Item {
  String name;
  String iconPath;

  Map<String, dynamic> toJson() {
    return {
      "name": this.name,
      "iconPath": this.iconPath,
    };
  }

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      json["name"],
      json["iconPath"],
    );
  }

  factory Item.fromString(String object) {
    return Item.fromJson(jsonDecode(object));
  }

  Item(this.name, this.iconPath);
}
