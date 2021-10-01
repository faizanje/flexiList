import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:noteapp/components/onboarding_item.dart';
import 'package:noteapp/constant/constant.dart';
import 'package:noteapp/pages/select_country_lang.dart';
import 'package:noteapp/widgets/slide_dots_Animation.dart';
import '../constant/introduction_json.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int _currentPage = 0;

  PageController pageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 26.sp, right: 26.sp, bottom: 15.sp),
          child: Align(
            alignment: Alignment.topRight,
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SelectContLang()));
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30),
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30)),
                    color: Colors.transparent,
                    border: Border.all(color: kNavbarColor)),
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.all(2.4),
                  width: 100,
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30),
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30)),
                      color: kNavbarColor,
                      border: Border.all(color: kNavbarColor)),
                  child: Text(
                    "SKIP",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Container(
          width: size.width,
          height: size.height * 0.4,
          child: PageView(
              controller: pageController,
              onPageChanged: (_pageController) {
                setState(() {
                  _currentPage = _pageController;
                });
                print(_pageController);
              },
              children: [
                OnBoardingItem(
                  path: onBoardData[0]['path'],
                ),
                OnBoardingItem(
                  path: onBoardData[1]['path'],
                ),
                OnBoardingItem(
                  path: onBoardData[2]['path'],
                ),
              ]),
        ),
        Stack(
          children: <Widget>[
            Positioned(
              left: MediaQuery.of(context).size.width / 2.5,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.all(
                    Radius.circular(100),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.3),
                      spreadRadius: 7,
                      blurRadius: 7,
                      offset: Offset(3, 5),
                    ),
                  ],
                ),
                child: FloatingActionButton(
                  onPressed: () {},
                  backgroundColor: kNavbarColor,
                  child: Icon(
                    Icons.arrow_forward_rounded,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SvgPicture.asset(
              'assets/images/footer.svg',
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.contain,
            ),
          ],
        ),
        // Stack(
        //   children: <Widget>[
        //     Container(
        //       child: Row(
        //         crossAxisAlignment: CrossAxisAlignment.center,
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: getSlideDots(),
        //       ),
        //     ),
        //   ],
        // ),
      ],
    );
  }

  List<Widget> getSlideDots() {
    List<Widget> widgets = [];
    for (int i = 0; i < 3; i++) {
      if (i == _currentPage) {
        widgets.add(SlideDots(true));
      } else {
        widgets.add(SlideDots(false));
      }
    }
    return widgets;
  }
}
