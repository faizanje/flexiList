// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:noteapp/controllers/add_task_controller.dart';
// import 'package:noteapp/menu_screen/add_task_screen.dart';
// import 'package:noteapp/sidebar/sidebar.dart';
// //
// // class SideBarLayout extends StatefulWidget {
// //   const SideBarLayout({Key? key}) : super(key: key);
// //
// //   @override
// //   _SideBarLayoutState createState() => _SideBarLayoutState();
// // }
//
// class SideBarLayout extends StatelessWidget {
//   const SideBarLayout({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final addTaskController = Get.put(AddTaskController());
//     return Scaffold(
//       body: Stack(
//         children: <Widget>[
//           AddTaskScreen(),
//           SideBar(),
//         ],
//       ),
//     );
//   }
// }
//
// // class _SideBarLayoutState extends State<SideBarLayout> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: Stack(
// //         children: <Widget>[
// //           AddTaskScreen(),
// //           SideBar(),
// //         ],
// //       ),
// //     );
// //   }
// // }
