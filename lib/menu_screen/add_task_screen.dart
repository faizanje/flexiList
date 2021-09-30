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
  Color hColor;

  AddTaskScreen(this.hColor);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final addTaskController = Get.put(AddTaskController());
    Color changeColor = Colors.white;
    String title = "";
    return SafeArea(
      child: Scaffold(
        backgroundColor: changeColor,
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
              onPressed: () {
                changeColor = addTaskController.color.value;
                print("tapedddd!");
              },
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
                onChanged: (newValue) {
                  title = newValue;
                },
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
                    taskName: title,
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
              Expanded(
                child: Obx(
                  () => ListView.builder(
                    itemBuilder: (context, index) {
                      return GetBuilder<AddTaskController>(
                          builder: (controller) {
                        return TaskCheckItem(
                          value: controller.toDoTasksList[index].isChecked,
                          title: controller.toDoTasksList[index].taskName,
                          onChanged: (newValue) {
                            print(newValue);
                            controller.setChecked(
                                controller.toDoTasksList[index], newValue);
                          },
                          onDownloadClicked: () {},
                          onDeleteClicked: () {
                            controller
                                .removeTask(controller.toDoTasksList[index]);
                          },
                        );
                      });
                    },
                    itemCount: addTaskController.toDoTasksList.length,
                  ),
                ), // () => GroupedListView<dynamic, String>(
                //   elements: addTaskController.toDoTasksList,
                //   groupBy: (element) => element.taskStatus.toString(),
                //   itemBuilder: (context, element) {
                //     return TaskCheckItem(
                //       value: element.isChecked,
                //       title: element.taskName,
                //       onChanged: (newValue) {
                //         print(newValue);
                //         element.isChecked = newValue;
                //       },
                //       onDownloadClicked: () {},
                //       onDeleteClicked: () {},
                //     );
                //   },
                //   groupSeparatorBuilder: (String value) => Padding(
                //     padding: const EdgeInsets.all(8.0),
                //     child: Text(
                //       value,
                //       textAlign: TextAlign.left,
                //       style: TextStyle(
                //           fontSize: 18, fontWeight: FontWeight.bold),
                //     ),
                //   ),
                // ),
                // ),
              ),
              // TaskCheckItem(
              //   value: true,
              //   title: 'Item 1',
              //   onChanged: (newValue) {},
              //   onDownloadClicked: () {},
              //   onDeleteClicked: () {},
              // ),
              // Divider(),
              // ElevatedButton(
              //   onPressed: () {},
              //   child: Text('Done'),
              //   style: ElevatedButton.styleFrom(
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(12),
              //     ),
              //   ),
              // ),
              // TaskCheckItem(
              //   value: checkBoxValue,
              //   title: 'Item 2',
              //   onChanged: (newValue) {
              //     setState(() {
              //       checkBoxValue = newValue;
              //     });
              //     print(newValue);
              //   },
              //   onDownloadClicked: () {},
              //   onDeleteClicked: () {},
              // ),
              Divider(),
              SizedBox(
                height: size.height * 0.02,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    changeColor = addTaskController.changePrimaryColor();
                    print("tapedddd!");
                  },
                  child: Text('ADD TASK'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
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

// class AddTaskScreen extends StatefulWidget {
//   const AddTaskScreen({Key? key}) : super(key: key);
//
//   @override
//   _AddTaskScreenState createState() => _AddTaskScreenState();
// }
//
// class _AddTaskScreenState extends State<AddTaskScreen> {
//   bool? checkBoxValue = false;
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           elevation: 0.0,
//           backgroundColor: Colors.white,
//           leading: IconButton(
//             onPressed: () {},
//             icon: SvgPicture.asset(
//               'assets/icons/bck btn.svg',
//             ),
//           ),
//           actions: [
//             IconButton(
//               onPressed: () {},
//               icon: SvgPicture.asset(
//                 'assets/icons/Vector.svg',
//               ),
//             ),
//             IconButton(
//               onPressed: () {},
//               icon: SvgPicture.asset(
//                 'assets/icons/Vector-1.svg',
//               ),
//             ),
//           ],
//         ),
//         body: Container(
//           margin: EdgeInsets.symmetric(horizontal: size.width * 0.04),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Title',
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
//               ),
//               SizedBox(
//                 height: size.height * 0.02,
//               ),
//               TextField(
//                 decoration: InputDecoration(
//                   hintText: 'Title Here',
//                   contentPadding: EdgeInsets.symmetric(vertical: 5),
//                   isDense: true,
//                 ),
//               ),
//               SizedBox(
//                 height: size.height * 0.02,
//               ),
//               ElevatedButton.icon(
//                 onPressed: () {},
//                 icon: Icon(Icons.add),
//                 label: Text('Add Item'),
//                 style: ElevatedButton.styleFrom(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//               ),
//               TaskCheckItem(
//                 value: true,
//                 title: 'Item 1',
//                 onChanged: (newValue) {},
//                 onDownloadClicked: () {},
//                 onDeleteClicked: () {},
//               ),
//               Divider(),
//               ElevatedButton(
//                 onPressed: () {},
//                 child: Text('Done'),
//                 style: ElevatedButton.styleFrom(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//               ),
//               TaskCheckItem(
//                 value: checkBoxValue,
//                 title: 'Item 2',
//                 onChanged: (newValue) {
//                   setState(() {
//                     checkBoxValue = newValue;
//                   });
//                   print(newValue);
//                 },
//                 onDownloadClicked: () {},
//                 onDeleteClicked: () {},
//               ),
//               Divider(),
//               SizedBox(
//                 height: size.height * 0.02,
//               ),
//               Center(
//                 child: ElevatedButton(
//                   onPressed: () {},
//                   child: Text('ADD TASK'),
//                   style: ElevatedButton.styleFrom(
//                     padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

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
