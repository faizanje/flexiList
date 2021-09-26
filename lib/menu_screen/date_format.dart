import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:noteapp/constant/constant.dart';

class DateFormat extends StatefulWidget {
  @override
  _DateFormatState createState() => _DateFormatState();
}

class _DateFormatState extends State<DateFormat> {
  bool flag = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    ZoomDrawer.of(context)!.toggle();
    setState(() {
      flag = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Date Format"),
        leading: flag
            ? IconButton(
                onPressed: () {
                  ZoomDrawer.of(context)!.toggle();
                  setState(() {
                    flag = false;
                  });
                },
                icon: Icon(
                  Icons.arrow_back,
                  size: 37,
                  color: Colors.white,
                ),
              )
            : IconButton(
                onPressed: () {
                  ZoomDrawer.of(context)!.toggle();
                  setState(() {
                    flag = true;
                  });
                },
                icon: Icon(
                  Icons.arrow_forward_rounded,
                  size: 37,
                  color: Colors.white,
                ),
              ),
      ),
      body: Center(
        child: Text(
          "Date format",
          style: TextStyle(
            color: kNavbarColor,
            fontSize: 30,
          ),
        ),
      ),
    );
  }
}
