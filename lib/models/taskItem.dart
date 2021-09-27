import 'package:get/get.dart';
import 'package:noteapp/models/enums/task_status.dart';

class TaskItem {
  String taskName;
  bool? isChecked;
  TASK_STATUS? taskStatus;

  TaskItem(
      {this.taskName = "",
      this.isChecked = false,
      this.taskStatus = TASK_STATUS.TODO});
}
