import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:launch_review/launch_review.dart';
import 'package:noteapp/constant/constant.dart';
import 'package:noteapp/models/settings_model.dart';
import 'package:noteapp/screens/dart_format_screen.dart';
import 'package:noteapp/screens/select_country_screen.dart';
import 'package:noteapp/services/theme_service.dart';
import 'package:noteapp/utils/storage_utils.dart';
import 'package:noteapp/utils/themes.dart';
import 'package:share_plus/share_plus.dart';

class NewSettingsScreen extends StatefulWidget {
  const NewSettingsScreen({Key? key}) : super(key: key);

  @override
  _NewSettingsScreenState createState() => _NewSettingsScreenState();
}

class _NewSettingsScreenState extends State<NewSettingsScreen> {
  bool _switchValue = true;
  bool _currencyswitchValue = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _switchValue = StorageUtils.getSettingsItem().isLightTheme;
    _currencyswitchValue =
        StorageUtils.getSettingsItem().isCurrencyEnableGlobally;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          'kTitleSetting'.tr,
          style: Get.theme.appBarTheme.titleTextStyle,
          // style: GoogleFonts.nunito().copyWith(
          //   fontSize: 18,
          //   fontWeight: FontWeight.bold,
          //   color: Colors.white,
          // ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SwitchListTile.adaptive(
              secondary: Icon(Icons.settings_brightness),
              value: _switchValue,
              onChanged: (isLight) {
                setState(() {
                  _switchValue = isLight;
                  Get.changeTheme(isLight ? Themes.light : Themes.dark);
                  Theme.of(context).switchTheme;
                  ThemeService().switchTheme(isLight);
                });
              },
              title: Text('Light Mode'),
            ),
            SwitchListTile.adaptive(
              secondary: Icon(Icons.paid),
              value: _currencyswitchValue,
              onChanged: (isCurrencyEnabled) {
                setState(() {
                  _currencyswitchValue = isCurrencyEnabled;
                  SettingsModel settingModel = StorageUtils.getSettingsItem();
                  settingModel.isCurrencyEnableGlobally = isCurrencyEnabled;
                  StorageUtils.saveSettingsItem(settingModel);
                });
              },
              title: Text('Enable currency'),
            ),
            ListTile(
              leading: Icon(Icons.language),
              title: Text('Language and Currency'),
              onTap: () {
                Get.to(() => SelectCountryScreen(isEditing: true),
                    transition: Transition.rightToLeft);
              },
            ),
            ListTile(
              leading: Icon(Icons.date_range),
              title: Text('Date format'),
              onTap: () {
                Get.to(() => DateFormatScreen(),
                    transition: Transition.rightToLeft);
              },
            ),
            ListTile(
              leading: Icon(Icons.share),
              title: Text('Share'),
              onTap: () {
                Share.share(
                    GetPlatform.isAndroid ? kPlaystoreLink : kAppstoreLink,
                    subject: kAppName);
              },
            ),
            ListTile(
              leading: Icon(Icons.star),
              title: Text('Rate us'),
              onTap: () {
                LaunchReview.launch(writeReview: true);
              },
            ),
          ],
        ),
      ),
    );
  }
}
