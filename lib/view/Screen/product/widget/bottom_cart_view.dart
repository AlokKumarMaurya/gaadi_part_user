import 'package:flutter/material.dart';
import 'package:gaadi_part/helper/shared_preference.dart';
import 'package:gaadi_part/view/Screen/auth/auth_screen.dart';
import 'package:gaadi_part/view/Screen/cart/cart_controller.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../../../constantWiget/appBottomSheet.dart';
import '../../../../utill/custom_themes.dart';
import '../../../../utill/dimensions.dart';
import '../../../../utill/images.dart';
import '../../../baseWidget/show_custom_snakbar.dart';
import '../../cart/cart_screen.dart';
import 'cart_bottom_sheet.dart';

class BottomCartView extends StatelessWidget {
  String proName;
  String ratingCount;
  String lowerPrice;
  String higherPrice;
  String image;
  String stock;
  String description;
  String proId;

  // final Product product;

  BottomCartView(
      {this.proName,
      this.ratingCount,
      this.lowerPrice,
      this.higherPrice,
      this.image,
      this.stock,
      this.description,
      this.proId});

  final cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Theme.of(context).highlightColor,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        boxShadow: [
          BoxShadow(color: Colors.grey[300], blurRadius: 15, spreadRadius: 1)
        ],
      ),
      child: Row(children: [
        Expanded(
            flex: 3,
            child: Padding(
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
              child: Stack(children: [
                GestureDetector(
                    onTap: () async{
                      if(    await HelperFunction.getLogin()!=null && await HelperFunction.getLogin()!=false ){

                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => CartScreen()));

                      }else{
                        AppBottomSheet.showConfirmationBottomSheet(context,
                            description: "Do you want to Login?",onLeftClick: (){
                              Navigator.pop(context);

                            },
                            onRightClick: (){
                              Navigator.push(context,MaterialPageRoute(builder: (context) => AuthScreen(),));
                            });
                      }



                    },
                    child: Image.asset(Images.cart_arrow_down_image,
                        color: Theme.of(context).primaryColor)),
                Positioned(
                  top: 0,
                  right: 15,
                  child: Container(
                    height: 17,
                    width: 17,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).primaryColor,
                    ),
                    child: Obx(()=> Text(
                      // cartController.cartProductList.value.data.length.toString(),
                              cartController.cartLength.toString(),
                      style: titilliumSemiBold.copyWith(
                          fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                          color: Colors.white70),
                    )),
                  ),
                )
              ]),
            )),
        Expanded(
            flex: 11,
            child: InkWell(
              onTap: () async {
                if (await HelperFunction.getLogin() != null &&
                    await HelperFunction.getLogin() != false) {
                  showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (con) => CartBottomSheet(
                        callback: () {
                          showCustomSnackBar('Add to cart', context,
                              isError: false);
                        },
                        higherPrice: higherPrice,
                        ratingCount: ratingCount,
                        image: image,
                        lowerPrice: lowerPrice,
                        proName: proName,
                        stock: stock,
                        description: description,
                        id: proId,
                      ));
                } else {
                  AppBottomSheet.showConfirmationBottomSheet(context,
                      description: "Do you want to Login?", onLeftClick: () {
                        Navigator.pop(context);
                      }, onRightClick: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AuthScreen(),
                            ));
                      });
                }
              },
              child: Container(
                height: 50,
                margin: EdgeInsets.symmetric(horizontal: 5),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).primaryColor,
                ),
                child: Text(
                  'Add to cart',
                  style: titilliumSemiBold.copyWith(
                      fontSize: Dimensions.FONT_SIZE_LARGE,
                      color: Colors.white),
                ),
              ),
            )),
      ]),
    );
  }
}
