import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:noteapp/constant/constant.dart';
import 'package:noteapp/models/settings_model.dart';
import 'package:noteapp/utils/snack_bar_utils.dart';
import 'package:noteapp/utils/storage_utils.dart';

class DateFormatScreen extends StatefulWidget {
  const DateFormatScreen({Key? key}) : super(key: key);

  @override
  _DateFormatScreenState createState() => _DateFormatScreenState();
}

class _DateFormatScreenState extends State<DateFormatScreen> {
  late String selectedDateFormat;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedDateFormat = StorageUtils.getSettingsItem().dateFormat;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          // backgroundColor: Theme.of(context).backgroundColor,
          title: Text(
            'kDateFormat'.tr,
            style: Get.theme.appBarTheme.titleTextStyle,
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
                        'kChooseDateFormat'.tr,
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
                  child: DropdownButton<String>(
                    isExpanded: true,
                    hint: Text('kSelectItem'.tr),
                    value: selectedDateFormat,
                    onChanged: (String? value) {
                      setState(() {
                        selectedDateFormat = value!;
                      });
                    },
                    items: kDateFormats.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Row(
                          children: <Widget>[
                            // SvgPicture.asset(
                            //   value.iconPath,
                            //   color: Theme.of(context).primaryColor,
                            //   height: kSizeCurrency,
                            // ),
                            // SizedBox(
                            //   width: 10,
                            // ),
                            Text(
                              value,
                              // style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
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
                          settingsModel.dateFormat = selectedDateFormat;
                          StorageUtils.saveSettingsItem(settingsModel);
                          // Get.snackbar('Date Format',
                          //     'Date format has been updated successfully');
                          SnackBarUtils.showGetXSnackBar(
                              'Date format has been updated successfully');
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
                            'kEditText'.tr,
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
}
