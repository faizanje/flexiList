import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:noteapp/constant/constant.dart';
import 'package:noteapp/controllers/add_task_controller.dart';

class TaskCheckItem extends StatelessWidget {
  final bool? value;
  final String title;
  final int price;
  final void Function(bool?) onChanged;
  final void Function() onDownloadClicked, onDeleteClicked;
  final void Function(int) onPriceChanged;
  final void Function(String) onTaskTitleChanged;
  final isCurrencyToggled;

  TaskCheckItem(
      {required this.value,
      required this.title,
      required this.onChanged,
      required this.onDownloadClicked,
      required this.onDeleteClicked,
      required this.isCurrencyToggled,
      required this.onPriceChanged,
      this.price = 0,
      required this.onTaskTitleChanged});

  @override
  Widget build(BuildContext context) {
    final addTaskController = Get.find<AddTaskController>();
    return CheckboxListTile(
      activeColor: Theme.of(context).primaryColor,
      checkColor: Theme.of(context).accentColor,
      dense: true,
      contentPadding: EdgeInsets.all(0),
      controlAffinity: ListTileControlAffinity.leading,
      // tristate: true,
      title: TextField(
        onSubmitted: (value) {
          addTaskController.addEmptyTask();
        },
        textInputAction: TextInputAction.next,
        // autofocus: true,
        controller: TextEditingController()..text = title,
        onChanged: onTaskTitleChanged,
        decoration: InputDecoration(
          isCollapsed: true,
          contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          isDense: true,
          border: null,
        ),
        maxLines: null,
        style: TextStyle(fontSize: 16.sp),
      ),
      secondary: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isCurrencyToggled)
            Flexible(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    addTaskController.settingsModel.currencyItem.iconPath,
                    color: Theme.of(context).primaryColor,
                    height: kSizeCurrency,
                  ),
                  Container(
                    // margin: EdgeInsets.only(left: 5.w),
                    width: 45.w,
                    height: 35.h,
                    child: Center(
                      child: TextField(
                        controller: TextEditingController()
                          ..text = this.price.toString(),
                        maxLines: 1,
                        onChanged: (newText) {
                          if (newText.isNotEmpty) {
                            onPriceChanged(int.tryParse(newText)!);
                          }
                        },
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ],
                        style: TextStyle(
                          fontSize: 12.sp,
                        ),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 5),
                          isDense: true,
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          if (value == null)
            IconButton(
              constraints: BoxConstraints(
                minWidth: kMinInteractiveDimension - 20,
              ),
              onPressed: () {
                print('Clicked value $value');
                onDownloadClicked();
              },
              icon: Icon(
                Icons.arrow_circle_up,
                color: Get.theme.primaryColor,
              ),
              padding: EdgeInsets.only(left: 6),
            ),
          if (value == false)
            IconButton(
              constraints: BoxConstraints(
                minWidth: kMinInteractiveDimension - 20,
              ),
              onPressed: onDownloadClicked,
              icon: Icon(
                Icons.schedule,
                color: Get.theme.primaryColor,
              ),
              padding: EdgeInsets.only(left: 6),
            ),
          Container(
            margin: EdgeInsets.only(top: 4),
            child: IconButton(
              constraints: BoxConstraints(
                minWidth: kMinInteractiveDimension - 10,
              ),
              padding: EdgeInsets.all(0),
              onPressed: onDeleteClicked,
              alignment: Alignment.bottomCenter,
              icon: SvgPicture.asset(
                'assets/icons/bx_bxs-trash-alt.svg',
              ),
            ),
          ),
        ],
      ),
      value: value != null ? value : false,
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
