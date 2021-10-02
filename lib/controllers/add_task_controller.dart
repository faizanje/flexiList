import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:noteapp/constant/constant.dart';
import 'package:noteapp/models/taskItem.dart';

class AddTaskController extends GetxController {
  final isCurrencySelected = false.obs;
  final RxList<TodoItemModel> toDoTasksList = RxList([]);
  final Rx<Color> color = Rx<Color>(Colors.white);

  final isSlidePanelOpen = false.obs;

  TextEditingController textEditingController = TextEditingController();

  setChecked(TodoItemModel taskItem, bool? value) {
    taskItem.isChecked = value;
    update();
  }

  void addTask(TodoItemModel taskItem) {
    toDoTasksList.add(taskItem);
    textEditingController.clear();
    update();
  }

  changePrimaryColor() {
    color.value = kNavbarColor;
  }

  randomizeColor() {
    color.value =
        Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
  }

  removeTask(TodoItemModel taskItem) {
    toDoTasksList.remove(taskItem);
    update();
  }
}
