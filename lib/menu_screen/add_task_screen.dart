import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:noteapp/constant/constant.dart';
import 'package:noteapp/controllers/add_task_controller.dart';
import 'package:noteapp/controllers/task_item_controller.dart';
import 'package:noteapp/models/enums/task_status.dart';
import 'package:noteapp/models/taskItem.dart';

class AddTaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final addTaskController = Get.put(AddTaskController());
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {},
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
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: size.width * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Title',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
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
              ElevatedButton.icon(
                onPressed: () {
                  TaskItem taskItem = TaskItem(
                    taskStatus: TASK_STATUS.TODO,
                    isChecked: false,
                    taskName: addTaskController.textEditingController.text,
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
              // GetBuilder<TaskItemController>(builder: (controller) {
              //   return TaskCheckItem(
              //     value: controller.taskItem.value.isChecked,
              //     title: 'Item 1',
              //     onChanged: (newValue) {
              //       controller.setChecked(newValue);
              //     },
              //     onDownloadClicked: () {},
              //     onDeleteClicked: () {},
              //   );
              // }),
              SizedBox(
                height: size.height * 0.02,
              ),
              Expanded(
                child: GetBuilder<AddTaskController>(builder: (controller) {
                  return GroupedListView<TaskItem, String>(
                    elements: addTaskController.toDoTasksList,
                    groupBy: (element) => element.taskStatusStr,
                    groupSeparatorBuilder: (String groupByValue) {
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: kPrimaryColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 10),
                              child: Text(
                                groupByValue,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
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
                          value:
                              addTaskController.toDoTasksList[index].isChecked,
                          title:
                              addTaskController.toDoTasksList[index].taskName,
                          onChanged: (newValue) {
                            print(newValue);
                            var changed =
                                addTaskController.toDoTasksList[index];
                            changed.isChecked = newValue;
                            addTaskController.toDoTasksList[index] = changed;
                            switch (newValue) {
                              case null:
                                addTaskController.toDoTasksList[index]
                                    .taskStatus = TASK_STATUS.LATER;
                                break;
                              case true:
                                addTaskController.toDoTasksList[index]
                                    .taskStatus = TASK_STATUS.DONE;
                                break;
                              case false:
                                addTaskController.toDoTasksList[index]
                                    .taskStatus = TASK_STATUS.TODO;
                                break;
                            }
                          },
                          onDownloadClicked: () {},
                          onDeleteClicked: () {
                            addTaskController.toDoTasksList.remove(element);
                          },
                        ),
                      );
                    },
                  );
                }),
              ),
              Divider(),
              Center(
                child: Container(
                  margin: EdgeInsets.all(8),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text('ADD TASK'),
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TaskCheckItem extends StatelessWidget {
  final bool? value;
  final String title;
  final void Function(bool?) onChanged;
  final void Function() onDownloadClicked, onDeleteClicked;

  TaskCheckItem(
      {required this.value,
      required this.title,
      required this.onChanged,
      required this.onDownloadClicked,
      required this.onDeleteClicked});

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      activeColor: kPrimaryColor,
      dense: true,
      contentPadding: EdgeInsets.all(0),
      controlAffinity: ListTileControlAffinity.leading,
      tristate: true,
      title: Text(
        '$title',
        style: TextStyle(fontSize: 16),
      ),
      secondary: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: onDownloadClicked,
            icon: SvgPicture.asset(
              'assets/icons/download.svg',
            ),
          ),
          IconButton(
            onPressed: onDeleteClicked,
            icon: SvgPicture.asset(
              'assets/icons/bx_bxs-trash-alt.svg',
            ),
          ),
        ],
      ),
      value: value,
      // onChanged: (newValue) {
      //   print(newValue);
      //   onChanged(newValue);
      // },
      onChanged: (newValue) {
        onChanged(newValue);
      },
    );
  }
}
