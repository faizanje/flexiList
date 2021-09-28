import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noteapp/constant/constant.dart';
import 'package:noteapp/sidebar/controller/sidebar_controller.dart';

class SideBar extends StatelessWidget {
  const SideBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final _animationDuration = const Duration(milliseconds: 300);
    final sidebarController = Get.put(SidebarController());

    return Obx(
      () => AnimatedPositioned(
        duration: _animationDuration,
        top: 0,
        bottom: 0,
        left: sidebarController.isSlideBarOpen.value ? 0 : 0,
        right: sidebarController.isSlideBarOpen.value ? 0 : screenWidth - 45,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Flexible(
              flex: 2,
              child: GestureDetector(
                onTap: () {
                  print('Tapped');
                  sidebarController.randomizeColor();
                },
                child: Container(
                  color: sidebarController.color.value,
                ),
              ),
            ),
            Flexible(
              flex: 5,
              child: Container(
                width: 45,
                height: 110,
                alignment: Alignment.centerLeft,
                color: Colors.orangeAccent,
                child: IconButton(
                  onPressed: () {
                    sidebarController.isSlideBarOpen.toggle();
                    // setState(() {
                    //   this.isSlideBarOpen = !this.isSlideBarOpen;
                    // });
                    print('clicked animated button');
                  },
                  icon: Icon(
                    Icons.menu,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class SideBar extends StatefulWidget {
//   @override
//   _SideBarState createState() => _SideBarState();
// }
//
// class _SideBarState extends State<SideBar> {
//   final _animationDuration = const Duration(milliseconds: 300);
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     // TODO: implement dispose
//
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     return AnimatedPositioned(
//       duration: _animationDuration,
//       top: 0,
//       bottom: 0,
//       left: isSlideBarOpen ? 0 : 0,
//       right: isSlideBarOpen ? 0 : screenWidth - 45,
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: <Widget>[
//           Flexible(
//             flex: 2,
//             child: Container(
//               color: Colors.red,
//             ),
//           ),
//           Flexible(
//             flex: 5,
//             child: Container(
//               width: 45,
//               height: 110,
//               alignment: Alignment.centerLeft,
//               color: Colors.orangeAccent,
//               child: IconButton(
//                 onPressed: () {
//                   setState(() {
//                     this.isSlideBarOpen = !this.isSlideBarOpen;
//                   });
//                   print('clicked animated button');
//                 },
//                 icon: Icon(
//                   Icons.menu,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
