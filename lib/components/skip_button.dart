import 'package:flutter/material.dart';
import 'package:noteapp/constant/constant.dart';
import 'package:noteapp/screens/select_country_screen.dart';

class WidgetButton extends StatelessWidget {
  const WidgetButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => SelectCountryScreen()));
      },
      child: Container(
        width: 100,
        height: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30),
                topLeft: Radius.circular(30),
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30)),
            color: Colors.transparent,
            border: Border.all(color: kNavbarColor)),
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.all(2.4),
          width: 100,
          height: 40,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30),
                  topLeft: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30)),
              color: kNavbarColor,
              border: Border.all(color: kNavbarColor)),
          child: Text(
            "SKIP",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.white,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ),
    );
  }
}
