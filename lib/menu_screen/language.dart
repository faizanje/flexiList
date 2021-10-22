import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:noteapp/constant/constant.dart';
import 'package:noteapp/constant/strings.dart';

class LanguagePage extends StatefulWidget {
  @override
  _LanguagePageState createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
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
        backgroundColor: Colors.green,
        title: Text('kLanguage'.tr),
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
          'kLanguage'.tr,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 30,
          ),
        ),
      ),
    );
  }
}
