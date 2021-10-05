import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoNotesFound extends StatelessWidget {
  const NoNotesFound({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: 25.h,
        ),
        Image.asset(
          'assets/images/addtask_pic.png',
          height: 232,
          width: 232,
        ),
        SizedBox(
          height: 14.h,
        ),
        Text(
          "Add Your First Note",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Image.asset(
          'assets/images/arrow.png',
          height: 100,
        ),
      ],
    );
  }
}
