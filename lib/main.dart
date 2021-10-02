import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:noteapp/screens/add_task_screen.dart';

import 'constant/constant.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 640),
      builder: () => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light().copyWith(
          colorScheme: ColorScheme.light().copyWith(
            primary: kPrimaryColor,
          ),
          textTheme: GoogleFonts.nunitoTextTheme(),
        ),
        color: Colors.white,
        home: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            // appBar: AppBar(
            //   title: Text("Note App"),
            //   backgroundColor: kNavbarColor,
            // ),
            // body: OnBoardingScreen(),
            // body: BottomNavScreen(),
            body: AddTaskScreen(),
            // body: SideBarLayout(),
          ),
        ),
      ),
    );
  }
}
