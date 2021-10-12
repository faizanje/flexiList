import 'package:flutter/material.dart';
import 'package:noteapp/constant/constant.dart';
import 'package:noteapp/constant/strings.dart';
import 'package:noteapp/screens/select_country_screen.dart';

class WidgetButtonDone extends StatelessWidget {
  const WidgetButtonDone({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => SelectCountryScreen()));
      },
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.all(2.4),
        width: 95,
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30),
              topLeft: Radius.circular(30),
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30)),
          color: kBtnColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              kDone,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w200,
                color: Colors.white,
              ),
            ),
            Icon(
              Icons.check,
              color: Color(0xff61FF8E),
            )
          ],
        ),
      ),
    );
  }
}
