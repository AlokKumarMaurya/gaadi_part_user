import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gaadi_part/constantWiget/widgetUtil.dart';

import 'appBottomNav.dart';

class AppBottomSheet {
  static showConfirmationBottomSheet(
    BuildContext context, {
    String description = '',
    Function() onRightClick,
    Function() onLeftClick,
  }) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Wrap(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Container(margin: EdgeInsets.symmetric(horizontal: 10,vertical: 25),child: Text(description, style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold))),
                  AppBottomNavButton(
                      onLeftClick: () =>onLeftClick(),
                      onRightClick: ()=>
                          onRightClick()
                  )
                ],
              )
            ],
          );
        });
  }
}
