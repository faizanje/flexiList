import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
// import 'package:multi_select_item/multi_select_item.dart';
import 'package:noteapp/constant/constant.dart';
import 'package:noteapp/models/filter_date.dart';
import 'package:noteapp/models/home_task_item_model.dart';
import 'package:noteapp/utils/multi_select_item.dart';
import 'package:noteapp/utils/custom_color_scheme.dart';

class NotesListController extends GetxController {
  final isSelectingList = false.obs;
  final selectedItemsCount = 0.obs;
  final isGrid = true.obs;
  final isSearching = false.obs;
  final searchController = TextEditingController();
  late Box<HomeTaskItemModel> homeTaskItemBox;
  RxList<HomeTaskItemModel> notesList = RxList([]);
  RxList<HomeTaskItemModel> filteredNotesList = RxList([]);
  MultiSelectController multiSelectController = new MultiSelectController();

  final colors = [
    Get.theme.colorScheme.listColor1,
    Get.theme.colorScheme.listColor2,
    Get.theme.colorScheme.listColor3,
    Get.theme.colorScheme.listColor4,
    Get.theme.colorScheme.listColor5,
    Get.theme.colorScheme.listColor6,
    Get.theme.colorScheme.listColor7,
    Get.theme.colorScheme.listColor8,
    Get.theme.colorScheme.listColor9,
  ];

  @override
  void onInit() {
    super.onInit();
    homeTaskItemBox = Hive.box(kBoxTodo);
    // List<HomeTaskItemModel> listToSort = homeTaskItemBox.values.toList();
    // listToSort.sort((a, b) => a.order!.compareTo(b.order!));
    notesList.addAll(homeTaskItemBox.values);
    filteredNotesList.addAll(homeTaskItemBox.values);
  }

  // List<HomeTaskItemModel> get completedNotes => filteredNotesList
  //     .where((element) => element.todoItemList
  //         .every((todo) => todo.isChecked != null ? todo.isChecked! : false))
  //     .toList();

  RxList<HomeTaskItemModel> get archivedNotesList =>
      filteredNotesList.where((element) => element.isArchived).toList().obs;

  RxList<HomeTaskItemModel> get activeNotes =>
      filteredNotesList.where((element) => !element.isArchived).toList().obs;

  // List<HomeTaskItemModel> activeNotesList = [];

  initActiveNotes() {}

  List<HomeTaskItemModel> getActiveNotesList() {
    return filteredNotesList.where((element) => !element.isArchived).toList();
  }

  List<HomeTaskItemModel> getArchiveNotesList() {
    return filteredNotesList.where((element) => element.isArchived).toList();
  }

  List<HomeTaskItemModel> getCompletedNotesList() {
    return filteredNotesList
        .where((element) => element.todoItemList
            .every((todo) => todo.isChecked != null ? todo.isChecked! : false))
        .toList();
  }

  List<HomeTaskItemModel> getFilteredCompletedNotesList(FilterDate filterDate) {
    if (filterDate.fromDate == null && filterDate.toDate == null) {
      return getCompletedNotesList();
    }
    print('Dates are not null');
    return filteredNotesList
        .where((element) => element.todoItemList
            .every((todo) => todo.isChecked != null ? todo.isChecked! : false))
        .where((element) =>
            element.dateTime.isAfter(filterDate.fromDate!) &&
            element.dateTime.isBefore(filterDate.toDate!))
        .toList();
  }

  setIsSelectingList(bool value) {
    this.isSelectingList.value = value;
    this.multiSelectController.isSelecting = value;
    this.selectedItemsCount.value =
        this.multiSelectController.selectedIndexes.length;
    update();
  }

  archiveNote(HomeTaskItemModel item, [bool refresh = true]) async {
    int index = filteredNotesList.indexOf(item);
    filteredNotesList[index].isArchived = true;
    // filteredNotesList.remove(item);
    if (refresh) {
      filteredNotesList.refresh();
      await item.save();
      update();
    }
    // item.isArchived = true;
    // filteredNotesList.add(item);
  }

