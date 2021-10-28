import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CircularColorContainer extends StatelessWidget {
  final List<Color> containerColor;
  final Function(List<Color>) onColorChanged;

  const CircularColorContainer(
      {Key? key, required this.containerColor, required this.onColorChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onColorChanged(containerColor);
        print("taped");
      },
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(100),
          ),
          color: Get.isDarkMode ? containerColor[1] : containerColor[0],
        ),
      ),
    );
  }
}
