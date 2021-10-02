import 'package:noteapp/models/enums/task_status.dart';

class TodoItemModel {
  String taskName;
  bool? isChecked;
  int price;
  TASK_STATUS taskStatus;

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

  TodoItemModel(
      {required this.taskName,
      this.isChecked,
      this.taskStatus = TASK_STATUS.TODO,
      this.price = 0});
}
