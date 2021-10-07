import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:noteapp/models/todo_item.dart';

part 'home_task_item_model.g.dart';

@HiveType(typeId: 0)
class HomeTaskItemModel extends HiveObject {
  @HiveField(0)
  bool isArchived;

  @HiveField(1)
  bool isCurrencySelected;

  @HiveField(2)
  int colorValue;

  @HiveField(3)
  List<TodoItemModel> todoItemList;

  @HiveField(4)
  String? title = DateTime.now().toLocal().toIso8601String();

  bool isExpanded = false;

  HomeTaskItemModel(
      {this.isArchived = false,
      this.isCurrencySelected = false,
      required this.colorValue,
      required this.todoItemList,
      this.title});
}
