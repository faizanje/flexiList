import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noteapp/constant/constant.dart';
import 'package:noteapp/menu_screen/add_task_screen.dart';
import 'package:noteapp/pages/addTaskPage.dart';
import 'package:noteapp/pages/archivePage.dart';
import 'package:noteapp/pages/layout_screen.dart';
import 'package:noteapp/pages/notePage.dart';
import 'package:noteapp/pages/reportPage.dart';
import 'package:noteapp/sidebar/sidebar.dart';
import 'package:noteapp/sidebar/sidebar_layout.dart';

class BottomNavBar extends StatefulWidget {
  static const routeName = "/navBar";
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int selectedPage = 2;
  final _pageOption = [
    NotePage(),
    ReportPage(),
    AddTaskpage(),
    ArchivePage(),
    LayoutScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _pageOption[selectedPage],
        bottomNavigationBar: ConvexAppBar(
            onTabNotify: (position) {
              if (position == 2) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddTaskScreen(),
                    // builder: (context) => SideBarLayout(),
                  ),
                );
                return false;
              }
              setState(() {
                selectedPage = position;
              });
              return true;
            },
            style: TabStyle.reactCircle,
            backgroundColor: kNavbarColor,
            items: [
              TabItem(icon: Icons.event_note_rounded, title: 'Note'),
              TabItem(
                  icon: Icons.report_gmailerrorred_outlined, title: 'Report'),
              TabItem(icon: Icons.add),
              TabItem(icon: Icons.archive, title: 'Archive'),
              TabItem(icon: Icons.settings, title: 'Setting'),
            ],
            initialActiveIndex: 2, //optional, default as 0
            onTap: (int i) {
              if (i == 2) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SideBarLayout(),
                  ),
                );
                return;
              }
              // setState(() {
              //   selectedPage = i;
              // });
            }),
      ),
    );
  }
}
