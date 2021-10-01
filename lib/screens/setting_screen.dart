import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noteapp/constant/constant.dart';
import 'package:noteapp/models/setting_menu_json.dart';
import 'package:noteapp/screens/bottom_nav_screen.dart';

class MenuItems {
  static const dateFormat =
      MenuItem(title: "Date Format", icon: Icons.date_range);
  static const theme = MenuItem(title: "Theme", icon: Icons.color_lens_rounded);
  static const currency =
      MenuItem(title: "Currency", icon: Icons.monetization_on_outlined);
  static const language = MenuItem(title: "Language", icon: Icons.language);

  static const all = <MenuItem>[
    dateFormat,
    theme,
    currency,
    language,
  ];
}

class SettingScreen extends StatelessWidget {
  final MenuItem currentItem;
  final ValueChanged<MenuItem> onSelectItem;
  const SettingScreen(
      {key, required this.currentItem, required this.onSelectItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        primaryColor: Colors.white,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        size: 26,
                        color: kNavbarColor,
                      ),
                      onPressed: () {
                        Get.to(() => BottomNavScreen());
                        // Navigator.of(context).p/ush(MaterialPageRoute(
                        //     builder: (context) => BottomNavBar()));
                      },
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Setting",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          color: kNavbarColor),
                    ),
                  ],
                ),
              ),
              Spacer(),
              ...MenuItems.all.map(buildMenuItem).toList(),
              Spacer(
                flex: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMenuItem(MenuItem item) => ListTileTheme(
        selectedTileColor: Colors.grey,
        child: ListTile(
          selectedTileColor: kNavbarColor.withOpacity(0.9),
          selected: currentItem == item,
          minLeadingWidth: 20,
          leading: Icon(item.icon),
          title: Text(item.title),
          onTap: () {
            onSelectItem(item);
          },
        ),
      );
}