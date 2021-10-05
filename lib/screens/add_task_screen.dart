import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:noteapp/components/circular_color_container.dart';
import 'package:noteapp/components/slide_color_panel_design.dart';
import 'package:noteapp/components/task_item.dart';
import 'package:noteapp/constant/constant.dart';
import 'package:noteapp/controllers/add_task_controller.dart';
import 'package:noteapp/models/enums/task_status.dart';
import 'package:noteapp/models/taskItem.dart';
import 'dart:ui' as ui;
import 'package:noteapp/controllers/sidebar_controller.dart';

class AddTaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = [
      Colors.white,
      Colors.yellow,
      Colors.greenAccent,
      Colors.cyan,
      Colors.redAccent,
      Colors.deepPurple.shade200
    ];
    final size = MediaQuery.of(context).size;
    final addTaskController = Get.put(AddTaskController());
    final sidebarController = Get.put(SidebarController());

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
                      onPressed: () {},
                      icon: SvgPicture.asset(
                        'assets/icons/Vector.svg',
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset(
                        'assets/icons/Vector-1.svg',
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
                          'Title',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30),
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        TextField(
                          controller: addTaskController.textEditingController,
                          decoration: InputDecoration(
                            hintText: 'Title Here',
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
                              TaskItem taskItem = TaskItem(
                                taskStatus: TASK_STATUS.TODO,
                                isChecked: false,
                                taskName: addTaskController
                                    .textEditingController.text,
                              );
                              addTaskController.addTask(taskItem);
                            },
                            icon: Icon(Icons.add),
                            label: Text('Add Item'),
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
                              return GroupedListView<TaskItem, String>(
                                elements: addTaskController.toDoTasksList,
                                groupComparator: (value1, value2) {
                                  print('$value1.comapreTo($value2)');
                                  return value2.compareTo(value1);
                                },
                                groupBy: (element) => element.taskStatusStr,
                                groupSeparatorBuilder: (String groupByValue) {
                                  return AnimatedContainer(
                                    duration: Duration(milliseconds: 600),
                                    child: Row(
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
                                              groupByValue,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                indexedItemBuilder: (context, element, index) {
                                  return Obx(
                                    () => AnimatedContainer(
                                      duration: Duration(milliseconds: 300),
                                      child: TaskCheckItem(
                                        value: addTaskController
                                            .toDoTasksList[index].isChecked,
                                        title: addTaskController
                                            .toDoTasksList[index].taskName,
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
                              onPressed: () {},
                              child: Text('ADD TASK'),
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
            Obx(
              () => AnimatedPositioned(
                curve: Curves.elasticInOut,
                duration: Duration(milliseconds: 500),
                right: sidebarController.isSlideBarOpen.value ? 0 : -60,
                bottom: 0,
                top: 0,
                // child: ClipPath(
                child: Row(
                  children: [
                    Container(
                      child: Stack(children: [
                        CustomPaint(
                          size: Size(174, 200),
                          painter: RPSCustomPainter(),
                        ),
                        Positioned(
                          right: 10,
                          bottom: 90.2,
                          child: Container(
                            alignment: Alignment.centerRight,
                            width: 30,
                            height: 30,
                            child: sidebarController.isSlideBarOpen.value
                                ? IconButton(
                                    onPressed: () {
                                      sidebarController.isSlideBarOpen.toggle();
                                      print('opened');
                                    },
                                    icon: Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      color: Colors.blue,
                                    ),
                                  )
                                : IconButton(
                                    onPressed: () {
                                      sidebarController.isSlideBarOpen.toggle();
                                      print('closed ');
                                    },
                                    icon: Icon(
                                      Icons.opacity,
                                      color: Colors.blue,
                                      size: 26,
                                    )),
                          ),
                        ),
                      ]),
                    ),

                    // InkWell(
                    //   onTap: () {
                    //     sidebarController.isSlideBarOpen.toggle();
                    //   },
                    //   child: CustomPaint(
                    //       size: Size(174, 200),
                    //       painter: RPSCustomPainter(),
                    //       child: sidebarController.isSlideBarOpen.value
                    //           ? IconButton(
                    //               onPressed: () {
                    //                 sidebarController.isSlideBarOpen.toggle();
                    //                 print('opened');
                    //               },
                    //               icon: Icon(
                    //                 Icons.arrow_forward_ios_rounded,
                    //                 color: Colors.blue,
                    //               ),
                    //             )
                    //           : IconButton(
                    //               onPressed: () {
                    //                 sidebarController.isSlideBarOpen.toggle();
                    //                 print('closed ');
                    //               },
                    //               icon: Icon(
                    //                 Icons.opacity,
                    //                 color: Colors.blue,
                    //                 size: 26,
                    //               ),
                    //             )),
                    // ),
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
            ),
          ],
        ),
      ),
    );
  }
}
