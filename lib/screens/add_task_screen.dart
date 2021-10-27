import 'dart:core';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:hive/hive.dart';
import 'package:noteapp/components/circular_color_container.dart';
import 'package:noteapp/components/side_color_panel.dart';
import 'package:noteapp/components/slide_color_panel_design.dart';
import 'package:noteapp/components/task_item.dart';
import 'package:noteapp/constant/constant.dart';
import 'package:noteapp/constant/strings.dart';
import 'package:noteapp/controllers/add_task_controller.dart';
import 'package:noteapp/controllers/notes_list_controller.dart';
import 'package:noteapp/controllers/reports_controller.dart';
import 'package:noteapp/models/enums/task_status.dart';
import 'package:noteapp/models/home_task_item_model.dart';
import 'package:noteapp/models/todo_item.dart';
import 'package:noteapp/controllers/sidebar_controller.dart';
import 'package:noteapp/utils/custom_color_scheme.dart';

class AddTaskScreen extends StatelessWidget {
  final HomeTaskItemModel? homeTaskItemModel;
  AddTaskScreen({this.homeTaskItemModel});

  @override
  Widget build(BuildContext context) {
    print('${Get.theme.brightness}');

    // final colors = [
    //   Theme.of(context).colorScheme.listColor1,
    //   Colors.yellow,
    //   Colors.greenAccent,
    //   Colors.cyan,
    //   Colors.redAccent,
    //   Colors.deepPurple.shade200,
    //   Colors.amber.shade300,
    //   Colors.deepOrangeAccent,
    //   Colors.white60
    // ];
    // final size = MediaQuery.of(context).size;
    final addTaskController = Get.put(AddTaskController());
    final sideBarController = Get.put(SidebarController());
    final notesListController = Get.find<NotesListController>();
    print('Add Task Screen Called ${Theme.of(context).brightness}');
    addTaskController.init(this.homeTaskItemModel);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        // backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Obx(
              () => Container(
                height: double.infinity,
                width: double.infinity,
                color: addTaskController.color.value,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppBar(
                  elevation: 0.0,
                  backgroundColor: Colors.transparent,
                  leading: IconButton(
                    onPressed: () {
                      Get.back();
                      // Navigator.pop(context);
                    },
                    icon: SvgPicture.asset(
                      'assets/icons/bck btn.svg',
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  actions: [
                    IconButton(
                      onPressed: () {
                        addTaskController.isCurrencySelected.toggle();
                      },
                      icon: Obx(
                        () => Tooltip(
                          message: 'Toggle currency',
                          child: SvgPicture.asset(
                            addTaskController
                                .settingsModel.currencyItem.iconPath,
                            color: addTaskController.isCurrencySelected.value ==
                                    true
                                ? Theme.of(context).primaryColor
                                : Colors.grey,
                            height: kSizeCurrency,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        sideBarController.isSlideBarOpen.toggle();
                      },
                      icon: Image.asset(
                        'assets/icons/bucket.png',
                        height: kSizeCurrency - 10,
                        color: context.theme.primaryColor,
                      ),
                    ),
                    if (addTaskController.isEditing)
                      IconButton(
                        onPressed: () {
                          addTaskController.isArchived
                              ? notesListController
                                  .unArchiveNote(homeTaskItemModel!)
                              : notesListController
                                  .archiveNote(homeTaskItemModel!);

                          notesListController.update();
                          Get.back();
                        },
                        icon: Tooltip(
                          message: addTaskController.isArchived
                              ? 'Unarchive'
                              : 'Archive',
                          child: Icon(
                            addTaskController.isArchived
                                ? Icons.unarchive
                                : Icons.archive,
                            color: Theme.of(context).primaryColor,
                            size: 30,
                          ),
                        ),
                      ),
                  ],
                ),
                Flexible(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'kTitle'.tr,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30),
                        ),
                        SizedBox(
                          height: 10,
                          // height: size.height * 0.02,
                        ),
                        TextField(
                          controller: addTaskController.textEditingController,
                          // autofocus: false,
                          decoration: InputDecoration(
                            hintText: 'kTitleHere'.tr,
                            contentPadding: EdgeInsets.symmetric(vertical: 5),
                            isDense: true,
                          ),
                        ),
                        SizedBox(
                          // height: size.height * 0.02,
                          height: 10,
                        ),
                        Center(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              TodoItemModel taskItem = TodoItemModel(
                                taskStatus: TASK_STATUS.TODO,
                                isChecked: false,
                                taskName: '',
                              );
                              addTaskController.addTask(taskItem);
                            },
                            icon: Icon(
                              Icons.add,
                              color: context.theme.accentColor,
                            ),
                            label: Text(
                              'kAddItem'.tr,
                              style: TextStyle(
                                  color: context.theme.accentColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GetBuilder<AddTaskController>(
                            builder: (controller) {
                              return GroupedListView<TodoItemModel, String>(
                                elements: addTaskController.toDoTasksList,
                                groupComparator: (value1, value2) {
                                  print('$value1.comapreTo($value2)');
                                  if (value1 == 'Todo') {
                                    return 0;
                                  } else if (value1 == 'Later' &&
                                      value2 == 'Done') {
                                    return 0;
                                  } else {
                                    return 1;
                                  }
                                },
                                groupBy: (element) => element.taskStatusStr,
                                groupHeaderBuilder: (element) {
                                  print('group header builder called');
                                  return Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 25, vertical: 8),
                                          child: Text(
                                            element.taskStatusStr.tr,
                                            style: TextStyle(
                                              color: context.theme.accentColor,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                                indexedItemBuilder: (context, element, index) {
                                  return Obx(
                                    () => TaskCheckItem(
                                      price: addTaskController
                                          .toDoTasksList[index].price,
                                      value: addTaskController
                                          .toDoTasksList[index].isChecked,
                                      title: addTaskController
                                          .toDoTasksList[index].taskName,
                                      onTaskTitleChanged: (newTitle) {
                                        addTaskController.toDoTasksList[index]
                                            .taskName = newTitle;
                                      },
                                      onChanged: (newValue) {
                                        print(newValue);
                                        var changed = addTaskController
                                            .toDoTasksList[index];
                                        changed.isChecked = newValue;
                                        addTaskController.toDoTasksList[index] =
                                            changed;
                                        updateGroupHeader(
                                            newValue, addTaskController, index);
                                        addTaskController.update();
                                      },
                                      onDownloadClicked: () {
                                        final value = addTaskController
                                            .toDoTasksList[index].isChecked;
                                        if (value == null) {
                                          addTaskController.toDoTasksList[index]
                                              .isChecked = false;
                                        } else {
                                          addTaskController.toDoTasksList[index]
                                              .isChecked = null;
                                        }
                                        updateGroupHeader(
                                            addTaskController
                                                .toDoTasksList[index].isChecked,
                                            addTaskController,
                                            index);
                                        addTaskController.update();
                                      },
                                      onDeleteClicked: () {
                                        addTaskController.removeTask(element);
                                      },
                                      isCurrencyToggled: addTaskController
                                          .isCurrencySelected.value,
                                      onPriceChanged: (int newPrice) {
                                        addTaskController.toDoTasksList[index]
                                            .price = newPrice;
                                      },
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                        Divider(),
                        Center(
                          child: Container(
                            margin: EdgeInsets.all(8),
                            child: ElevatedButton(
                              onPressed: () async {
                                if (addTaskController.isEditing) {
                                  this.homeTaskItemModel!
                                    ..todoItemList =
                                        addTaskController.toDoTasksList
                                    ..colorValue =
                                        addTaskController.color.value.value
                                    ..isArchived = addTaskController.isArchived
                                    ..isCurrencySelected = addTaskController
                                        .isCurrencySelected.value
                                    ..title =
                                        /*addTaskController
                                            .textEditingController
                                            .value
                                            .text
                                            .isEmpty
                                        ? DateTime.now()
                                            .toLocal()
                                            .toIso8601String()
                                        : */
                                        addTaskController
                                            .textEditingController.value.text;

                                  try {
                                    await homeTaskItemModel!.save();
                                  } catch (e) {
                                    print('Exception ${e.toString()}');
                                  }
                                } else {
                                  HomeTaskItemModel homeTaskItemModel =
                                      HomeTaskItemModel(
                                    title:
                                        /*addTaskController
                                            .textEditingController
                                            .value
                                            .text
                                            .isEmpty
                                        ? DateTime.now()
                                            .toLocal()
                                            .toIso8601String()
                                        :*/
                                        addTaskController
                                            .textEditingController.value.text,
                                    todoItemList:
                                        addTaskController.toDoTasksList,
                                    colorValue:
                                        addTaskController.color.value.value,
                                    isArchived: addTaskController.isArchived,
                                    isCurrencySelected: addTaskController
                                        .isCurrencySelected.value,
                                  );
                                  // homeTaskItemModel.order =
                                  //     homeTaskItemModel.key;
                                  notesListController.notesList
                                      .add(homeTaskItemModel);
                                  notesListController.filteredNotesList
                                      .add(homeTaskItemModel);

                                  await notesListController.homeTaskItemBox
                                      .add(homeTaskItemModel);
                                }

                                notesListController.update();
                                try {
                                  Get.find<ReportsController>().initList();
                                } catch (e) {
                                  print('Exception $e');
                                }

                                Get.back();
                                Get.snackbar('kTaskAdded'.tr, 'kTaskAdded'.tr);
                              },
                              child: Text(
                                addTaskController.isEditing
                                    ? 'kEditText'.tr
                                    : 'kAddTask'.tr,
                                style: TextStyle(
                                    color: context.theme.accentColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 50, vertical: 15),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            SideColorPanel(colors: colors),
          ],
        ),
      ),
    );
  }

  void updateGroupHeader(
      bool? newValue, AddTaskController addTaskController, int index) {
    switch (newValue) {
      case null:
        addTaskController.toDoTasksList[index].taskStatus = TASK_STATUS.LATER;
        break;
      case true:
        addTaskController.toDoTasksList[index].taskStatus = TASK_STATUS.DONE;
        break;
      case false:
        addTaskController.toDoTasksList[index].taskStatus = TASK_STATUS.TODO;
        break;
    }
  }
}
