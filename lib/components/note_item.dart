import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noteapp/constant/constant.dart';
import 'package:noteapp/models/home_task_item_model.dart';
import 'package:noteapp/screens/add_task_screen.dart';

class NoteItem extends StatelessWidget {
  final List<Widget> list = [];
  final HomeTaskItemModel homeTaskItemModel;

  NoteItem({
    Key? key,
    required this.homeTaskItemModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    addCheckboxListTilesToList();
    return InkWell(
      onTap: () {
        Get.to(() => AddTaskScreen(
              homeTaskItemModel: homeTaskItemModel,
            ));
      },
      child: Card(
        color: Color(homeTaskItemModel.colorValue),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: this.list,
          ),
        ),
      ),
    );
  }

  void addCheckboxListTilesToList() {
    int index = 0;
    homeTaskItemModel.todoItemList.forEach((element) {
      // if (true) {
      if (index++ <= 3) {
        list.add(IgnorePointer(
          ignoring: true,
          child: CheckboxListTile(
            activeColor: kPrimaryColor,
            dense: true,
            contentPadding: EdgeInsets.all(0),
            controlAffinity: ListTileControlAffinity.leading,
            tristate: true,
            title: Text(
              '${element.taskName}',
              style: TextStyle(fontSize: 16),
            ),
            value: element.isChecked,
            onChanged: (bool? value) {},
          ),
        ));
      }
    });

    list.add(Center(
        child: Text(
      '...',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    )));
  }
}
