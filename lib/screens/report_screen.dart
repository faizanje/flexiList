import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:noteapp/components/done_button.dart';
import 'package:noteapp/components/skip_button.dart';
import 'package:noteapp/constant/constant.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF9F9F9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 80, // Set this height
        flexibleSpace: Container(
          height: 80,
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                  onPressed: () {
                    // Get.back();
                  },
                  icon: SvgPicture.asset('assets/icons/bck btn.svg')),
              Text(
                "Filter",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: kPrimaryColor,
                ),
              ),
              Icon(
                Icons.filter_alt,
                color: kPrimaryColor,
                size: 28,
              ),
            ],
          ),
        ),
      ),
      body: getBody(),
    );
  }

  getBody() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      width: double.infinity,
      height: 110,
      decoration: BoxDecoration(
        color: Color(0xffFFFFFF),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
        borderRadius: BorderRadius.all(Radius.circular(13)),
      ),
      child: Row(
        children: <Widget>[
          Column(
            children: <Widget>[
              Text(
                "Title",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),
              WidgetButtonDone(),
            ],
          ),
          Column(
            children: <Widget>[],
          ),
        ],
      ),
    );
  }
}
