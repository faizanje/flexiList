import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:noteapp/components/skip_button.dart';
import 'package:noteapp/constant/constant.dart';
import 'package:noteapp/constant/introduction_json.dart';
import 'package:noteapp/constant/strings.dart';
import 'package:noteapp/screens/bottom_nav_screen.dart';
import 'package:noteapp/screens/select_country_screen.dart';

class OnBordingScreen extends StatelessWidget {
  const OnBordingScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => SafeArea(
        child: IntroductionScreen(
          globalBackgroundColor: Theme.of(context).backgroundColor,
          pages: List.generate(
            onBoardData.length,
            (index) => PageViewModel(
              title: onBoardData[index]['onBoardTitle'],
              body: onBoardData[index]['onBoardDescription'],
              image: buildImage(onBoardData[index]['onBoardPath']),
              decoration: getPageDecoration(context),
            ),
          ),
          done: Text('kNext'.tr,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
          // onDone: () => Get.to(() => BottomNavScreen()),
          onDone: () => Get.to(() => SelectCountryScreen()),
          showSkipButton: true,
          skip: WidgetButton(),
          // onSkip: () => Get.to(() => BottomNavScreen()),
          onSkip: () => Get.to(() => SelectCountryScreen()),
          next: Icon(Icons.arrow_forward),
          dotsDecorator: getDotDecoration(context),
          onChange: (index) => print('Page $index selected'),
          skipFlex: 0,
          nextFlex: 0,
          animationDuration: 500,
        ),
      );

  Widget buildImage(String path) =>
      Center(child: Image.asset(path, width: 350));

  DotsDecorator getDotDecoration(BuildContext context) {
    return DotsDecorator(
      color: Color(0xFFBDBDBD),
      activeColor: Theme.of(context).primaryColor,
      size: Size(10, 10),
      activeSize: Size(22, 10),
      activeShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
    );
  }

  PageDecoration getPageDecoration(BuildContext context) {
    return PageDecoration(
      titleTextStyle: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).textTheme.bodyText1?.color),
      bodyTextStyle: Theme.of(context).textTheme.bodyText1!.copyWith(),
      descriptionPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10)
          .copyWith(bottom: 0),
      imagePadding: EdgeInsets.all(24),
      pageColor: Theme.of(context).backgroundColor,
    );
  }
}
