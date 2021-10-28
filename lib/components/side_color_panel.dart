import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:noteapp/components/slide_color_panel_design.dart';
import 'package:noteapp/controllers/add_task_controller.dart';
import 'package:noteapp/controllers/sidebar_controller.dart';

import 'circular_color_container.dart';

class SideColorPanel extends StatelessWidget {
  const SideColorPanel({
    Key? key,
    required this.colors,
  }) : super(key: key);

  // final List<Color> colors;
  final List<List<Color>> colors;

  @override
  Widget build(BuildContext context) {
    final addTaskController = Get.find<AddTaskController>();
    final sidebarController = Get.find<SidebarController>();
    return Obx(
      () => AnimatedPositioned(
        curve: Curves.bounceOut,
        duration: Duration(milliseconds: 500),
        left: Directionality.of(context) == TextDirection.rtl
            ? (sidebarController.isSlideBarOpen.value ? 0 : -95)
            : null,
        right: Directionality.of(context) != TextDirection.rtl
            ? (sidebarController.isSlideBarOpen.value ? 0 : -95)
            : null,
        bottom: 0,
        top: 0,
        // child: ClipPath(
        child: Row(
          children: [
            Stack(
              children: [
                Transform.rotate(
                  angle: Directionality.of(context) == TextDirection.rtl
                      ? 3.14
                      : 0,
                  // transform: Matrix4.rotationX(pi),
                  child: Container(
                    height: 250,
                    width: 50,
                    child: CustomPaint(
                      size: Size(64, (64 * 1.5).toDouble()),
                      painter: RPSCustomPainter(context),
                    ),
                  ),
                ),
                Positioned(
                  right:
                      Directionality.of(context) == TextDirection.rtl ? 15 : -5,
                  top: -5,
                  bottom: 0,
                  child: Container(
                      child: sidebarController.isSlideBarOpen.value
                          ? IconButton(
                              onPressed: () {
                                sidebarController.isSlideBarOpen.toggle();
                              },
                              icon: Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Colors.blue,
                              ),
                            )
                          : IconButton(
                              onPressed: () {
                                sidebarController.isSlideBarOpen.toggle();
                              },
                              icon: Icon(
                                Icons.opacity,
                                color: Colors.blue,
                                size: 26,
                              ),
                            )),
                )
              ],
            ),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              constraints: BoxConstraints(
                maxHeight: 500.h,
              ),
              width: 60,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 40.0),
                child: ListView.separated(
                  separatorBuilder: (context, index) => SizedBox(
                    height: 5,
                  ),
                  shrinkWrap: true,
                  itemCount: colors.length,
                  itemBuilder: (context, index) => Align(
                    alignment: Alignment.center,
                    child: CircularColorContainer(
                      containerColor: colors[index],
                      onColorChanged: (List<Color> colors) {
                        addTaskController.color.value = colors;
                      },
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
