import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:noteapp/menu_screen/currency.dart';
import 'package:noteapp/menu_screen/language.dart';
import 'package:noteapp/menu_screen/theme.dart';
import 'package:noteapp/models/setting_menu_json.dart';
import 'package:noteapp/screens/select_country_screen.dart';
import 'package:noteapp/screens/setting_screen.dart';

class LayoutScreen extends StatefulWidget {
  @override
  _LayoutScreenState createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  MenuItem currentItem = MenuItems.theme;

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      borderRadius: 50,
      mainScreen: getScreen(),
      menuScreen: SettingScreen(
        onSelectItem: (item) {
          setState(() {
            currentItem = item;
            // ZoomDrawer.of(context).close();
          });
        },
        currentItem: currentItem,
      ),
      // style: DrawerStyle.Style2,
      style: DrawerStyle.DefaultStyle,
      // angle: -10,
      slideWidth: MediaQuery.of(context).size.width * 0.8,
      // showShadow: true,
      // backgroundColor: Colors.orangeAccent,
    );
  }

  Widget getScreen() {
    switch (currentItem) {
      case MenuItems.theme:
        return ThemePage();
      case MenuItems.language:
        return SelectCountryScreen(
          isEditing: true,
        );

      // case MenuItems.language:
      //   return SelectCountryScreen();
      default:
        return SelectCountryScreen();
    }
  }
}
