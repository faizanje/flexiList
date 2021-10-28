import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:noteapp/constant/constant.dart';
import 'package:noteapp/models/home_task_item_model.dart';
import 'package:noteapp/screens/add_task_screen.dart';
import 'package:noteapp/utils/storage_utils.dart';

class NoteItem extends StatelessWidget {
  final List<Widget> list = [];
  final HomeTaskItemModel homeTaskItemModel;
  final Function(HomeTaskItemModel) onNoteItemClicked;
  NoteItem({
    Key? key,
    required this.homeTaskItemModel,
    required this.onNoteItemClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    addTitleToList();
    addCheckboxListTilesToList(context);
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      color: Color(Get.isDarkMode
          ? homeTaskItemModel.colorValue[1]
          : homeTaskItemModel.colorValue[0]),
      child: InkWell(
        onTap: () {
          onNoteItemClicked(homeTaskItemModel);
        },
        borderRadius: BorderRadius.circular(8),
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

  void addTitleToList() {
    this.list.add(Container(
          margin: EdgeInsets.only(left: 10),
          child: Text(
            this.homeTaskItemModel.title!.isNotEmpty
                ? this.homeTaskItemModel.title!
                : DateFormat(StorageUtils.getSettingsItem().dateFormat)
                    // : DateFormat.yMd()
                    //     .add_jm()
                    .format(this.homeTaskItemModel.dateTime),
            maxLines: 1,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ));
  }

  void addCheckboxListTilesToList(BuildContext context) {
    int index = 0;
    int laterItem = 0;
    int checkedItems = 0;
    final totalItems = homeTaskItemModel.todoItemList.length;
    homeTaskItemModel.todoItemList.forEach((element) {
      if (element.isChecked == null) {
        laterItem++;
      } else if (element.isChecked == true) {
        checkedItems++;
      }
      // if (true) {
      if (index++ < 2) {
        list.add(IgnorePointer(
          ignoring: true,
          child: CheckboxListTile(
            // tileColor: Colors.black,
            activeColor: Theme.of(context).primaryColor,
            checkColor: Theme.of(context).accentColor,
            dense: true,
            isThreeLine: false,
            contentPadding: EdgeInsets.all(0),
            controlAffinity: ListTileControlAffinity.leading,
            tristate: true,
            title: Text(
              '${element.taskName}',
              style: TextStyle(fontSize: 16),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            value: element.isChecked,
            onChanged: (bool? value) {},
          ),
        ));
      }
    });

    if (index > 2)
      list.add(Center(
          child: Text(
        '...',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      )));

    this.list.add(Container(
          margin: EdgeInsets.only(left: 10),
          child: Text(
            '$checkedItems/$totalItems completed',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ));

    if (laterItem > 0)
      this.list.add(Container(
            margin: EdgeInsets.only(left: 10),
            child: Text(
              '$laterItem/$totalItems for later',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ));
  }
}
