import 'package:flutter/material.dart';
import 'package:gaadi_part/view/Screen/cart/cart_controller.dart';
import 'package:gaadi_part/view/Screen/cart/cart_screen.dart';
import 'package:gaadi_part/view/Screen/checkout/checkout_screen.dart';
import 'package:gaadi_part/view/Screen/order/order_screen.dart';
import 'package:get/get.dart';

import '../../utill/custom_themes.dart';
import '../../utill/dimensions.dart';
import 'botton/custom_button.dart';

class MyDialog extends StatelessWidget {
  final bool isFailed;
  final double rotateAngle;
  final IconData icon;
  final String title;
  final String description;

  MyDialog(
      {this.isFailed = false,
      this.rotateAngle = 0,
      @required this.icon,
      @required this.title,
      @required this.description});


  @override
  final cartController = Get.put(CartController());
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
        child: Stack(clipBehavior: Clip.none, children: [
          Positioned(
            left: 0,
            right: 0,
            top: -55,
            child: Container(
              height: 80,
              width: 80,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  shape: BoxShape.circle),
              child: Transform.rotate(
                  angle: rotateAngle,
                  child: Icon(icon, size: 40, color: Colors.white)),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 40),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Text(title,
                  style: robotoBold.copyWith(
                      fontSize: Dimensions.FONT_SIZE_LARGE)),
              SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
              Text(description,
                  textAlign: TextAlign.center, style: titilliumRegular),
              SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.PADDING_SIZE_LARGE),
                child: CustomButton(
                    buttonText: 'ok',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (_)=> OrderScreen()));
                      cartController.getCart();
                      // Navigator.removeRouteBelow(context, MaterialPageRoute(builder: (_) => OrderScreen()));
                    }),
              ),
            ]),
          ),
        ]),
      ),
    );
  }
}
