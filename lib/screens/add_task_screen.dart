import 'dart:core';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
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
import 'package:noteapp/models/enums/list_type.dart';
import 'package:noteapp/models/enums/task_status.dart';
import 'package:noteapp/models/home_task_item_model.dart';
import 'package:noteapp/models/todo_item.dart';
import 'package:noteapp/controllers/sidebar_controller.dart';
import 'package:noteapp/utils/custom_color_scheme.dart';
import 'package:noteapp/utils/grouped_list_view.dart';
import 'package:noteapp/utils/snack_bar_utils.dart';
import 'package:noteapp/utils/storage_utils.dart';

class AddTaskScreen extends StatelessWidget {
  final HomeTaskItemModel? homeTaskItemModel;

  AddTaskScreen({this.homeTaskItemModel});

  List<dynamic> lists = [
    {"headerText": 'Todo', "listType": ListType.TodoList},
    {"headerText": 'Later', "listType": ListType.LaterList},
    {"headerText": 'Done', "listType": ListType.DoneList}
  ];

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
    return WillPopScope(
      onWillPop: () async {
        if (StorageUtils.getSettingsItem().autoSave) {
          await saveNote(addTaskController, notesListController);
          notesListController.update();
        }
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        // backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Obx(
              () => Container(
                height: double.infinity,
                width: double.infinity,
                color: Get.isDarkMode
                    ? addTaskController.color[1]
                    : addTaskController.color[0],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppBar(
                  elevation: 0.0,
                  backgroundColor: Colors.transparent,
                  leading: IconButton(
                    onPressed: () async {
                      Get.back();
                      if (StorageUtils.getSettingsItem().autoSave) {
                        await saveNote(addTaskController, notesListController);
                        notesListController.update();
                      }
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
                          onSubmitted: (value) {
                            addTaskController.addEmptyTask();
                          },
                          textInputAction: TextInputAction.next,
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
                              addTaskController.addEmptyTask();
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
                            print('Builder called singleChildScrollView');
                            return SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ...lists.map(
                                    (e) {
                                      List<TodoItemModel> list =
                                          getListByListType(
                                              e['listType'], addTaskController);
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ListHeader(
                                            headerText: e['headerText'],
                                            isDisabled: list.isEmpty,
                                          ),
                                          ...buildList(
                                              addTaskController, e['listType']),
                                          SizedBox(
                                            height: 2.h,
                                          ),
                                        ],
                                      );
                                    },
                                  ).toList(),
                                ],
                              ),
                            );
                          }),
                        ),
                        Divider(),
                        if (!StorageUtils.getSettingsItem().autoSave)
                          Center(
                            child: Container(
                              margin: EdgeInsets.all(8),
                              child: ElevatedButton(
                                onPressed: () async {
                                  Get.back();
                                  await saveNote(
                                      addTaskController, notesListController);
                                  notesListController.update();
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
            SideColorPanel(colors: kColorsList),
          ],
        ),
      ),
    );
  }

  Future<void> saveNote(AddTaskController addTaskController,
      NotesListController notesListController) async {
    if (addTaskController.isEditing) {
      await editNote(addTaskController);
      SnackBarUtils.showGetXSnackBar('kTaskEdited'.tr, addBottomSpace: true);
    } else {
      await addNote(addTaskController, notesListController);
      SnackBarUtils.showGetXSnackBar('kTaskAdded'.tr, addBottomSpace: true);
    }
  }

  Future<void> addNote(AddTaskController addTaskController,
      NotesListController notesListController) async {
    HomeTaskItemModel homeTaskItemModel = HomeTaskItemModel(
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
          addTaskController.textEditingController.value.text,
      todoItemList: addTaskController.toDoTasksList,
      colorValue: [
        addTaskController.color[0].value,
        addTaskController.color[1].value
      ],
      isArchived: addTaskController.isArchived,
      isCurrencySelected: addTaskController.isCurrencySelected.value,
    );
    // homeTaskItemModel.order =
    //     homeTaskItemModel.key;
    notesListController.notesList.add(homeTaskItemModel);
    notesListController.filteredNotesList.add(homeTaskItemModel);

    await notesListController.homeTaskItemBox.add(homeTaskItemModel);
  }

  Future<void> editNote(AddTaskController addTaskController) async {
    this.homeTaskItemModel!
      ..todoItemList = addTaskController.toDoTasksList
      ..colorValue = [
        addTaskController.color[0].value,
        addTaskController.color[1].value
      ]
      ..isArchived = addTaskController.isArchived
      ..isCurrencySelected = addTaskController.isCurrencySelected.value
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
          addTaskController.textEditingController.value.text;

    try {
      await homeTaskItemModel!.save();
    } catch (e) {
      print('Exception ${e.toString()}');
    }
  }

  List<Widget> buildList(
      AddTaskController addTaskController, ListType listType) {
    List<TodoItemModel> list = getListByListType(listType, addTaskController);

    return list.map((element) {
      bool isLastElement = list.last == element;
      bool shouldFocus = (listType == ListType.TodoList) && isLastElement;
      return buildTaskCheckItem(addTaskController, element, shouldFocus);
    }).toList();
  }

  List<TodoItemModel> getListByListType(
      ListType listType, AddTaskController addTaskController) {
    late List<TodoItemModel> list;
    switch (listType) {
      case ListType.TodoList:
        list = addTaskController.todoHeaderTasksList;
        break;
      case ListType.LaterList:
        list = addTaskController.laterHeaderTasksList;
        break;
      case ListType.DoneList:
        list = addTaskController.doneHeaderTasksList;
        break;
    }
    return list;
  }

  Widget buildTaskCheckItem(
      AddTaskController addTaskController, TodoItemModel element,
      [bool shouldFocus = false]) {
    print('shouldFocus: $shouldFocus');
    return Obx(
      () => TaskCheckItem(
        price: element.price,
        value: element.isChecked,
        title: element.taskName,
        shouldFocusTextField: shouldFocus,
        onTaskTitleChanged: (newTitle) {
          element.taskName = newTitle;
        },
        onChanged: (newValue) {
          print(newValue);
          var changed = element;
          changed.isChecked = newValue;
          element = changed;
          // updateGroupHeader(newValue, addTaskController, index);
          updateGroupHeader(newValue, element);
          addTaskController.shouldFocusKeyboard = false;
          addTaskController.update();
        },
        onDownloadClicked: () {
          final value = element.isChecked;
          if (value == null) {
            element.isChecked = false;
          } else {
            element.isChecked = null;
          }
          updateGroupHeader(
              element.isChecked,
              // addTaskController, index);
              element);
          addTaskController.shouldFocusKeyboard = false;
          addTaskController.update();
        },
        onDeleteClicked: () {
          addTaskController.removeTask(element);
        },
        isCurrencyToggled: addTaskController.isCurrencySelected.value,
        onPriceChanged: (int newPrice) {
          element.price = newPrice;
        },
      ),
    );
  }

  void updateGroupHeader(
      // bool? newValue, AddTaskController addTaskController, int index) {
      bool? newValue,
      TodoItemModel element) {
    switch (newValue) {
      case null:
        element.taskStatus = TASK_STATUS.LATER;
        break;
      case true:
        element.taskStatus = TASK_STATUS.DONE;
        break;
      case false:
        element.taskStatus = TASK_STATUS.TODO;
        break;
    }
  }
}

class ListHeader extends StatelessWidget {
  const ListHeader({
    Key? key,
    required this.headerText,
    this.isDisabled = true,
  }) : super(key: key);

  final String headerText;
  final bool isDisabled;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isDisabled
            ? Theme.of(context).disabledColor
            : Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 8),
        child: Text(
          headerText,
          style: TextStyle(
            color: context.theme.accentColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
