import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:noteapp/models/enums/task_status.dart';
import 'package:noteapp/models/taskItem.dart';

class AddTaskController extends GetxController {
  RxList<TaskItem> toDoTasksList = RxList([
    TaskItem(
      isChecked: false,
      taskStatus: TASK_STATUS.TODO,
      taskName: "asdasd",
    )
  ]);
  TextEditingController textEditingController = TextEditingController();

  setChecked(TaskItem item, bool? newValue) {
    item.isChecked = newValue;
    update();
  }

  void addTask(TaskItem taskItem) {
    toDoTasksList.add(taskItem);
    textEditingController.clear();
    update();
  }
}
