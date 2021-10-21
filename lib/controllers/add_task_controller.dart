import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive/hive.dart';
import 'package:noteapp/constant/constant.dart';
import 'package:noteapp/models/home_task_item_model.dart';
import 'package:noteapp/models/item_entity.dart';
import 'package:noteapp/models/settings_model.dart';
import 'package:noteapp/models/todo_item.dart';
import 'package:noteapp/utils/storage_utils.dart';

class AddTaskController extends GetxController {
  late HomeTaskItemModel homeTaskItemModel;
  final RxList<TodoItemModel> toDoTasksList = RxList([]);
  final RxBool isCurrencySelected = false.obs;
  final Rx<Color> color = Rx<Color>(Colors.white);
  final isSlidePanelOpen = false.obs;
  TextEditingController textEditingController = TextEditingController();
  late Box<HomeTaskItemModel> homeTaskItemBox;
  bool isEditing = false;
  bool isArchived = false;
  late SettingsModel settingsModel;
  init(HomeTaskItemModel? homeTaskItemModel) {
    if (homeTaskItemModel != null) {
      this.homeTaskItemModel = homeTaskItemModel;
      this.isCurrencySelected.value = this.homeTaskItemModel.isCurrencySelected;
      this.color.value = Color(this.homeTaskItemModel.colorValue);
      this.isArchived = homeTaskItemModel.isArchived;
      this.toDoTasksList.addAll(this.homeTaskItemModel.todoItemList);
      print('IsInBox ${this.homeTaskItemModel.isInBox}');
      this.isEditing = true;
      this.textEditingController.text = this.homeTaskItemModel.title!;
    }
  }

  @override
  void onInit() {
    super.onInit();
    homeTaskItemBox = Hive.box(kBoxTodo);
    settingsModel = StorageUtils.getSettingsItem();
  }

  archiveTask() async {
    homeTaskItemModel.isArchived = true;
    // await homeTaskItemBox.add(homeTaskItemModel)
    await homeTaskItemModel.save();
  }

  unArchiveTask() async {
    homeTaskItemModel.isArchived = false;
    // await homeTaskItemBox.add(homeTaskItemModel);
    await homeTaskItemModel.save();
  }

  setChecked(TodoItemModel taskItem, bool? value) {
    taskItem.isChecked = value;
    update();
  }

  void addTask(TodoItemModel taskItem) {
    toDoTasksList.add(taskItem);
    // textEditingController.clear();
    update();
  }

  changePrimaryColor() {
    color.value = kNavbarColor;
  }

  randomizeColor() {
    color.value =
        Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
  }

  removeTask(TodoItemModel taskItem) {
    toDoTasksList.remove(taskItem);
    update();
  }
}
