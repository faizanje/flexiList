import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noteapp/models/setting_menu_json.dart';

import 'bottom_nav_screen.dart';

class MenuItems {
  // static const dateFormat =
  //     MenuItem(title: "Date Format", icon: Icons.date_range);
  static const archive = MenuItem(title: 'TitleArchive', icon: Icons.archive);
  static const settings = MenuItem(title: 'TitleSetting', icon: Icons.settings);
  static const theme = MenuItem(title: 'Theme', icon: Icons.color_lens_rounded);
  // static const currency =
  //     MenuItem(title: "Currency", icon: Icons.monetization_on_outlined);
  static const language = MenuItem(title: "Language", icon: Icons.language);

  static const all = <MenuItem>[
    theme,
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
    return Scaffold(
      backgroundColor: Get.theme.primaryColorDark,
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
                      color: Theme.of(context).primaryColor,
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
                    'kTitleSetting'.tr,
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).primaryColor),
                  ),
                ],
              ),
            ),
            Spacer(),
            ...MenuItems.all.map((e) => buildMenuItem(context, e)).toList(),
            Spacer(
              flex: 2,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem(BuildContext context, MenuItem item) {
    return ListTileTheme(
      selectedTileColor: Colors.grey,
      child: ListTile(
        selected: currentItem == item,
        minLeadingWidth: 20,
        leading: Icon(
          item.icon,
          color: Get.theme.primaryColor,
        ),
        title: Text('k${item.title}'.tr,
            style: TextStyle(
              color: Get.theme.primaryColor,
            )),
        onTap: () {
          onSelectItem(item);
        },
      ),
    );
  }
}
