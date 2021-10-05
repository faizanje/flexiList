import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:noteapp/constant/constant.dart';
import 'package:noteapp/models/home_task_item_model.dart';

class NotesListController extends GetxController {
  final isSearching = false.obs;
  final searchController = TextEditingController();
  late Box<HomeTaskItemModel> homeTaskItemBox;
  RxList<HomeTaskItemModel> notesList = RxList([]);
  RxList<HomeTaskItemModel> filteredNotesList = RxList([]);
  @override
  void onInit() {
    super.onInit();
    homeTaskItemBox = Hive.box(kBoxTodo);
    notesList.addAll(homeTaskItemBox.values);
    filteredNotesList.addAll(homeTaskItemBox.values);
  }

  archiveNote(HomeTaskItemModel item) async {
    item.isArchived = true;
    await item.save();
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
}
