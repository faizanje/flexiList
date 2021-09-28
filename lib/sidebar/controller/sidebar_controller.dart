import 'dart:math';
import 'dart:ui';

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SidebarController extends GetxController
    with SingleGetTickerProviderMixin {
  RxBool isSlideBarOpen = false.obs;
  RxString title = RxString('');
  late Rx<AnimationController> animationController;
  Rx<Color> color = Rx(Colors.deepPurple);

  randomizeColor() {
    color.value =
        Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
  }

  @override
  void onInit() {
    super.onInit();
    animationController = Rx<AnimationController>(
      AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 500),
      ),
    );
  }

  @override
  void onClose() {
    animationController.value.dispose();
    super.onClose();
  }
}
