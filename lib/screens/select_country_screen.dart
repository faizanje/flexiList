import 'dart:convert';

import 'package:country_currency_pickers/country.dart';
import 'package:country_currency_pickers/currency_picker_dropdown.dart';
import 'package:country_currency_pickers/utils/utils.dart';
import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:noteapp/constant/constant.dart';
import 'package:noteapp/constant/strings.dart';
import 'package:noteapp/models/item_entity.dart';
import 'package:noteapp/models/settings_model.dart';
import 'package:noteapp/screens/bottom_nav_screen.dart';
import 'package:noteapp/utils/locale_utils.dart';
import 'package:noteapp/utils/snack_bar_utils.dart';
import 'package:noteapp/utils/storage_utils.dart';

enum SETTING_TYPE { LANGUAGE, CURRENCY }

class SelectCountryScreen extends StatefulWidget {
  final bool isEditing;
  final SETTING_TYPE? settingType;
  SelectCountryScreen({this.isEditing = false, this.settingType});
  // SelectCountryScreen({required this.isEditing});
  static const routeName = "/selectLan";
  @override
  _SelectCountryScreenState createState() => _SelectCountryScreenState();
}

// class Item {
//   Item(this.name, this.icon);
//   final String name;
//   final SvgPicture icon;
// }

class _SelectCountryScreenState extends State<SelectCountryScreen> {
  bool flag = false;

  List<Item> listItem = <Item>[
    Item('AUD', 'assets/images/aud.svg'),
    Item('CAD', 'assets/images/cad.svg'),
    Item('GBP', 'assets/images/gbp.svg'),
    Item('INR', 'assets/images/inr.svg'),
    Item('USD', 'assets/images/usd.svg'),
    Item('YEN', 'assets/images/yen.svg'),
  ];

  List<Item> countryListItem = <Item>[
    Item('English', 'assets/images/english.svg'),
    Item('Hindi', 'assets/images/hindi.svg'),
    Item('Urdu', 'assets/images/urdu.svg'),
  ];
  late Item selectedCurrency;
  late Item countrySelectedItem;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // if (widget.isEditing) {
    SettingsModel settingsModel = StorageUtils.getSettingsItem();
    // print('${item.name} ${item.iconPath}');
    // print('${item.name}: ${item.iconPath}');
    int indexCurrency = listItem.indexWhere(
        (element) => element.name == settingsModel.currencyItem.name);
    selectedCurrency = listItem[indexCurrency];
    int indexCountry = countryListItem.indexWhere(
        (element) => element.name == settingsModel.countryItem.name);
    countrySelectedItem = countryListItem[indexCountry];
    // } else {
    //   selectedCurrency = listItem.first;
    //   countrySelectedItem = countryListItem.first;
    // }

    if (ZoomDrawer.of(context) != null) {
      ZoomDrawer.of(context)!.toggle();
    }
    setState(() {
      flag = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          // backgroundColor: Theme.of(context).backgroundColor,
          title: Text(
            'kLanguage'.tr,
            style: Get.theme.appBarTheme.titleTextStyle,
            // style: GoogleFonts.nunito(),
          ),
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          // leading: flag
          //     ? IconButton(
          //         onPressed: () {
          //           ZoomDrawer.of(context)!.toggle();
          //           setState(() {
          //             flag = false;
          //           });
          //         },
          //         icon: Icon(
          //           Icons.arrow_back,
          //           size: 37,
          //           color: Colors.white,
          //         ),
          //       )
          //     : IconButton(
          //         onPressed: () {
          //           ZoomDrawer.of(context)!.toggle();
          //           setState(() {
          //             flag = true;
          //           });
          //         },
          //         icon: Icon(
          //           Icons.arrow_forward_rounded,
          //           size: 37,
          //           color: Colors.white,
          //         ),
          //       ),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Align(
                alignment: AlignmentDirectional.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 60, horizontal: 30),
                      child: Text(
                        'kChooseLocation'.tr,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w900,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width - 60,
                height: 60,
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                    color: Colors.transparent,
                    border: Border.all(color: Theme.of(context).primaryColor)),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<Item>(
                    isExpanded: true,
                    hint: Text('kSelectItem'.tr),
                    value: selectedCurrency,
                    onChanged: (Item? value) {
                      setState(() {
                        selectedCurrency = value!;
                      });
                    },
                    items: listItem.map((Item value) {
                      return DropdownMenuItem<Item>(
                        value: value,
                        child: Row(
                          children: <Widget>[
                            SvgPicture.asset(
                              value.iconPath,
                              color: Theme.of(context).primaryColor,
                              height: kSizeCurrency,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              value.name,
                              // style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width - 60,
                height: 60,
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                    color: Colors.transparent,
                    border: Border.all(color: Theme.of(context).primaryColor)),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<Item>(
                    isExpanded: true,
                    hint: Text('kSelectItem'.tr),
                    value: countrySelectedItem,
                    onChanged: (Item? value) {
                      print(value!.name);
                      // if (value.name == "English") {
                      //   selectedLocale = locale[0]['locale'];
                      // }else if()
                      setState(() {
                        countrySelectedItem = value;
                      });
                    },
                    items: countryListItem.map((Item value) {
                      return DropdownMenuItem<Item>(
                        value: value,
                        child: Row(
                          children: <Widget>[
                            SvgPicture.asset(value.iconPath),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              value.name,
                              // style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              SizedBox(
                height: 70,
              ),
              Align(
                alignment: AlignmentDirectional.center,
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width - 60,
                      height: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                          color: Colors.transparent,
                          border: Border.all(
                              color: Theme.of(context).primaryColor)),
                      child: InkWell(
                        onTap: () async {
                          SettingsModel settingsModel =
                              StorageUtils.getSettingsItem();
                          settingsModel.countryItem = countrySelectedItem;
                          settingsModel.currencyItem = selectedCurrency;
                          LocaleUtils.updateLanguageByItem(countrySelectedItem);
                          if (widget.isEditing) {
                            StorageUtils.saveSettingsItem(settingsModel);
                            // Get.snackbar('Settings Updated',
                            //     'Settings has been updated successfully');
                            SnackBarUtils.showGetXSnackBar(
                                'Settings has been updated successfully');
                          } else {
                            settingsModel.hasWatchedTutorial = true;
                            StorageUtils.saveSettingsItem(settingsModel);
                            Get.offAll(() => BottomNavScreen(),
                                transition: Transition.rightToLeft);
                          }
                          // Navigator.of(context).push(MaterialPageRoute(
                          //     builder: (context) => BottomNavBar()));
                        },
                        child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.all(2.4),
                          width: MediaQuery.of(context).size.width - 70,
                          height: 60,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                              color: Theme.of(context).primaryColor,
                              border: Border.all(
                                  color: Theme.of(context).primaryColor)),
                          child: Text(
                            widget.isEditing ? 'kUpdate'.tr : 'kGetStarted'.tr,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: context.theme.accentColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCurrencyDropdownItem(Country country) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(
            width: 15.0,
          ),
          CountryPickerUtils.getDefaultFlagImage(country),
          SizedBox(
            width: 8.0,
          ),
          Text("${country.currencyCode}"),
        ],
      );
}
