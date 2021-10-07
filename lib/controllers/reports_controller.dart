import 'package:get/get.dart';
import 'package:noteapp/controllers/notes_list_controller.dart';

class ReportsController extends GetxController {
  final notesListController = Get.find<NotesListController>();
  final RxList<bool> isExpandedList = RxList<bool>([]);

  @override
  void onInit() {
    super.onInit();
    initList();
  }

  initList() {
    isExpandedList.clear();
    isExpandedList.addAll(List.generate(
        notesListController.completedNotes.length, (index) => false));
  }
}
