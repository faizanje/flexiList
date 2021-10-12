import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:noteapp/constant/constant.dart';

class ThemePage extends StatefulWidget {
  @override
  _ThemePageState createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> {
  bool flag = false;
  bool _switchValue = true;
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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: Text("Theme"),
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Light",
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
              SizedBox(
                width: 5,
              ),
              CupertinoSwitch(
                value: _switchValue,
                onChanged: (value) {
                  setState(() {
                    _switchValue = value;
                  });
                },
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "Dark",
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
