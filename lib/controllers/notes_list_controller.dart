import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:noteapp/constant/constant.dart';
import 'package:noteapp/models/home_task_item_model.dart';

class NotesListController extends GetxController {
  final isGrid = true.obs;
  final isSearching = false.obs;
  final searchController = TextEditingController();
  late Box<HomeTaskItemModel> homeTaskItemBox;
  RxList<HomeTaskItemModel> notesList = RxList([]);
  RxList<HomeTaskItemModel> filteredNotesList = RxList([]);

  @override
  void onInit() {
    super.onInit();
    homeTaskItemBox = Hive.box(kBoxTodo);
    // List<HomeTaskItemModel> listToSort = homeTaskItemBox.values.toList();
    // listToSort.sort((a, b) => a.order!.compareTo(b.order!));
    notesList.addAll(homeTaskItemBox.values);
    filteredNotesList.addAll(homeTaskItemBox.values);
  }

  List<HomeTaskItemModel> get completedNotes => filteredNotesList
      .where((element) => element.todoItemList
          .every((todo) => todo.isChecked != null ? todo.isChecked! : false))
      .toList();

  RxList<HomeTaskItemModel> get archivedNotesList =>
      filteredNotesList.where((element) => element.isArchived).toList().obs;

  RxList<HomeTaskItemModel> get activeNotes =>
      filteredNotesList.where((element) => !element.isArchived).toList().obs;

  // List<HomeTaskItemModel> activeNotesList = [];

  initActiveNotes() {}

  List<HomeTaskItemModel> getArchiveNotesList() {
    return filteredNotesList.where((element) => !element.isArchived).toList();
  }

  archiveNote(HomeTaskItemModel item) async {
    item.isArchived = true;
    await item.save();
    filteredNotesList.remove(item);
    update();
    filteredNotesList.add(item);
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
        HomeTaskItemModel(colorValue: 0, todoItemList: []);
    HomeTaskItemModel homeTaskItemModelDummy2 =
        HomeTaskItemModel(colorValue: 1, todoItemList: []);

    //first enter some dummy content
    await homeTaskItemBox.putAt(oldIndex, homeTaskItemModelDummy1);
    await homeTaskItemBox.putAt(newIndex, homeTaskItemModelDummy2);
    // here you just swap this box item, oldIndex <> newIndex
    await homeTaskItemBox.putAt(oldIndex, newItem);
    await homeTaskItemBox.putAt(newIndex, oldItem);

    filteredNotesList.insert(newIndex, filteredNotesList.removeAt(oldIndex));
    update();
  }

  deleteNote(HomeTaskItemModel item) async {
    notesList.remove(item);
    filteredNotesList.remove(item);
    await item.delete();
    update();
  }

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
}
