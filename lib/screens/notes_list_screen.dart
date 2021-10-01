import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:noteapp/constant/constant.dart';
import 'package:noteapp/screens/layout_screen.dart';

class NotesListScreen extends StatefulWidget {
  @override
  _NotesListScreenState createState() => _NotesListScreenState();
}

class _NotesListScreenState extends State<NotesListScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(bottom: 40),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 4.h,
            ),
            buildAppBar(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 25.h,
                ),
                Image.asset(
                  'assets/images/addtask_pic.png',
                  height: 232,
                  width: 232,
                ),
                SizedBox(
                  height: 14.h,
                ),
                Text(
                  "Add Your First Note",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Image.asset(
                  'assets/images/arrow.png',
                  height: 100,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Row buildAppBar() {
    return Row(
      children: <Widget>[
        IconButton(
            onPressed: () {
              Get.to(() => LayoutScreen());
            },
            icon: SvgPicture.asset('assets/images/menu_icon.svg')),
        Container(
          alignment: AlignmentDirectional.centerStart,
          width: 297.w,
          height: 42.h,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 2,
                offset: Offset(3, 5),
              ),
            ],
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30),
                topLeft: Radius.circular(30),
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30)),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: TextField(
              decoration: InputDecoration(
                suffixIcon: Icon(
                  Icons.search,
                  color: kNavbarColor,
                ),
                border: InputBorder.none,
                hintText: "Search notes",
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
