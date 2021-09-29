import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:noteapp/models/taskItem.dart';

class AddTaskController extends GetxController {
  RxList<TaskItem> toDoTasksList = RxList([]);

  addTask(TaskItem taskItem) {
    toDoTasksList.add(taskItem);
    update();
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
