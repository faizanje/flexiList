import 'package:flutter/material.dart';

class ItemModel {
  bool expanded;
  String title;
  String item1;
  String item2;
  Widget btnWidget;

  ItemModel(
      {this.expanded: false,
      required this.title,
      required this.item1,
      required this.item2,
      required this.btnWidget});
}
