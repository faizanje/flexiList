import 'package:get/get_navigation/src/root/internacionalization.dart';
import 'package:hive/hive.dart';
import 'package:noteapp/constant/strings.dart';
import 'package:noteapp/models/enums/task_status.dart';

part 'todo_item.g.dart';

@HiveType(typeId: 1)
class TodoItemModel extends HiveObject {
  @HiveField(0)
  String taskName;

  @HiveField(1)
  bool? isChecked;

  @HiveField(2)
  int price;

  @HiveField(3)
  TASK_STATUS taskStatus;

  @HiveField(4)
  bool isPinned;

  String get taskStatusStr {
    switch (taskStatus) {
      case TASK_STATUS.LATER:
        return 'Later';
      case TASK_STATUS.DONE:
        return 'Done';
      case TASK_STATUS.TODO:
        return 'Todo';
    }
  }

  TodoItemModel({
    required this.taskName,
    this.isChecked,
    this.taskStatus = TASK_STATUS.TODO,
    this.price = 0,
    this.isPinned = false,
  });
}
