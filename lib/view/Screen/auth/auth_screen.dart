import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gaadi_part/view/Screen/auth/widget/sign_in_widget.dart';
import 'package:gaadi_part/view/Screen/auth/widget/sign_up_widget.dart';
import 'package:provider/provider.dart';
import '../../../provider/auth_provider.dart';
import '../../../utill/custom_themes.dart';
import '../../../utill/dimensions.dart';
import '../../../utill/images.dart';

class AuthScreen extends StatelessWidget{
  final int initialPage;
  AuthScreen({this.initialPage = 0});

  @override
  Widget build(BuildContext context) {
    // Provider.of<ProfileProvider>(context, listen: false).initAddressTypeList(context);
    // Provider.of<AuthProvider>(context, listen: false).isRemember;
    PageController _pageController = PageController(initialPage: initialPage);

    return WillPopScope(
      onWillPop: (){
        exit(0);
      },
      child: Scaffold(
        body: Stack(
          clipBehavior: Clip.none,
          children: [

          Image.asset(Images.background, fit: BoxFit.fill,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width),

            Consumer<AuthProvider>(
              builder: (context, auth, child) => SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: Dimensions.topSpace),
                    Image.asset(Images.logo_with_name_image, height: 150, width: 200),


                    Padding(
                      padding: EdgeInsets.all(Dimensions.MARGIN_SIZE_LARGE),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(bottom: 0,
                            right: Dimensions.MARGIN_SIZE_EXTRA_SMALL, left: 0,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 1, color: Color(0xFFE6E6E6),
                            ),
                          ),


                          Consumer<AuthProvider>(
                            builder: (context,authProvider,child)=>Row(
                              children: [
                                InkWell(
                                  onTap: () => _pageController.animateToPage(0, duration: Duration(seconds: 1), curve: Curves.easeInOut),
                                  child: Column(
                                    children: [
                                      Text('SIGN IN',
                                          style: authProvider.selectedIndex == 0 ?
                                          titilliumSemiBold : titilliumRegular),
                                      Container(
                                        height: 1, width: 40,
                                        margin: EdgeInsets.only(top: 8),
                                        color: authProvider.selectedIndex == 0 ?
                                        Theme.of(context).primaryColor : Colors.transparent,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_LARGE),


                                InkWell(
                                  onTap: () => _pageController.animateToPage(1,
                                      duration: Duration(seconds: 1), curve: Curves.easeInOut),
                                  child: Column(
                                    children: [

                                      Text('SIGN UP',
                                          style: authProvider.selectedIndex == 1 ?
                                          titilliumSemiBold : titilliumRegular),

                                      Container(height: 1, width: 50,
                                          margin: EdgeInsets.only(top: 8),
                                          color: authProvider.selectedIndex == 1 ?
                                          Theme.of(context).primaryColor : Colors.transparent
                                      ),
                                    ],
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ],
                      ),
                    ),


                    Expanded(
                      child: Consumer<AuthProvider>(
                        builder: (context,authProvider,child)=>PageView.builder(
                          itemCount: 2,
                          controller: _pageController,
                          itemBuilder: (context, index) {
                            if (authProvider.selectedIndex == 0) {
                              return SignInWidget();
                            } else {
                              return SignUpWidget();
                            }
                          },
                          onPageChanged: (index) {
                            authProvider.updateSelectedIndex(index);
                          },
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

