import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:noteapp/menu_screen/add_task_screen.dart';
import 'package:noteapp/pages/onboarding_pages.dart';
import 'package:noteapp/sidebar/sidebar_layout.dart';
import 'package:noteapp/widgets/BottomNavBar.dart';
import 'constant/constant.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 640),
      builder: () => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light().copyWith(
          colorScheme: ColorScheme.light().copyWith(
            primary: kPrimaryColor,
          ),
          textTheme: GoogleFonts.nunitoTextTheme(),
        ),
        color: Colors.white,
        // routes: {
        //   BottomNavBar.routeName: (ctx) => BottomNavBar(),
        // },
        home: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            // appBar: AppBar(
            //   title: Text("Note App"),
            //   backgroundColor: kNavbarColor,
            // ),
            // body: OnboardingPages(),
            // body: BottomNavBar(),
            body: AddTaskScreen(),
            // body: SideBarLayout(),
          ),
        ),
      ),
    );
  }
}
