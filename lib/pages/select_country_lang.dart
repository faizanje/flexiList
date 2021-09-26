import 'package:country_currency_pickers/country.dart';
import 'package:country_currency_pickers/country_picker_dropdown.dart';
import 'package:country_currency_pickers/utils/utils.dart';
import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/material.dart';
import 'package:noteapp/constant/constant.dart';
import 'package:noteapp/widgets/BottomNavBar.dart';

class SelectContLang extends StatefulWidget {
  static const routeName = "/selectLan";
  @override
  _SelectContLangState createState() => _SelectContLangState();
}

class _SelectContLangState extends State<SelectContLang> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                    Container(
                      alignment: AlignmentDirectional.centerStart,
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
                      child: CountryListPick(
                        appBar: AppBar(
                          backgroundColor: kNavbarColor,
                          title: Text('Pick your country'),
                        ),

                        pickerBuilder: (context, CountryCode? countryCode) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Image.asset(
                                    countryCode!.flagUri!,
                                    width: 40,
                                    height: 40,
                                    package: 'country_list_pick',
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Text(
                                    countryCode.name!,
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: kNavbarColor,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.arrow_drop_down_rounded,
                                    size: 50,
                                    color: kNavbarColor,
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                        theme: CountryTheme(
                          isShowFlag: true,
                          isShowTitle: true,
                          // isShowCode: true,
                          isDownIcon: true,
                          showEnglishName: false,
                          labelColor: kNavbarColor,
                        ),
                        initialSelection: '+62',

                        // initialSelection: 'US',
                        onChanged: (CountryCode? code) {
                          print(code!.name);
                          print(code.code);
                          print(code.dialCode);
                          print(code.flagUri);
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      alignment: AlignmentDirectional.centerStart,
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
                      child: CountryPickerDropdown(
                        initialValue: 'tr',
                        itemBuilder: _buildDropdownItem,
                        onValuePicked: (Country? country) {
                          print("${country!.name}");
                        },
                      ),
                    ),
                  ],
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
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => BottomNavBar()));
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

  Widget _buildDropdownItem(Country country) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(
            width: 15.0,
          ),
          CountryPickerUtils.getDefaultFlagImage(country),
          SizedBox(
            width: 8.0,
          ),
          Text("${country.isoCode}"),
        ],
      );
}
