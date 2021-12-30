import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:noteapp/constant/constant.dart';
import 'package:noteapp/constant/strings.dart';
import 'package:noteapp/controllers/app_controller.dart';
import 'package:noteapp/controllers/notes_list_controller.dart';
import 'package:noteapp/controllers/reports_controller.dart';
import 'package:noteapp/screens/add_task_screen.dart';
import 'package:noteapp/screens/new_settings_screen.dart';
import 'package:noteapp/screens/notes_list_screen.dart';
import 'package:noteapp/screens/archive_screen.dart';
import 'package:noteapp/screens/layout_screen.dart';
import 'package:noteapp/screens/report_screen.dart';
import 'package:noteapp/services/application.dart';
import 'package:noteapp/services/theme_service.dart';
import 'package:noteapp/utils/snack_bar_utils.dart';

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
    NewSettingsScreen()
    // LayoutScreen()
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context.theme;
    // final appController = Get.find<AppController>();
    final notesListController = Get.put(NotesListController());
    // final theme = Theme.of(Application.materialKey.currentContext!);
    return SafeArea(
      child: Scaffold(
        body: _pageOption[selectedPage],
        bottomNavigationBar: ConvexAppBar(
          onTabNotify: (position) {
            // if (position == 1) {
            if (position == 2) {
              // SnackBarUtils.showGetXSnackBar('message');

              // Fluttertoast.showToast(
              //     msg: "This is Center Short Toast",
              //     toastLength: Toast.LENGTH_SHORT,
              //     gravity: ToastGravity.SNACKBAR,
              //
              //     // timeInSecForIosWeb: 1,
              //     // backgroundColor: Colors.red,
              //     textColor: Colors.white,
              //     fontSize: 16.0);

              // ScaffoldMessenger.of(context)
              //     .showSnackBar(SnackBar(content: Text('Hello')));
              Get.to(
                () => AddTaskScreen(),
                // transition: Transition.downToUp,
                transition: Transition.zoom,
              );
              return false;
            }
            // if (position != 2) {
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
          // backgroundColor: kNavbarColor,
          // backgroundColor: appController.themeData.primaryColor,
          backgroundColor: Theme.of(context).primaryColor,
          // backgroundColor: Get.find<AppController>().color,
          items: [
            TabItem(
              icon: Icons.event_note_rounded,
              title: 'kTitleNote'.tr,
            ),
            TabItem(
                icon: Icons.report_gmailerrorred_outlined,
                title: 'kTitleReport'.tr),
            TabItem(icon: Icons.add),
            TabItem(icon: Icons.archive, title: 'kTitleArchive'.tr),
            TabItem(icon: Icons.settings, title: 'kTitleSetting'.tr),
          ],
          initialActiveIndex: 0,
          color: context.theme.accentColor,
          activeColor: context.theme.backgroundColor,
        ),
      ),
    );
  }
}
