
import 'package:flutter/material.dart';

class AppBarWithSearch extends StatelessWidget {
  const AppBar({
    Key? key,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
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

