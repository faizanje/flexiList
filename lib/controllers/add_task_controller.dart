import 'dart:math';
import 'dart:ui';

import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_ticket_provider_mixin.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:noteapp/constant/constant.dart';
import 'package:noteapp/models/taskItem.dart';

class AddTaskController extends GetxController {
  RxList<TaskItem> toDoTasksList = RxList([]);
  Rx<Color> color = Rx(kNavbarColor);

  addTask(TaskItem taskItem) {
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
    update();
  }

  setChecked(TaskItem item, bool? newValue) {
    item.isChecked = newValue;
    update();
  }
}
