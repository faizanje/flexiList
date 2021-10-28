import 'package:get/get.dart';
import 'package:noteapp/controllers/notes_list_controller.dart';
import 'package:noteapp/models/filter_date.dart';

class ReportsController extends GetxController {
  final selectedDateFilterIndex = 0.obs;
  final datesForFilter = <FilterDate>[
    FilterDate(placeholder: 'All', fromDate: null, toDate: null),
    FilterDate(
        placeholder: 'Yesterday',
        fromDate: DateTime.now().subtract(Duration(days: 1)),
        toDate: DateTime.now()),
    FilterDate(
        placeholder: 'Last Week',
        fromDate: DateTime.now().subtract(Duration(days: 1)),
        toDate: DateTime.now()),
    FilterDate(
        placeholder: 'Last Month',
        fromDate: DateTime(
            DateTime.now().year, DateTime.now().month - 1, DateTime.now().day),
        toDate: DateTime.now()),
    FilterDate(
        placeholder: 'Last Year',
        fromDate: DateTime(
            DateTime.now().year - 1, DateTime.now().month, DateTime.now().day),
        toDate: DateTime.now()),
    FilterDate(
      placeholder: 'Custom',
      fromDate: DateTime.now(),
      toDate: DateTime.now(),
    ),
  ];

  @override
  void onInit() {
    super.onInit();
  }

  final isCustomSelected = false.obs;

// setExpandedList() {
//   this.expandedList.clear();
//   this.expandedList.addAll(List.generate(
//       notesListController.getCompletedNotesList().length, (index) => false));
//   // return List.generate(length, (index) => null)
// }

// initList() {
//   isExpandedList.clear();
//   isExpandedList.addAll(List.generate(
//       notesListController.completedNotes.length, (index) => false));
// }
}
