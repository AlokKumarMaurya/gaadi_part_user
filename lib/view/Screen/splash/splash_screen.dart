import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gaadi_part/helper/shared_preference.dart';
import 'package:gaadi_part/view/Screen/dashboard/dashboard_screen.dart';
import 'package:gaadi_part/view/Screen/onboarding/onboarding_screen.dart';
import 'package:gaadi_part/view/Screen/splash/splash_painter.dart';

import '../../../utill/images.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    Timer(Duration(seconds: 3), ()async{
        String islogin = await HelperFunction.getLogin();
        if(islogin == 'true') {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DashBoardScreen()));
        }else
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => OnBoardingScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none, children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color:Colors.white60, /*Provider.of<ThemeProvider>(context).darkTheme ? Colors.black : ColorResources.getPrimary(context),*/
          child: CustomPaint(
            painter: SplashPainter(),
          ),
        ),
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Image.asset(Images.logo_with_name_image, height: 250.0, fit: BoxFit.scaleDown,
              //   width: 250.0, color: Theme.of(context).cardColor,),
              Image.asset(Images.logo_with_name_image, height: 250.0, fit: BoxFit.scaleDown,
                width: 250.0, ),
            ],
          ),
        ),
      ],
      )
    );
  }
}
