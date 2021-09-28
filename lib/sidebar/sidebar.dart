import 'package:flutter/material.dart';
import 'package:noteapp/constant/constant.dart';

// class SideBar extends StatelessWidget {
//   AnimationController _animationController;
//   bool isSlideBarOpen = false;
//   final _animationDuration = const Duration(milliseconds: 500);
//
//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     return AnimatedPositioned(
//       duration: _animationDuration,
//       top: 0,
//       bottom: 0,
//       left: isSlideBarOpen ? 0 : 0,
//       right: isSlideBarOpen ? 0 : screenWidth - 55,
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: <Widget>[
//           // ConstrainedBox(
//           //   child: Container(color: Colors.red),
//           //   constraints: BoxConstraints(
//           //     minWidth: 50,
//           //     maxWidth: 100,
//           //   ),
//           // ),
//           Expanded(
//             child: Container(
//               color: kNavbarColor,
//             ),
//           ),
//           Container(
//             width: 45,
//             height: 110,
//             alignment: AlignmentDirectional.center,
//             color: Colors.orangeAccent,
//             child: AnimatedIcon(
//               progress: _animationController!.view,
//               icon: AnimatedIcons.menu_close,
//               color: Colors.white,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class SideBar extends StatefulWidget {
  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  // AnimationController _animationController;
  bool isSlideBarOpen = false;
  final _animationDuration = const Duration(milliseconds: 500);

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   _animationController =
  //       AnimationController(vsync: this, duration: _animationDuration);
  // }
  //
  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //
  //   super.dispose();
  //   _animationController!.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return AnimatedPositioned(
      duration: _animationDuration,
      top: 0,
      bottom: 0,
      left: isSlideBarOpen ? 0 : 0,
      right: isSlideBarOpen ? 0 : 0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // ConstrainedBox(
          //   child: Container(color: Colors.red),
          //   constraints: BoxConstraints(
          //     minWidth: 50,
          //     maxWidth: 100,
          //   ),
          // ),
          Expanded(
            child: Container(
              color: kNavbarColor,
            ),
          ),
          Container(
            width: 45,
            height: 110,
            alignment: AlignmentDirectional.center,
            color: Colors.orangeAccent,
            // child: AnimatedIcon(
            //   progress: _animationController!.view,
            //   icon: AnimatedIcons.menu_close,
            //   color: Colors.white,
            // ),
          ),
        ],
      ),
    );
  }
}
