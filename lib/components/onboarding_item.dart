import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:noteapp/constant/introduction_json.dart';

class OnBoardingItem extends StatelessWidget {
  final String path;

  const OnBoardingItem({
    Key? key,
    required this.path,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Column(
            children: <Widget>[
              Lottie.network(
                'https://github.com/faizanje/sk-shopping-list/raw/lottie-assets/41068-man-filling-a-list%20(1).json',
                height: 250.h,
                width: 250.w,
              ),
              Text(
                onBoardData[0]['title'],
                style: TextStyle(
                  fontSize: 30.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 10.sp,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 30.0),
                child: Text(
                  onBoardData[0]['description'],
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          Spacer(),
        ],
      ),
    );
  }
}
