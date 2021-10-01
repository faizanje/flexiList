import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';

class CircularColorContainer extends StatelessWidget {
  final Color containerColor;
  final Function(Color) onColorChanged;

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
          color: containerColor,
        ),
      ),
    );
  }
}
