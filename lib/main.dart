import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:noteapp/models/enums/task_status.dart';
import 'package:noteapp/models/home_task_item_model.dart';
import 'package:noteapp/models/todo_item.dart';
import 'package:noteapp/screens/bottom_nav_screen.dart';
import 'package:path_provider/path_provider.dart';

import 'constant/constant.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final documentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(documentDirectory.path);
  Hive.registerAdapter(TASKSTATUSAdapter());
  Hive.registerAdapter(TodoItemModelAdapter());
  Hive.registerAdapter(HomeTaskItemModelAdapter());
  await Hive.openBox<HomeTaskItemModel>(kBoxTodo);
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
            body: BottomNavScreen(),
            // body: AddTaskScreen(),
            // body: SideBarLayout(),
          ),
        ),
      ),
    );
  }
}
