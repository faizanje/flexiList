import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:noteapp/components/done_button.dart';
import 'package:noteapp/components/skip_button.dart';
import 'package:noteapp/constant/constant.dart';
import 'package:get/get.dart';
import 'package:noteapp/constant/strings.dart';
import 'package:noteapp/controllers/add_task_controller.dart';
import 'package:noteapp/controllers/notes_list_controller.dart';
import 'package:noteapp/controllers/reports_controller.dart';
import 'package:noteapp/utils/storage_utils.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final addTask = Get.find<AddTaskController>();
    // final notesListController = Get.find<NotesListController>();
    final reportsController = Get.put(ReportsController());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          'kTitleReport'.tr,
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      // backgroundColor: Color(0xffF9F9F9),
      body: Container(
        padding: EdgeInsets.all(10),
        child: GetX<NotesListController>(
          initState: (state) {
            print('Inited');
          },
          init: NotesListController(),
          builder: (notesListController) => ListView.builder(
            itemCount: notesListController.completedNotes.length,
            itemBuilder: (BuildContext context, int index) {
              // return Container();
              return Obx(
                () {
                  return ExpansionPanelList(
                    animationDuration: Duration(milliseconds: 500),
                    dividerColor:
                        Theme.of(context).primaryColor.withOpacity(0.5),
                    elevation: 2,
                    children: [
                      ExpansionPanel(
                        canTapOnHeader: true,
                        body: Container(
                          alignment: AlignmentDirectional.centerStart,
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              WidgetButtonDone(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: notesListController
                                    .completedNotes[index].todoItemList
                                    .map((element) => IgnorePointer(
                                          ignoring: true,
                                          child: CheckboxListTile(
                                            // tileColor: Colors.black,
                                            activeColor:
                                                Theme.of(context).primaryColor,
                                            checkColor:
                                                Theme.of(context).accentColor,
                                            dense: true,
                                            isThreeLine: false,
                                            contentPadding: EdgeInsets.all(0),
                                            controlAffinity:
                                                ListTileControlAffinity.leading,
                                            tristate: true,
                                            title: Text(
                                              '${element.taskName}',
                                              style: TextStyle(fontSize: 16),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            secondary: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                if (notesListController
                                                    .completedNotes[index]
                                                    .isCurrencySelected)
                                                  Flexible(
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        SvgPicture.asset(
                                                          StorageUtils
                                                                  .getSettingsItem()
                                                              .currencyItem
                                                              .iconPath,
                                                          color:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                          height: kSizeCurrency,
                                                        ),
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 5.w),
                                                          width: 50.w,
                                                          height: 35.h,
                                                          child: Center(
                                                            child: TextField(
                                                              controller: TextEditingController()
                                                                ..text = element
                                                                    .price
                                                                    .toString(),
                                                              maxLines: 1,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                fontSize: 12.sp,
                                                              ),
                                                              decoration:
                                                                  InputDecoration(
                                                                contentPadding:
                                                                    EdgeInsets.symmetric(
                                                                        vertical:
                                                                            5),
                                                                isDense: true,
                                                                border:
                                                                    OutlineInputBorder(),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                              ],
                                            ),
                                            value: element.isChecked,
                                            onChanged: (bool? value) {},
                                          ),
                                        ))
                                    .toList(),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              if (notesListController
                                  .completedNotes[index].isCurrencySelected)
                                Row(
                                  children: [
                                    Text(
                                      'Total ',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SvgPicture.asset(
                                      StorageUtils.getSettingsItem()
                                          .currencyItem
                                          .iconPath,
                                      color: Get.theme.primaryColor,
                                      height: kSizeCurrency - 5,
                                    ),
                                    Text(
                                      '${notesListController.completedNotes[index].todoItemList.fold(0, (int previousValue, element) => element.price + previousValue)}',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                )
                            ],
                          ),
                        ),
                        headerBuilder: (BuildContext context, bool isExpanded) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Text(
                              notesListController
                                      .completedNotes[index].title!.isNotEmpty
                                  ? notesListController
                                      .completedNotes[index].title!
                                  : DateFormat.yMd().add_jm().format(
                                      notesListController
                                          .completedNotes[index].dateTime),
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                          );
                        },
                        isExpanded: reportsController.isExpandedList[index],
                      )
                    ],
                    expansionCallback: (int item, bool status) {
                      reportsController.isExpandedList[index] =
                          !reportsController.isExpandedList[index];
                      print('toggled $item $status');
                    },
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  getBody() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      width: double.infinity,
      height: 110,
      decoration: BoxDecoration(
        color: Color(0xffFFFFFF),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
        borderRadius: BorderRadius.all(Radius.circular(13)),
      ),
      child: Row(
        children: <Widget>[
          Column(
            children: <Widget>[
              Text(
                'kTitle'.tr,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),
              WidgetButtonDone(),
            ],
          ),
          Column(
            children: <Widget>[],
          ),
        ],
      ),
    );
  }
}
