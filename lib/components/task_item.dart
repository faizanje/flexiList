import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:noteapp/constant/constant.dart';

class TaskCheckItem extends StatelessWidget {
  final bool? value;
  final String title;
  final void Function(bool?) onChanged;
  final void Function() onDownloadClicked, onDeleteClicked;

  TaskCheckItem(
      {required this.value,
      required this.title,
      required this.onChanged,
      required this.onDownloadClicked,
      required this.onDeleteClicked});

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      activeColor: kPrimaryColor,
      dense: true,
      contentPadding: EdgeInsets.all(0),
      controlAffinity: ListTileControlAffinity.leading,
      tristate: true,
      title: Text(
        '$title',
        style: TextStyle(fontSize: 16),
      ),
      secondary: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: onDownloadClicked,
            icon: SvgPicture.asset(
              'assets/icons/download.svg',
            ),
          ),
          IconButton(
            onPressed: onDeleteClicked,
            icon: SvgPicture.asset(
              'assets/icons/bx_bxs-trash-alt.svg',
            ),
          ),
        ],
      ),
      value: value,
      // onChanged: (newValue) {
      //   print(newValue);
      //   onChanged(newValue);
      // },
      onChanged: (newValue) {
        onChanged(newValue);
      },
    );
  }
}
