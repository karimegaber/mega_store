import 'package:flutter/material.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

//flutter run --no-sound-null-safety
class OnBoardingModel {
  final String image;
  final String title;
  final String subTitle;

  OnBoardingModel({
    required this.image,
    required this.title,
    required this.subTitle,
  });
}

List<OnBoardingModel> models = [
  OnBoardingModel(
    image: 'assets/images/onborad_1.png',
    title: 'Start ordering online',
    subTitle: 'with extremely simple steps.',
  ),
  OnBoardingModel(
    image: 'assets/images/onborad_2.png',
    title: 'Choose something to buy',
    subTitle: 'with high quality.',
  ),
  OnBoardingModel(
    image: 'assets/images/onborad_3.png',
    title: 'Very fast Delivery',
    subTitle: 'within 2 days at most.',
  ),
];

class OnBoardingScreen extends StatelessWidget {
  var pageController = PageController();
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    void submit() {
      CacheHelper.insertData(
        key: 'onBoardingSkip',
        value: true,
      ).then((value) {
        if (value) {
          Navigator.of(context)
              .pushReplacementNamed(LoginScreen.loginScreenRoute);
        }
      });
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            child: Text('SKIP'),
            onPressed: submit,
          ),
          SizedBox(
            width: 3,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: pageController,
                itemBuilder: (context, index) {
                  pageIndex = index;
                  return buildOnBoardingItem(models[index]);
                },
                physics: BouncingScrollPhysics(),
                itemCount: models.length,
              ),
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: pageController,
                  count: models.length,
                  effect: ExpandingDotsEffect(
                    activeDotColor: Colors.deepPurple,
                    dotColor: Colors.grey,
                    expansionFactor: 3,
                    dotWidth: 15,
                    spacing: 5.0,
                  ),
                ),
                Spacer(),
                FloatingActionButton(
                  backgroundColor: Colors.deepPurple,
                  child: Icon(
                    Icons.keyboard_arrow_right,
                    size: 30.0,
                  ),
                  onPressed: () {
                    if (pageIndex < 2) {
                      pageController.nextPage(
                        duration: Duration(
                          milliseconds: 750,
                        ),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    } else {
                      submit();
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildOnBoardingItem(OnBoardingModel model) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Image(
          image: AssetImage('${model.image}'),
        ),
      ),
      SizedBox(
        height: 30.0,
      ),
      Text(
        '${model.title}',
        style: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
          color: Colors.deepPurple,
        ),
      ),
      Text(
        '${model.subTitle}',
        style: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
          color: onBoardingTextColor,
        ),
      ),
      SizedBox(
        height: 40.0,
      ),
    ],
  );
}
