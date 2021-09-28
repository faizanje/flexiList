import 'package:flutter/material.dart';
import 'package:noteapp/menu_screen/add_task_screen.dart';
import 'package:noteapp/pages/onboarding_pages.dart';
import 'package:noteapp/sidebar/sidebar_layout.dart';
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        colorScheme: ColorScheme.light().copyWith(
          primary: kPrimaryColor,
        ),
      ),
      color: Colors.white,
      // routes: {
      //   BottomNavBar.routeName: (ctx) => BottomNavBar(),
      // },
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text("Note App"),
            backgroundColor: kNavbarColor,
          ),
          // body: OnboardingPages(),
          body: SideBarLayout(),
        ),
      ),
    );
  }
}
