import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noteapp/constant/constant.dart';
import 'package:noteapp/controllers/add_task_controller.dart';
import 'package:noteapp/menu_screen/add_task_screen.dart';
import 'package:noteapp/sidebar/controller/sidebar_controller.dart';

class SideBar extends StatelessWidget {
  const SideBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final _animationDuration = const Duration(milliseconds: 300);
    final sidebarController = Get.put(SidebarController());
    Color setColor = kNavbarColor;
    final addTaskController = Get.find<AddTaskController>();
    return Obx(
      () => AnimatedPositioned(
        duration: _animationDuration,
        top: 30,
        bottom: 30,
        left: sidebarController.isSlideBarOpen.value ? 0 : 0,
        right: sidebarController.isSlideBarOpen.value ? 0 : screenWidth - 45,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Flexible(
              flex: 2,
              child: Container(
                color: setColor,
                width: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        addTaskController.color.value = Colors.yellow;
                        print("taped");
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(100),
                          ),
                          color: Colors.yellow,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 8,
              child: ClipPath(
                clipper: CustomMenuClipper(),
                child: Container(
                    width: 40,
                    height: 110,
                    alignment: Alignment.centerLeft,
                    color: kNavbarColor,
                    child: sidebarController.isSlideBarOpen.value
                        ? IconButton(
                            onPressed: () {
                              sidebarController.isSlideBarOpen.toggle();
                              setColor = sidebarController.primarycolor.value;
                              print('opened');
                            },
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.blue,
                            ),
                          )
                        : IconButton(
                            onPressed: () {
                              sidebarController.isSlideBarOpen.toggle();

                              setColor = sidebarController.primarycolor.value;
                              print('closed ');
                            },
                            icon: Icon(
                              Icons.opacity,
                              color: Colors.blue,
                              size: 26,
                            ),
                          )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomMenuClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Paint paint = Paint();
    paint.color = Colors.white;

    final width = size.width;
    final height = size.height;

    Path path = Path();
    path.moveTo(0, 0);
    path.quadraticBezierTo(0, 8, 10, 16);
    path.quadraticBezierTo(width - 1, height / 2 - 20, width, height / 2);
    path.quadraticBezierTo(width + 1, height / 2 + 20, 10, height - 16);
    path.quadraticBezierTo(0, height - 8, 0, height);

    // path.quadraticBezierTo(8, 0, 16, 0);
    // path.quadraticBezierTo(height / 2 - 20, width - 1, height / 2, width);
    // path.quadraticBezierTo(height / 2 + 20, width + 1, 10, height - 16);
    // path.quadraticBezierTo(0, height - 8, 0, height);
    // path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}
