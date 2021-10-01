import 'package:noteapp/models/enums/task_status.dart';

class TaskItem {
  String taskName;
  bool? isChecked = false;
  TASK_STATUS taskStatus = TASK_STATUS.TODO;

  String get taskStatusStr {
    switch (taskStatus) {
      case TASK_STATUS.LATER:
        return "Later";
      case TASK_STATUS.DONE:
        return "Done";
      case TASK_STATUS.TODO:
        return "Todo";
    }
  }

  TaskItem({
    this.taskName = "",
    required this.isChecked,
    required this.taskStatus,
  });
}
