import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CircularColorContainer extends StatelessWidget {
  final List<Color> containerColor;
  final Function(List<Color>) onColorChanged;
  final bool showBorder;

  const CircularColorContainer({
    Key? key,
    required this.containerColor,
    required this.onColorChanged,
    this.showBorder = false,
  }) : super(key: key);

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
          border: showBorder
              ? Border.all(
                  color: Get.theme.primaryColor,
                )
              : null,
          borderRadius: BorderRadius.all(
            Radius.circular(100),
          ),
          color: Get.isDarkMode ? containerColor[1] : containerColor[0],
        ),
      ),
    );
  }
}
