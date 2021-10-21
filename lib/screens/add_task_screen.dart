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

class AddTaskScreen extends StatelessWidget {
  final HomeTaskItemModel? homeTaskItemModel;
  AddTaskScreen({this.homeTaskItemModel});

  @override
  Widget build(BuildContext context) {
    final colors = [
      Colors.white,
      Colors.yellow,
      Colors.greenAccent,
      Colors.cyan,
      Colors.redAccent,
      Colors.deepPurple.shade200,
      Colors.amber.shade300,
      Colors.deepOrangeAccent,
      Colors.white60
    ];
    final size = MediaQuery.of(context).size;
    final addTaskController = Get.put(AddTaskController());
    final sideBarController = Get.put(SidebarController());
    final notesListController = Get.find<NotesListController>();
    addTaskController.init(this.homeTaskItemModel);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
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
                    ),
                  ),
                  actions: [
                    IconButton(
                      color: Colors.redAccent,
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
                                ? kPrimaryColor
                                : Colors.grey,
                            height: kSizeCurrency,
                          ),
                        ),
                      ),
                    ),
                    if (addTaskController.isEditing)
                      IconButton(
                        onPressed: () {
                          addTaskController.isArchived
                              ? addTaskController.unArchiveTask()
                              : addTaskController.archiveTask();
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
                            color: kPrimaryColor,
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
                          height: size.height * 0.02,
                        ),
                        TextField(
                          controller: addTaskController.textEditingController,
                          decoration: InputDecoration(
                            hintText: 'kTitleHere'.tr,
                            contentPadding: EdgeInsets.symmetric(vertical: 5),
                            isDense: true,
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.02,
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
                            icon: Icon(Icons.add),
                            label: Text('kAddItem'.tr),
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GetBuilder<AddTaskController>(
                            builder: (controller) {
                              return GroupedListView<TodoItemModel, String>(
                                elements: addTaskController.toDoTasksList,
                                // itemComparator: (element1, element2) => element1
                                //     .taskName
                                //     .compareTo(element2.taskName),
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
                                          color: kPrimaryColor,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 25, vertical: 8),
                                          child: Text(
                                            element.taskStatusStr.tr,
                                            style: TextStyle(
                                              color: Colors.white,
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
                                    () => Container(
                                      margin: EdgeInsets.only(right: 30),
                                      child: TaskCheckItem(
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
                                          addTaskController
                                              .toDoTasksList[index] = changed;
                                          switch (newValue) {
                                            case null:
                                              addTaskController
                                                      .toDoTasksList[index]
                                                      .taskStatus =
                                                  TASK_STATUS.LATER;
                                              break;
                                            case true:
                                              addTaskController
                                                      .toDoTasksList[index]
                                                      .taskStatus =
                                                  TASK_STATUS.DONE;
                                              break;
                                            case false:
                                              addTaskController
                                                      .toDoTasksList[index]
                                                      .taskStatus =
                                                  TASK_STATUS.TODO;
                                              break;
                                          }
                                          addTaskController.update();
                                        },
                                        onDownloadClicked: () {},
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
                              child: Text(addTaskController.isEditing
                                  ? 'kEditText'.tr
                                  : 'kAddTask'.tr),
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 50, vertical: 20),
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
}

class SideColorPanel extends StatelessWidget {
  const SideColorPanel({
    Key? key,
    required this.colors,
  }) : super(key: key);

  final List<Color> colors;

  @override
  Widget build(BuildContext context) {
    final addTaskController = Get.find<AddTaskController>();
    final sidebarController = Get.find<SidebarController>();
    return Obx(
      () => AnimatedPositioned(
        curve: Curves.bounceOut,
        duration: Duration(milliseconds: 500),

        right: sidebarController.isSlideBarOpen.value ? 0 : -60,
        bottom: 0,
        top: 0,
        // child: ClipPath(
        child: Row(
          children: [
            Stack(
              children: [
                // Transform.rotate(
                //   angle: 3.14,
                // transform: Matrix4.rotationX(pi),
                // child:
                Container(
                  height: 250,
                  child: CustomPaint(
                    size: Size(64, (64 * 1.5).toDouble()),
                    painter: RPSCustomPainter(),
                  ),
                ),
                // ),
                Positioned(
                  right: 0,
                  top: -5,
                  bottom: 0,
                  child: Container(
                      child: sidebarController.isSlideBarOpen.value
                          ? IconButton(
                              onPressed: () {
                                sidebarController.isSlideBarOpen.toggle();
                              },
                              icon: Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Colors.blue,
                              ),
                            )
                          : IconButton(
                              onPressed: () {
                                sidebarController.isSlideBarOpen.toggle();
                              },
                              icon: Icon(
                                Icons.opacity,
                                color: Colors.blue,
                                size: 26,
                              ),
                            )),
                )
              ],
            ),
            Container(
              decoration: BoxDecoration(
                color: kNavbarColor,
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              constraints: BoxConstraints(
                maxHeight: 500.h,
              ),
              width: 60,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 40.0),
                child: ListView.separated(
                  separatorBuilder: (context, index) => SizedBox(
                    height: 5,
                  ),
                  shrinkWrap: true,
                  itemCount: colors.length,
                  itemBuilder: (context, index) => Align(
                    alignment: Alignment.center,
                    child: CircularColorContainer(
                      containerColor: colors[index],
                      onColorChanged: (Color color) {
                        addTaskController.color.value = color;
                      },
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
