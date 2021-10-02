import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:noteapp/constant/constant.dart';

class TaskCheckItem extends StatelessWidget {
  final bool? value;
  final String title;
  final int price;
  final void Function(bool?) onChanged;
  final void Function() onDownloadClicked, onDeleteClicked;
  final void Function(int) onPriceChanged;
  final isCurrencyToggled;

  TaskCheckItem(
      {required this.value,
      required this.title,
      required this.onChanged,
      required this.onDownloadClicked,
      required this.onDeleteClicked,
      required this.isCurrencyToggled,
      required this.onPriceChanged,
      this.price = 0});

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
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isCurrencyToggled)
            Flexible(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    'assets/icons/Vector.svg',
                    color: kPrimaryColor,
                    height: 20,
                    width: 20,
                  ),
                  SizedBox(
                    width: 13.w,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 13.w),
                    width: 60.w,
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
                          hintText: '15',
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
