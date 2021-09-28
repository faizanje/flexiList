import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:noteapp/menu_screen/add_task_screen.dart';
import 'package:noteapp/pages/addTaskPage.dart';
import 'package:noteapp/sidebar/sidebar.dart';

class SideBarLayout extends StatefulWidget {
  const SideBarLayout({Key? key}) : super(key: key);

  @override
  _SideBarLayoutState createState() => _SideBarLayoutState();
}

class _SideBarLayoutState extends State<SideBarLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          AddTaskScreen(),
          SideBar(),
        ],
      ),
    );
  }
}
