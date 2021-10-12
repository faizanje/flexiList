import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noteapp/constant/constant.dart';
import 'package:noteapp/constant/strings.dart';
import 'package:noteapp/controllers/notes_list_controller.dart';
import 'package:noteapp/controllers/reports_controller.dart';
import 'package:noteapp/screens/add_task_screen.dart';
import 'package:noteapp/screens/notes_list_screen.dart';
import 'package:noteapp/screens/archive_screen.dart';
import 'package:noteapp/screens/layout_screen.dart';
import 'package:noteapp/screens/report_screen.dart';

class BottomNavScreen extends StatefulWidget {
  static const routeName = "/navBar";

  @override
  _BottomNavScreenState createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int selectedPage = 0;
  final _pageOption = [
    NotesListScreen(),
    ReportScreen(),
    Container(),
    ArchiveScreen(),
    LayoutScreen()
  ];

  @override
  Widget build(BuildContext context) {
    final notesListController = Get.put(NotesListController());
    return SafeArea(
      child: Scaffold(
        body: _pageOption[selectedPage],
        bottomNavigationBar: ConvexAppBar(
          onTabNotify: (position) {
            if (position == 2) {
              Get.to(() => AddTaskScreen());
              return false;
            }
            if (position != 1) {
              try {
                Get.delete<ReportsController>();
              } catch (e) {
                print('Exception $e');
              }
            }
            setState(() {
              selectedPage = position;
            });
            return true;
          },
          style: TabStyle.reactCircle,
          backgroundColor: kNavbarColor,
          items: [
            TabItem(icon: Icons.event_note_rounded, title: 'kTitleNote'.tr),
            TabItem(
                icon: Icons.report_gmailerrorred_outlined,
                title: 'kTitleReport'.tr),
            TabItem(icon: Icons.add),
            TabItem(icon: Icons.archive, title: 'kTitleArchive'.tr),
            TabItem(icon: Icons.settings, title: 'kTitleSetting'.tr),
          ],
          initialActiveIndex: 0,
        ),
      ),
    );
  }
}
