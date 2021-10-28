import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:noteapp/components/done_button.dart';
import 'package:noteapp/components/no_reports_found.dart';
import 'package:noteapp/components/skip_button.dart';
import 'package:noteapp/constant/constant.dart';
import 'package:get/get.dart';
import 'package:noteapp/constant/strings.dart';
import 'package:noteapp/controllers/add_task_controller.dart';
import 'package:noteapp/controllers/notes_list_controller.dart';
import 'package:noteapp/controllers/reports_controller.dart';
import 'package:noteapp/models/filter_date.dart';
import 'package:noteapp/utils/storage_utils.dart';
import 'package:noteapp/utils/themes.dart';

class ReportScreen extends StatelessWidget {
  ReportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final addTask = Get.find<AddTaskController>();
    final notesListController = Get.find<NotesListController>();
    final reportsController = Get.put(ReportsController());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          'kTitleReport'.tr,
          style: Get.theme.appBarTheme.titleTextStyle,
          // style: GoogleFonts.nunito().copyWith(
          //   fontSize: 18,
          //   fontWeight: FontWeight.bold,
          //   color: Colors.white,
          // ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showFilterDialog(context);
            },
            icon: Icon(Icons.filter_alt),
          )
        ],
      ),
      // backgroundColor: Color(0xffF9F9F9),
      body: Container(
        padding: EdgeInsets.all(10),
        child: GetX<NotesListController>(
          initState: (state) {
            print('Inited');
          },
          init: NotesListController(),
          builder: (notesListController) {
            print('Build list called');
            final completedList = notesListController
                .getFilteredCompletedNotesList(reportsController.datesForFilter[
                    reportsController.selectedDateFilterIndex.value]);
            return completedList.isEmpty
                ? NoReportsFound()
                : ListView.builder(
                    itemCount: completedList.length,
                    itemBuilder: (BuildContext context, int index) {
                      // return Container();
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 8),
                        child: Container(
                          color: Colors.deepPurple,
                          child: ExpansionPanelList(
                            expandedHeaderPadding: EdgeInsets.all(0),
                            animationDuration: Duration(milliseconds: 500),
                            // dividerColor:
                            //     Theme.of(context).primaryColor.withOpacity(0.5),
                            elevation: 1,
                            children: [
                              ExpansionPanel(
                                canTapOnHeader: true,
                                body: Container(
                                  alignment: AlignmentDirectional.centerStart,
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      WidgetButtonDone(),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: completedList[index]
                                            .todoItemList
                                            .map((element) => IgnorePointer(
                                                  ignoring: true,
                                                  child: CheckboxListTile(
                                                    // tileColor: Colors.black,
                                                    activeColor:
                                                        Theme.of(context)
                                                            .primaryColor,
                                                    checkColor:
                                                        Theme.of(context)
                                                            .accentColor,
                                                    dense: true,
                                                    isThreeLine: false,
                                                    contentPadding:
                                                        EdgeInsets.all(0),
                                                    controlAffinity:
                                                        ListTileControlAffinity
                                                            .leading,
                                                    tristate: true,
                                                    title: Text(
                                                      '${element.taskName}',
                                                      style: TextStyle(
                                                          fontSize: 16),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    secondary: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        if (completedList[index]
                                                            .isCurrencySelected)
                                                          Flexible(
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                SvgPicture
                                                                    .asset(
                                                                  StorageUtils
                                                                          .getSettingsItem()
                                                                      .currencyItem
                                                                      .iconPath,
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColor,
                                                                  height:
                                                                      kSizeCurrency,
                                                                ),
                                                                Container(
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                          left:
                                                                              5.w),
                                                                  width: 50.w,
                                                                  height: 35.h,
                                                                  child: Center(
                                                                    child:
                                                                        TextField(
                                                                      controller: TextEditingController()
                                                                        ..text = element
                                                                            .price
                                                                            .toString(),
                                                                      maxLines:
                                                                          1,
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            12.sp,
                                                                      ),
                                                                      decoration:
                                                                          InputDecoration(
                                                                        contentPadding:
                                                                            EdgeInsets.symmetric(vertical: 5),
                                                                        isDense:
                                                                            true,
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
                                      if (completedList[index]
                                          .isCurrencySelected)
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
                                              '${completedList[index].todoItemList.fold(0, (int previousValue, element) => element.price + previousValue)}',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        )
                                    ],
                                  ),
                                ),
                                headerBuilder:
                                    (BuildContext context, bool isExpanded) {
                                  return Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    child: Text(
                                      completedList[index].title!.isNotEmpty
                                          ? completedList[index].title!
                                          : DateFormat(
                                                  StorageUtils.getSettingsItem()
                                                      .dateFormat)
                                              // DateFormat.yMd().add_jm()
                                              .format(completedList[index]
                                                  .dateTime),
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  );
                                },
                                isExpanded: completedList[index].isExpanded,
                              )
                            ],
                            expansionCallback: (int item, bool status) {
                              completedList[index].isExpanded =
                                  !completedList[index].isExpanded;
                              notesListController.filteredNotesList.refresh();
                              print('toggled $item $status');
                            },
                          ),
                        ),
                      );
                    },
                  );
          },
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

  void showFilterDialog(BuildContext context) {
    final reportsController = Get.find<ReportsController>();
    final notesListController = Get.find<NotesListController>();
    Get.defaultDialog(
        title: 'Filter list',
        radius: 10,
        content: Column(
          children: [
            Wrap(
              runSpacing: 10,
              spacing: 10,
              children: getFilterList(),
            ),
            GetX<ReportsController>(
              init: ReportsController(),
              builder: (controller) {
                print('From to date builder called');
                FilterDate customFilterDate =
                    reportsController.datesForFilter.last;
                String fromDateStr =
                    DateFormat(StorageUtils.getSettingsItem().dateFormat)
                        .format(customFilterDate.fromDate!);
                String toDateStr =
                    DateFormat(StorageUtils.getSettingsItem().dateFormat)
                        .format(customFilterDate.toDate!);
                return Visibility(
                  visible: reportsController.isCustomSelected.value,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Get.theme.primaryColor,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '$fromDateStr',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      Text(
                        ' to ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Get.theme.primaryColor,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '$toDateStr',
                          style: TextStyle(fontSize: 14),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ],
        ),
        cancel: TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text('Close'),
        ));
  }

  getFilterList() {
    final reportsController = Get.find<ReportsController>();
    List<Widget> widgets = [];
    reportsController.datesForFilter.asMap().forEach((index, value) {
      widgets.add(
        Obx(() {
          return ChoiceChip(
            label: Text(value.placeholder),
            selected: reportsController.selectedDateFilterIndex.value == index,
            onSelected: (value) async {
              if (index == reportsController.datesForFilter.length - 1) {
                final picked = await showDateRangePicker(
                  context: Get.context!,
                  lastDate: DateTime(DateTime.now().year + 5),
                  initialEntryMode: DatePickerEntryMode.calendarOnly,
                  firstDate: DateTime(1999),
                  builder: (context, child) {
                    if (!Get.isDarkMode)
                      return child!;
                    else
                      return Theme(
                        data: Themes.dark.copyWith(
                          colorScheme: ColorScheme.dark(
                            primary: Colors.greenAccent,
                            // onPrimary: Colors.white,
                            // surface: Colors.greenAccent,
                            // onSurface: Colors.white,
                          ),
                          textTheme: TextTheme(
                            overline:
                                TextStyle(fontSize: 16, color: Colors.red),
                          ),
                        ),
                        child: child!,
                      );
                  },
                );
                if (picked != null) {
                  print(picked);
                  FilterDate customFilterDate =
                      reportsController.datesForFilter.last;
                  customFilterDate.fromDate = picked.start;
                  customFilterDate.toDate = picked.end;
                  reportsController.selectedDateFilterIndex.value = index;
                  reportsController.isCustomSelected.value = true;
                  reportsController.isCustomSelected.refresh();
                  reportsController.selectedDateFilterIndex.refresh();
//                   setState(() {
//                     startDate = picked.start;
//                     endDate = picked.end;
// //below have methods that runs once a date range is picked
//                     allWaterBillsFuture = _getAllWaterBillsFuture(
//                         picked.start.toIso8601String(),
//                         picked.end
//                             .add(new Duration(hours: 24))
//                             .toIso8601String());
//                   });
                }
              } else {
                reportsController.isCustomSelected.value = false;
                reportsController.selectedDateFilterIndex.value = index;
              }
            },
          );
        }),
      );
    });
    return widgets;
  }
}
