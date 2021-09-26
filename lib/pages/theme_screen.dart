import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class ThemeScreen extends StatefulWidget {
  @override
  _ThemeScreenState createState() => _ThemeScreenState();
}

class _ThemeScreenState extends State<ThemeScreen> {
  bool flag = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    ZoomDrawer.of(context)!.toggle();
    setState(() {
      flag = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Theme Screen"),
        leading: flag
            ? IconButton(
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
              )
            : IconButton(
                onPressed: () {
                  ZoomDrawer.of(context)!.toggle();
                  setState(() {
                    flag = false;
                  });
                },
                icon: Icon(
                  Icons.arrow_forward_rounded,
                  size: 37,
                  color: Colors.white,
                ),
              ),
      ),
    );
  }
}
