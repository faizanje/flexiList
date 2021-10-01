import 'package:flutter/material.dart';
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
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                      onTap: () {
                        Get.to(() => LayoutScreen());
                        // Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (context) => LayoutScreen()));
                      },
                      child: SvgPicture.asset('assets/images/menu_icon.svg')),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    alignment: AlignmentDirectional.centerStart,
                    width: MediaQuery.of(context).size.width - 90,
                    height: 50,
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
                    child: TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.menu,
                          color: kNavbarColor,
                        ),
                        border: InputBorder.none,
                        hintText: "Search notes",
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(44.0),
                    child: Image.asset(
                      'assets/images/addtask_pic.png',
                    ),
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
      ),
    );
  }
}
