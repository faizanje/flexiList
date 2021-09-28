import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
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
