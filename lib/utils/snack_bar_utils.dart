import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SnackBarUtils {
  static showGetXSnackBar(String message, {bool addBottomSpace = false}) {
    Get.showSnackbar(GetBar(
      // title: 'Test',
      // message: 'Test message',
      // message: '$message',
      duration: Duration(seconds: 2),
      borderRadius: 4,
      messageText: Row(
        children: [
          Text(
            '$message',
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
      animationDuration: Duration(milliseconds: 500),
      margin: addBottomSpace
          ? EdgeInsets.only(bottom: 70.h, left: 8.w, right: 8.w)
          : EdgeInsets.only(left: 8.w, right: 8.w, bottom: 10.h),
    ));
  }
}
