import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gaadi_part/view/Screen/cart/cart_controller.dart';
import 'package:gaadi_part/view/Screen/cart/widget/cart_widget.dart';
import 'package:gaadi_part/view/Screen/home/home_screen.dart';
import 'package:gaadi_part/view/Screen/more/more_screen.dart';
import 'package:get/get.dart';

import '../../../data/DAshboard Repository/dashboadRepository.dart';
import '../../../data/model/response/cart/get_cart_model.dart';
import '../../../helper/shared_preference.dart';
import '../../../utill/app_constants.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/custom_themes.dart';
import '../../../utill/dimensions.dart';
import '../../../utill/images.dart';
import '../../baseWidget/custom_app_bar.dart';
import 'package:http/http.dart' as http;
import '../checkout/checkout_screen.dart';
import '../checkout/widget/shipping_method_bottom_sheet.dart';

class CartScreen extends StatefulWidget {
  CartScreen({Key key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  GetCartModel _getCartModel;
  bool isCartEmpty = false;
  final cartController = Get.put(CartController());

  getCarts() async {
    EasyLoading.show(status: 'loading...');
    var GetCartResponse = await DashboardApiClient().DashBoardGetCarts();

    if (GetCartResponse != null) {
      setState(() {
        _getCartModel = GetCartResponse;
        isCartEmpty = false;
        });
      EasyLoading.dismiss();
      return _getCartModel;
    } else {
      setState(() {
        isCartEmpty = true;
      });
      // print("asdas" + GetCartResponse.toString());
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //   content: Text(GetCartResponse.toString()),
      //   backgroundColor: Colors.red,
      // ));
      EasyLoading.dismiss();
    }
  }

  removeCart(id) async {
    EasyLoading.show(status: 'loading...');
    var api = Uri.parse(AppConstants.REMOVE_FROM_CART_URI + id.toString());
    String token = await HelperFunction.getToken();
    try {
      final response =
          await http.delete(api, headers: {'Authorization': 'Bearer $token'});
      if (response.statusCode == 200) {
        var res = jsonDecode(response.body);
        print("1111111111111111111111111111");
        print(res['message']);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(res['message'].toString()),
          backgroundColor: Colors.red,
        ));
        getCarts();
        cartController.getCart();
        EasyLoading.dismiss();
      } else {
        print(api);
        EasyLoading.dismiss();
      }
    } catch (e) {
      EasyLoading.dismiss();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getCarts();

    super.initState();
  }

  // double totalAmount = 0.0;

  @override
  Widget build(BuildContext context) {
    // Timer(Duration(seconds: 5),(){
    //
    // });
    // for(int i = 0; i< _getCartModel.data.length; i++){
    //   setState((){
    //     totalAmount = totalAmount + (double.parse("${_getCartModel.data[i].price}"))*(double.parse("${_getCartModel.data[i].quantity}"));
    //   });
    //
    // }
    return _getCartModel != null
        ? (_getCartModel.data.isNotEmpty)
            ? Scaffold(
                appBar: AppBar(
                  title: Text("CART"),
                  backgroundColor: Colors.blueAccent,
                ),
                bottomNavigationBar: (
                    // !widget.fromCheckout && !cart.isLoading)
                    // ?
                    Container(
                  height: 80,
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.PADDING_SIZE_LARGE,
                      vertical: Dimensions.PADDING_SIZE_DEFAULT),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10)),
                  ),
                  child:
                      // cartList.isNotEmpty ?
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                        Expanded(
                            child: Center(
                                child: Row(
                          children: [
                            Text(
                              "Total Price",
                              style: titilliumSemiBold.copyWith(
                                  fontSize: Dimensions.FONT_SIZE_DEFAULT),
                            ),
                            Text(
                              _getCartModel.totalPrice.toString(),
                              style: titilliumSemiBold.copyWith(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: Dimensions.FONT_SIZE_LARGE),
                            ),
                          ],
                        ))),
                        Builder(
                          builder: (context) => InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => CheckoutScreen(
                                            getCartModel: _getCartModel,
                                            sellerId: int.parse(_getCartModel.data[0].sellerId),
                                            // cartList: cartList,totalOrderAmount: amount,shippingFee: shippingAmount, discount: discount,
                                            // tax: tax,
                                          )));
                              // print('===asd=>${orderTypeShipping.length}');
                              // if (Provider.of<AuthProvider>(context, listen: false).isLoggedIn()) {
                              //   if (cart.cartList.length == 0) {
                              //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(getTranslated('select_at_least_one_product', context)), backgroundColor: Colors.red,));
                              //   } else if(cart.chosenShippingList.length < orderTypeShipping.length &&
                              //       Provider.of<SplashProvider>(context,listen: false).configModel.shippingMethod =='sellerwise_shipping'){
                              //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(getTranslated('select_all_shipping_method', context)), backgroundColor: Colors.red));
                              //   }else if(cart.chosenShippingList.length < 1 &&
                              //       Provider.of<SplashProvider>(context,listen: false).configModel.shippingMethod !='sellerwise_shipping' && Provider.of<SplashProvider>(context,listen: false).configModel.inHouseSelectedShippingType =='order_wise'){
                              //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(getTranslated('select_all_shipping_method', context)), backgroundColor: Colors.red));
                              //   }
                              //
                              //
                              //   else {
                              //
                              //     Navigator.push(context, MaterialPageRoute(builder: (_) => CheckoutScreen(
                              //       cartList: cartList,totalOrderAmount: amount,shippingFee: shippingAmount, discount: discount,
                              //       tax: tax,
                              //     )));
                              //
                              //   }
                              // } else {showAnimatedDialog(context, GuestDialog(), isFlip: true);}
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width / 3.5,
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(
                                    Dimensions.PADDING_SIZE_SMALL),
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: Dimensions.PADDING_SIZE_SMALL,
                                      vertical: Dimensions.FONT_SIZE_SMALL),
                                  child: Text('checkout',
                                      style: titilliumSemiBold.copyWith(
                                        fontSize: Dimensions.FONT_SIZE_DEFAULT,
                                        color: Theme.of(context).cardColor,
                                      )),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]),
                )),
                body: Column(children: [
                  //CustomAppBar(title: 'CART'),

                  // cart.isXyz ? Padding(
                  //   padding: const EdgeInsets.only(top: 200.0),
                  //   child: Center(child: CircularProgressIndicator(
                  //     valueColor: new AlwaysStoppedAnimation<Color>(
                  //       Theme.of(context).primaryColor,
                  //     ),
                  //   ),
                  //   ),
                  // ) :sellerList.length != 0 ?
                  _getCartModel.data != null
                      ? Expanded(
                          child: Container(
                            child: Column(
                              children: [
                                Expanded(
                                  child: RefreshIndicator(
                                      onRefresh: () async {
                                        // if(Provider.of<AuthProvider>(context, listen: false).isLoggedIn()) {
                                        //   await Provider.of<CartProvider>(context, listen: false).getCartDataAPI(context);
                                        // }
                                      },
                                      child: ListView.builder(
                                          itemCount: _getCartModel.data.length,
                                          padding: EdgeInsets.all(0),
                                          itemBuilder: (context, index) {
                                            return CartWidget(
                                              cartModel: _getCartModel,
                                              index: index,
                                              fromCheckout: false,
                                              deleteCart: () {
                                                removeCart(_getCartModel
                                                    .data[index].id);

                                              },
                                              updateCart: () => getCarts(),
                                            );
                                          })
                                      // child: ListView.builder(
                                      //   itemCount: _getCartModel.length,
                                      //   padding: EdgeInsets.all(0),
                                      //   itemBuilder: (context, index) {
                                      //
                                      //     return Padding(
                                      //       padding: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_SMALL),
                                      //       child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                      //           children: [
                                      //             // sellerGroupList[index].shopInfo.isNotEmpty ?
                                      //             Padding(
                                      //               padding: const EdgeInsets.all(8.0),
                                      //               child: Text('sellerGroupList[index].shopInfo',
                                      //                   textAlign: TextAlign.end, style: titilliumSemiBold.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE,
                                      //                   )),
                                      //             ) ,
                                      //                 // : SizedBox(),
                                      //             Card(
                                      //               child: Container(
                                      //                 padding: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_LARGE),
                                      //                 decoration: BoxDecoration(color: Theme.of(context).highlightColor,
                                      //                 ),
                                      //                 child: Column(
                                      //                   children: [
                                      //                     ListView.builder(
                                      //                       physics: NeverScrollableScrollPhysics(),
                                      //                       shrinkWrap: true,
                                      //                       padding: EdgeInsets.all(0),
                                      //                       itemCount: 2,
                                      //                       itemBuilder: (context, i) {
                                      //                         return CartWidget(
                                      //                           // cartModel: cartProductList[index][i],
                                      //                           index: 1,
                                      //                           fromCheckout: false,
                                      //                         );
                                      //                       },
                                      //                     ),
                                      //
                                      //                     //Provider.of<SplashProvider>(context,listen: false).configModel.shippingMethod =='sellerwise_shipping'?
                                      //                     // Provider.of<SplashProvider>(context,listen: false).configModel.shippingMethod =='sellerwise_shipping' && sellerGroupList[index].shippingType =='order_wise'?
                                      //                     Padding(
                                      //                       padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                                      //                       child: InkWell(
                                      //                         onTap: () {
                                      //                           // if(
                                      //                           // Provider.of<AuthProvider>(context, listen: false).isLoggedIn()) {
                                      //                             showModalBottomSheet(
                                      //                               context: context, isScrollControlled: true, backgroundColor: Colors.transparent,
                                      //                               builder: (context) => ShippingMethodBottomSheet(sellerIndex: index),
                                      //                             );
                                      //                           // }else {
                                      //                             // showCustomSnackBar('not_logged_in', context);
                                      //                           // }
                                      //                         },
                                      //
                                      //
                                      //                         child: Container(
                                      //                           decoration: BoxDecoration(
                                      //                             border: Border.all(width: 0.5,color: Colors.grey),
                                      //                             borderRadius: BorderRadius.all(Radius.circular(10)),
                                      //                           ),
                                      //                           child: Padding(
                                      //                             padding: const EdgeInsets.all(8.0),
                                      //                             child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                      //                               Text('SHIPPING_PARTNER', style: titilliumRegular),
                                      //                               Flexible(
                                      //                                 child: Text("61257312",
                                      //                                   // (cart.shippingList == null || cart.shippingList[index].shippingMethodList == null || cart.chosenShippingList.length == 0 || cart.shippingList[index].shippingIndex == -1) ? ''
                                      //                                   //   : '${cart.shippingList[index].shippingMethodList[cart.shippingList[index].shippingIndex].title.toString()}',
                                      //                                   style: titilliumSemiBold.copyWith(color: Theme.of(context).primaryColor),
                                      //                                   maxLines: 1,
                                      //                                   overflow: TextOverflow.ellipsis,textAlign: TextAlign.end,
                                      //                                 ),
                                      //                               ),
                                      //                               SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                      //                               Icon(Icons.keyboard_arrow_down, color: Theme.of(context).primaryColor),
                                      //                             ]),
                                      //                           ),
                                      //                         ),
                                      //                       )
                                      //                       ,
                                      //                     ) ,
                                      //                   ],
                                      //                 ),
                                      //               ),
                                      //             ),
                                      //           ]),
                                      //     );
                                      //   },
                                      // ),
                                      ),
                                ),
                                // Provider.of<SplashProvider>(context,listen: false).configModel.shippingMethod !='sellerwise_shipping' && Provider.of<SplashProvider>(context,listen: false).configModel.inHouseSelectedShippingType =='order_wise'?

                                // InkWell(
                                //   onTap: () {
                                //     // if(
                                //     // // Provider.of<AuthProvider>(context, listen: false).isLoggedIn()) {
                                //     //   showModalBottomSheet(
                                //     //     context: context, isScrollControlled: true, backgroundColor: Colors.transparent,
                                //     //     builder: (context) => ShippingMethodBottomSheet(groupId: 'all_cart_group',sellerIndex: 0, sellerId: 1),
                                //     //   );
                                //     // }else {
                                //     //   showCustomSnackBar('not_logged_in', context);
                                //     // }
                                //   },
                                //   child: Container(
                                //     decoration: BoxDecoration(
                                //       border: Border.all(width: 0.5, color: Colors.grey),
                                //       borderRadius: BorderRadius.all(Radius.circular(10)),
                                //     ),
                                //     child: Padding(
                                //       padding: const EdgeInsets.all(8.0),
                                //       child: Row(
                                //           mainAxisAlignment:
                                //               MainAxisAlignment.spaceBetween,
                                //           children: [
                                //             Text('SHIPPING_PARTNER',
                                //                 style: titilliumRegular),
                                //             Row(
                                //                 mainAxisAlignment: MainAxisAlignment.end,
                                //                 children: [
                                //                   Text(
                                //                     "",
                                //                     // (cart.shippingList == null ||cart.chosenShippingList.length == 0 || cart.shippingList.length==0 || cart.shippingList[0].shippingMethodList == null ||  cart.shippingList[0].shippingIndex == -1) ? ''
                                //                     //     : '${cart.shippingList[0].shippingMethodList[cart.shippingList[0].shippingIndex].title.toString()}',
                                //                     style: titilliumSemiBold.copyWith(
                                //                         color: Theme.of(context)
                                //                             .primaryColor),
                                //                     maxLines: 1,
                                //                     overflow: TextOverflow.ellipsis,
                                //                   ),
                                //                   SizedBox(
                                //                       width: Dimensions
                                //                           .PADDING_SIZE_EXTRA_SMALL),
                                //                   Icon(Icons.keyboard_arrow_down,
                                //                       color:
                                //                           Theme.of(context).primaryColor),
                                //                 ]),
                                //           ]),
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        )
                      : Image.asset('assets/images/no_data.png')
                  // :Expanded(child: NoInternetOrDataScreen(isNoInternet: false)),
                ]),
              )
            : Scaffold(
                appBar: AppBar(
                  automaticallyImplyLeading: true,
                  title: Text("CART"),
                  backgroundColor: Colors.blueAccent,
                ),
                body: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(image: AssetImage(Images.no_data_found)),
                      Text("Add products to cart", style: titilliumBold.copyWith(
                        fontSize: Dimensions.FONT_SIZE_OVER_LARGE
                      ),)
                    ],
                  ),
                ))
        : Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text("CART "),
        backgroundColor: Colors.blueAccent,
      ),
        body: Center(
              child: Text(
                "Login first",
                style: TextStyle(fontSize: 20),
              ),
            ),
        );
  }
}
