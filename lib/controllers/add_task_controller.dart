import 'package:get/get.dart';
import 'package:noteapp/models/taskItem.dart';

class AddTaskController extends GetxController {
  RxList<TaskItem> toDoTasksList = RxList([]);

  setChecked(TaskItem taskItem, bool? value) {
    taskItem.isChecked = value;
    update();
  }

  addTask(TaskItem taskItem) {
    toDoTasksList.add(taskItem);
  }

  removeTask(TaskItem taskItem) {
    toDoTasksList.remove(taskItem);
  }
}
