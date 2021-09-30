import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:noteapp/constant/constant.dart';
import 'package:noteapp/models/enums/task_status.dart';
import 'package:noteapp/models/taskItem.dart';

class AddTaskController extends GetxController {
  RxList<TaskItem> toDoTasksList = RxList([]);
  Rx<Color> color = Rx<Color>(Colors.red);

  TextEditingController textEditingController = TextEditingController();

  setChecked(TaskItem taskItem, bool? value) {
    taskItem.isChecked = value;
    update();
  }

  void addTask(TaskItem taskItem) {
    toDoTasksList.add(taskItem);
    update();
  }

  changePrimaryColor() {
    color.value = kNavbarColor;
  }

  randomizeColor() {
    color.value =
        Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
  }

  removeTask(TaskItem taskItem) {
    toDoTasksList.remove(taskItem);
    textEditingController.clear();
    update();
  }
}
