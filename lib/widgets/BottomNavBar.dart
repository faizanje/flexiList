import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:noteapp/constant/constant.dart';
import 'package:noteapp/pages/addTaskPage.dart';
import 'package:noteapp/pages/archivePage.dart';
import 'package:noteapp/pages/layout_screen.dart';
import 'package:noteapp/pages/notePage.dart';
import 'package:noteapp/pages/reportPage.dart';

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
            backgroundColor: kNavbarColor,
            items: [
              TabItem(icon: Icons.event_note_rounded, title: 'Note'),
              TabItem(
                  icon: Icons.report_gmailerrorred_outlined, title: 'Report'),
              TabItem(icon: Icons.add, title: 'Add'),
              TabItem(icon: Icons.archive, title: 'Archive'),
              TabItem(icon: Icons.settings, title: 'Setting'),
            ],
            initialActiveIndex: 2, //optional, default as 0
            onTap: (int i) {
              setState(() {
                selectedPage = i;
              });
            }),
      ),
    );
  }
}
