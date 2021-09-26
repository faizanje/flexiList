import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:noteapp/constant/constant.dart';
import 'package:noteapp/pages/select_country_lang.dart';
import 'package:noteapp/widgets/slide_dots_Animation.dart';

import '../constant/introduction_json.dart';

class OnboardingPages extends StatefulWidget {
  @override
  _OnboardingPagesState createState() => _OnboardingPagesState();
}

class _OnboardingPagesState extends State<OnboardingPages> {
  int _currentPage = 0;

  PageController pageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: <Widget>[
        PageView(
            controller: pageController,
            onPageChanged: (_pageController) {
              setState(() {
                _currentPage = _pageController;
              });
              print(_pageController);
            },
            children: [
              OnBoardScreen(
                path: onBoardData[0]['path'],
              ),
              OnBoardScreen(
                path: onBoardData[1]['path'],
              ),
              OnBoardScreen(
                path: onBoardData[2]['path'],
              ),
            ]),
        Stack(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(bottom: 25),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: getSlideDots(),
              ),
            ),
          ],
        ),
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

class OnBoardScreen extends StatelessWidget {
  final String path;
  const OnBoardScreen({
    Key? key,
    required this.path,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SelectContLang()));
                    },
                    child: Container(
                      width: 100,
                      height: 40,
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
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(50),
                child: Image.asset(
                  path,
                ),
              ),
              Text(
                onBoardData[0]['title'],
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 30.0),
                child: Text(
                  onBoardData[0]['description'],
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          Spacer(),
          Stack(
            children: <Widget>[
              Positioned(
                left: MediaQuery.of(context).size.width / 2.44,
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
                    ),
                  ),
                ),
              ),
              SvgPicture.asset(
                'assets/images/footer.svg',
                width: MediaQuery.of(context).size.width,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
