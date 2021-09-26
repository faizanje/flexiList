import 'package:get/get.dart';
import 'package:noteapp/models/taskItem.dart';

class AddTaskController extends GetxController {
  List<TaskItem> toDoNowList = [].obs as List<TaskItem>;
  List<TaskItem> toDoLaterList = [].obs as List<TaskItem>;
  List<TaskItem> toDoDoneList = [].obs as List<TaskItem>;
}
