import 'package:country_currency_pickers/country.dart';
import 'package:country_currency_pickers/currency_picker_dropdown.dart';
import 'package:country_currency_pickers/utils/utils.dart';
import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:noteapp/constant/constant.dart';
import 'package:noteapp/screens/bottom_nav_screen.dart';

class SelectCountryScreen extends StatefulWidget {
  static const routeName = "/selectLan";
  @override
  _SelectCountryScreenState createState() => _SelectCountryScreenState();
}

class Item {
  Item(this.name, this.icon);
  final String name;
  final SvgPicture icon;
}

class CountryItem {
  CountryItem(this.name, this.icon);
  final String name;
  final SvgPicture icon;
}

class _SelectCountryScreenState extends State<SelectCountryScreen> {
  bool flag = false;

  List<Item> listItem = <Item>[
    Item('AUD', SvgPicture.asset('assets/images/aud.svg')),
    Item('CAD', SvgPicture.asset('assets/images/cad.svg')),
    Item('GBP', SvgPicture.asset('assets/images/gbp.svg')),
    Item('INR', SvgPicture.asset('assets/images/inr.svg')),
    Item('USD', SvgPicture.asset('assets/images/usd.svg')),
    Item('YEN', SvgPicture.asset('assets/images/yen.svg')),
  ];

  List<CountryItem> countryListItem = <CountryItem>[
    CountryItem('Hindi', SvgPicture.asset('assets/images/hindi.svg')),
    CountryItem('English', SvgPicture.asset('assets/images/english.svg')),
    CountryItem('Urdu', SvgPicture.asset('assets/images/urdu.svg')),
  ];
  late Item selectedItem;
  late CountryItem countrySelectedItem;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedItem = listItem.first;
    countrySelectedItem = countryListItem.first;

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
          title: Text("Language"),
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
                        'Choose Your Language and Currency',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w900,
                          color: kNavbarColor,
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
                    border: Border.all(color: kNavbarColor)),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<Item>(
                    isExpanded: true,
                    hint: Text("Select item"),
                    value: selectedItem,
                    onChanged: (Item? value) {
                      setState(() {
                        selectedItem = value!;
                      });
                    },
                    items: listItem.map((Item value) {
                      return DropdownMenuItem<Item>(
                        value: value,
                        child: Row(
                          children: <Widget>[
                            value.icon,
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              value.name,
                              style: TextStyle(color: Colors.black),
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
                    border: Border.all(color: kNavbarColor)),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<CountryItem>(
                    isExpanded: true,
                    hint: Text("Select item"),
                    value: countrySelectedItem,
                    onChanged: (CountryItem? value) {
                      setState(() {
                        countrySelectedItem = value!;
                      });
                    },
                    items: countryListItem.map((CountryItem value) {
                      return DropdownMenuItem<CountryItem>(
                        value: value,
                        child: Row(
                          children: <Widget>[
                            value.icon,
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              value.name,
                              style: TextStyle(color: Colors.black),
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
                          border: Border.all(color: kNavbarColor)),
                      child: InkWell(
                        onTap: () {
                          Get.to(() => BottomNavScreen());
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
                              color: kNavbarColor,
                              border: Border.all(color: kNavbarColor)),
                          child: Text(
                            "GET STARTED",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              fontStyle: FontStyle.italic,
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
