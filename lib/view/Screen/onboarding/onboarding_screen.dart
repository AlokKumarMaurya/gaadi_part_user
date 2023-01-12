import 'package:flutter/material.dart';
import '../../../data/model/response/onboarding_model.dart';
import '../../../utill/app_constants.dart';
import '../../../utill/custom_themes.dart';
import '../../../utill/dimensions.dart';
import '../../../utill/images.dart';
import '../auth/auth_screen.dart';


class OnBoardingScreen extends StatefulWidget {
  final Color indicatorColor;
  final Color selectedIndicatorColor;

  OnBoardingScreen({
    this.indicatorColor = Colors.grey,
    this.selectedIndicatorColor = Colors.black,
  });

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _pageController = PageController();

  List<OnboardingModel> onBoardingList = [
    OnboardingModel(
      'assets/images/onboarding_image_one.jpg',
      'Welcome to ${AppConstants.APP_NAME}',
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy"
    ),
    OnboardingModel(
      'assets/images/onboarding_image_two.jpg',
      'Easy and Secure Checkout',
      'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
    ),
    OnboardingModel(
      'assets/images/onboarding_image_three.jpg',
      'Fastest Delivery',
      'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC',
    )
  ];

  int _selectedIndex = 0;

  changeSelectIndex(int index){
    setState(() {
      _selectedIndex=index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Provider.of<OnBoardingProvider>(context, listen: false).initBoardingList(context);

    double _height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(Images.background, fit: BoxFit.fill),
          ),
          ListView(
            children: [
              SizedBox(
                height: _height*0.7,
                child: PageView.builder(
                  itemCount: onBoardingList.length,
                  controller: _pageController,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                      child: Column(
                        children: [
                          Image.asset(onBoardingList[index].imageUrl, height: _height*0.5),
                          Text(onBoardingList[index].title, style: titilliumBold.copyWith(fontSize: _height*0.035), textAlign: TextAlign.center),
                          Text(onBoardingList[index].description, textAlign: TextAlign.center, style: titilliumRegular.copyWith(
                            fontSize: _height*0.015,
                          )),
                        ],
                      ),
                    );
                  },
                  onPageChanged: (index) {
                    changeSelectIndex(index);
                  },
                ),
              ),
              Column(
                children: [
                  SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _pageIndicators(onBoardingList, context),
                    ),
                  ),
                  Container(
                    height: 45,
                    margin: EdgeInsets.symmetric(horizontal: 70, vertical: Dimensions.PADDING_SIZE_SMALL),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        gradient: LinearGradient(colors: [
                          Theme.of(context).primaryColor,
                          Theme.of(context).primaryColor,
                          Theme.of(context).primaryColor,
                        ])),
                    child: TextButton(
                      onPressed: () {
                        if (_selectedIndex == onBoardingList.length - 1) {
                          // Provider.of<SplashProvider>(context, listen: false).disableIntro();
                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => AuthScreen()));
                        } else {
                          _pageController.animateToPage(_selectedIndex+1, duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: Text(_selectedIndex == onBoardingList.length - 1
                            ? 'GET STARTED':'NEXT',
                            style: titilliumSemiBold.copyWith(color: Colors.white, fontSize: Dimensions.FONT_SIZE_LARGE)),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> _pageIndicators(var onBoardingList, BuildContext context) {
    List<Container> _indicators = [];

    for (int i = 0; i < onBoardingList.length; i++) {
      _indicators.add(
        Container(
          width: i == _selectedIndex ? 18 : 7,
          height: 7,
          margin: EdgeInsets.only(right: 5),
          decoration: BoxDecoration(
            color: i == _selectedIndex ? Theme.of(context).primaryColor : Colors.white,
            borderRadius: i == _selectedIndex ? BorderRadius.circular(50) : BorderRadius.circular(25),
          ),
        ),
      );
    }
    return _indicators;
  }
}
