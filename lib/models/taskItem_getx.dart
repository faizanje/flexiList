import 'package:get/get.dart';
import 'package:noteapp/models/enums/task_status.dart';

class TaskItemGetX extends GetxController {
  RxString taskName = "".obs;
  RxBool? isChecked = false.obs;
  Rx<TASK_STATUS> taskStatus = TASK_STATUS.TODO.obs;

  TaskItemGetX(
      {required this.taskName, this.isChecked, required this.taskStatus});
}