  unArchiveNote(HomeTaskItemModel item, [bool refresh = true]) async {
    int index = filteredNotesList.indexOf(item);
    filteredNotesList[index].isArchived = false;
    await item.save();
    if (refresh) {
      filteredNotesList.refresh();
      update();
    }
    // filteredNotesList.add(item);
  }

  reorderNote(int newIndex, int oldIndex) async {
    print(
        '${filteredNotesList[oldIndex].title} moved to ${filteredNotesList[newIndex].title}');
    final oldItem = homeTaskItemBox.getAt(oldIndex);
    final newItem = homeTaskItemBox.getAt(newIndex);

    print('Old index $oldIndex, newIndex $newIndex');

    print('oldItem.title ${oldItem!.title} oldItem.key ${oldItem.key}');
    print('newItem.title ${newItem!.title} oldItem.key ${newItem.key}');

    // await oldItem.delete();
    // await newItem.delete();

    HomeTaskItemModel homeTaskItemModelDummy1 =
        HomeTaskItemModel(colorValue: [0, 0], todoItemList: []);
    HomeTaskItemModel homeTaskItemModelDummy2 =
        HomeTaskItemModel(colorValue: [1, 1], todoItemList: []);

    //first enter some dummy content
    await homeTaskItemBox.putAt(oldIndex, homeTaskItemModelDummy1);
    await homeTaskItemBox.putAt(newIndex, homeTaskItemModelDummy2);
    // here you just swap this box item, oldIndex <> newIndex
    await homeTaskItemBox.putAt(oldIndex, newItem);
    await homeTaskItemBox.putAt(newIndex, oldItem);

    filteredNotesList.insert(newIndex, filteredNotesList.removeAt(oldIndex));
    update();
  }

  undoNoteDelete(int index, HomeTaskItemModel item) {
    notesList.insert(index, item);
    filteredNotesList.insert(index, item);
    update();
  }

  deleteNoteFromNotesList(HomeTaskItemModel item, [bool refresh = true]) async {
    notesList.remove(item);
    filteredNotesList.remove(item);
    if (refresh) {
      update();
    }
  }

  deleteNoteFromDatabase(HomeTaskItemModel item) async {
    await item.delete();
    update();
  }
  // deleteNote(HomeTaskItemModel item) async {
  //   notesList.remove(item);
  //   filteredNotesList.remove(item);
  //   await item.delete();
  //   update();
  // }

  updateNote() {}

  saveNotes() {}

  onSearched(String searchText, bool showArchivedNotes) {
    filteredNotesList.clear();
    if (searchText.isEmpty) {
      isSearching.value = false;
      filteredNotesList.addAll(notesList);
    } else {
      isSearching.value = true;
      notesList.forEach((note) {
        if (note.title!.toLowerCase().contains(searchText.toLowerCase())) {
          filteredNotesList.add(note);
          return;
        }
        for (var task in note.todoItemList) {
          if (task.taskName.toLowerCase().contains(searchText.toLowerCase())) {
            filteredNotesList.add(note);
            break;
          }
        }
      });
    }
    update();
  }

  void toggleIsGrid() {
    isGrid.toggle();
    update();
  }

  void toggleSelectedIndex(int index) {
    multiSelectController.toggle(index);
    multiSelectController.isSelected(index)
        ? selectedItemsCount.value++
        : selectedItemsCount.value--;
    update();
  }

  void resetSelection() {
    setIsSelectingList(false);
    multiSelectController.deselectAll();
    selectedItemsCount.value = 0;
  }

  //This will be called whenever item is removed, added or Active/Archive screen is opened
  void initSelectionSize(int size) {
    this.multiSelectController.set(size);
    this.selectedItemsCount.value = 0;
    this.isSelectingList.value = false;
  }
}
