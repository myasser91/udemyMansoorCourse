// ignore_for_file: unused_import, must_be_immutable

import 'package:flutter/material.dart';
import 'package:messenger/modules/ShopappModules/shopLoginScreen.dart';
import 'package:messenger/models/PageModel.dart';
import 'package:messenger/modules/social_app_modules/social_login_screen/social_login_screen.dart';
import 'package:messenger/shared/components/components.dart';
import 'package:messenger/shared/components/constants.dart';
import 'package:messenger/shared/shared.network/local/cash_Helper.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoarding extends StatelessWidget {
  int currentindex = 0;
  bool isLast = false;
  var boardController = PageController();
  List<OnBoardingPagemodel> pages = [];

  Widget build(BuildContext context) {
    pagemake();
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(onPressed: () => submit(context), child: Text('SKIP'))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (index) {
                  if (index == pages.length - 1) {
                    isLast = true;
                  } else
                    isLast = false;
                },
                controller: boardController,
                itemCount: pages.length,
                itemBuilder: (context, index) => Column(children: [
                  SizedBox(width: 400, height: 400, child: pages[index].image),
                  SizedBox(
                    height: 100,
                  ),
                  Text(
                    pages[index].title,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SmoothPageIndicator(
                    controller: boardController,
                    count: pages.length,
                    effect: ExpandingDotsEffect(
                        activeDotColor: defaultColor,
                        dotColor: Colors.grey,
                        expansionFactor: 5,
                        dotWidth: 10,
                        spacing: 5),
                  ),
                  Spacer(),
                  FloatingActionButton(
                      backgroundColor: defaultColor,
                      onPressed: () {
                        if (isLast == true) {
                          submit(context);
                        } else {
                          boardController.nextPage(
                              duration: Duration(microseconds: 750),
                              curve: Curves.fastLinearToSlowEaseIn);
                        }
                      },
                      child: Icon(Icons.arrow_forward_ios))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void submit(context) {
    CashHelper.savedata(key: 'onboarding', value: true).then((value) {
      if (value) NavigateToreplace(context, SocialLoginScreen());
    });
  }

  void pagemake() {
    pages = [];
    pages.add(OnBoardingPagemodel(
        image: Image.asset(
          'images/shop1.png',
        ),
        title: 'Hello'));
    pages.add(OnBoardingPagemodel(
        image: Image.asset(
          'images/shop2.png',
        ),
        title: 'Welcome'));
    pages.add(OnBoardingPagemodel(
        image: Image.asset(
          'images/shop3.png',
        ),
        title: 'To OUR SHOP'));
  }
}
