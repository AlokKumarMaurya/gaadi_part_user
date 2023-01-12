import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gaadi_part/data/model/response/Order/order_placed.dart';
import 'package:gaadi_part/helper/shared_preference.dart';
import 'package:gaadi_part/utill/app_constants.dart';
import 'package:gaadi_part/view/Screen/checkout/checkout_controller.dart';
import 'package:gaadi_part/view/Screen/checkout/widget/custom_check_box.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../data/DAshboard Repository/dashboadRepository.dart';
import '../../../data/model/body/userInfoModal.dart';
import '../../../data/model/response/Order/order_confirmed_response_model.dart';
import '../../../data/model/response/cart/get_cart_model.dart';
import '../../../utill/custom_themes.dart';
import '../../../utill/dimensions.dart';
import '../../../utill/images.dart';
import '../../baseWidget/amount_widget.dart';
import '../../baseWidget/animated_custom_dialog.dart';
import '../../baseWidget/custom_app_bar.dart';
import '../../baseWidget/my_dialog.dart';
import '../../baseWidget/textField/custom_textfield.dart';
import '../dashboard/dashboard_screen.dart';
import '../order/order_details_screen.dart';
import '../order/order_screen.dart';
import '../payment/payment_screen.dart';
import 'editAddress.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class CheckoutScreen extends StatefulWidget {
  // final List<CartModel> cartList;
  final GetCartModel getCartModel;
  final bool fromProductDetails;
  final double totalOrderAmount;
  final double shippingFee;
  final double discount;
  final double tax;
  final int sellerId;

  CheckoutScreen(
      {this.fromProductDetails = false,
      @required this.discount,
      @required this.tax,
      @required this.totalOrderAmount,
      @required this.shippingFee,
      this.sellerId,
      this.getCartModel});

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _checkoutController = Get.put(CheckOutController());
  OrderPlaced _orderPlaced = OrderPlaced();
  OrderConfirmedModel _orderConfirmedModel = OrderConfirmedModel();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _orderNoteController = TextEditingController();
  final FocusNode _orderNoteNode = FocusNode();
  bool oneTimeAdd = true;
  UserInfo userinfo;
  bool isLoading = true;
  var isCodSelected = true;
  var isOnlineSelected = false;
    double total_payment_amount=0;
  getUserInfo() async {
    var userinfoResponse = await DashboardApiClient().MoreUserInfo();
    if (userinfoResponse != null) {
      setState(() {
        userinfo = userinfoResponse;
        isLoading = false;
      });
      if (!_checkoutController.Address.contains(
          "${userinfo.data[0].address},${userinfo.data[0].city},${userinfo.data[0].country},${userinfo.data[0].postalCode},${userinfo.data[0].phone}")) {
        _checkoutController.addAddress(
            "${userinfo.data[0].address},${userinfo.data[0].city},${userinfo.data[0].country},${userinfo.data[0].postalCode},${userinfo.data[0].phone}");
      }
      _checkoutController.updateShippingAddress(
          "${userinfo.data[0].address},${userinfo.data[0].city},${userinfo.data[0].country},${userinfo.data[0].postalCode},${userinfo.data[0].phone}");
      return userinfo;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(userinfo.toString()),
        backgroundColor: Colors.red,
      ));
    }
  }

  Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
    print("Payment Success");
    var userId = await HelperFunction.getUserId();
    Map dataONLINE = {
      'id': userId,
      'payment_option': 'RazorPay',
      'owner_id': '${widget.sellerId}'
    };

    try {
      var response = await DashboardApiClient().placedOrder(dataONLINE);
      if (response != null) {
        setState(() {
          _orderPlaced = response;
        });
        orderConfirmed();
        EasyLoading.dismiss();
      }
    } finally {
      EasyLoading.dismiss();
    }

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Payment done")));
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    print("Payment fails");
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Payment fail")));
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
    print("External wallet selected");
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Payment external wallet selected")));
  }









  placedOrder() async {
    EasyLoading.show(status: 'loading...');
    var userId = await HelperFunction.getUserId();

    Map dataCOD = {
      'id': userId,
      'payment_option': 'cash_on_delivery',
      'owner_id': '${widget.sellerId}'
    };



    print(dataCOD);
    if (!isOnlineSelected) {
      print("-090909090909-09080978392878931809270721");
      try {
        var response = await DashboardApiClient().placedOrder(dataCOD);
        if (response != null) {
          setState(() {
            _orderPlaced = response;
          });
          orderConfirmed();
          EasyLoading.dismiss();
        }
      } finally {
        EasyLoading.dismiss();
      }
    } else {
      print("jklsbdcsADAFHLSBDJHGSJCVAGDGSXCDJHSADVFEGVHJJH");
      var _razorpay = Razorpay();
      _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
      _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
      _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

      var options = {
        'key': 'rzp_live_oMPWVCB4JuTQSo',
        'amount': total_payment_amount * 100,
        'name': 'Gaddi Part',
        'description': ' ',
        'prefill': {'contact': '${userinfo.data[0].name}', 'email': '${userinfo.data[0].email}'}
      };
      _razorpay.open(options);
      EasyLoading.dismiss();
    }
  }

  FutureOr<OrderConfirmedModel> orderConfirmed() async {
    var api = await Uri.parse(
        AppConstants.ORDER_CONFIRMED_URI + _orderPlaced.orderId.toString());
    print("111111111111111111111111=============");
    try {
      var response = await http.get(api);
      print(response.body);
      if (response.statusCode == 200) {
        showAnimatedDialog(
            context,
            MyDialog(
              icon: Icons.done,
              title: 'Order Placed ',
              description:
                  'Successfully palced order you can close the app now',
            ),
            dismissible: true,
            isFlip: true);
        // Navigator.push(context, MaterialPageRoute(builder: (_)=> OrderScreen()));
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    getUserInfo();
    super.initState();
    // Provider.of<ProfileProvider>(context, listen: false).initAddressList(context);
    // Provider.of<ProfileProvider>(context, listen: false).initAddressTypeList(context);
    // Provider.of<CouponProvider>(context, listen: false).removePrevCouponData();
    // Provider.of<CartProvider>(context, listen: false).getCartDataAPI(context);
    // Provider.of<CartProvider>(context, listen: false).getChosenShippingMethod(context);
    // _digitalPayment = Provider.of<SplashProvider>(context, listen: false).configModel.digitalPayment;
    // _cod = Provider.of<SplashProvider>(context, listen: false).configModel.cod;
    // _billingAddress = Provider.of<SplashProvider>(context, listen: false).configModel.billingAddress == 1;
  }

  @override
  Widget build(BuildContext context) {
    // _order = widget.totalOrderAmount+widget.discount;
    double sub_total = 0.0;
    double discount = 0.0;
    double tax = 0.0;
    double coupon_voucher = 0.0;
    double shipping_fee = 60;
    for (int i = 0; i < widget.getCartModel.data.length; i++) {
      sub_total = sub_total +
          double.parse("${widget.getCartModel.data[i].price}") *
              double.parse("${widget.getCartModel.data[i].quantity}");
      discount =
          discount + double.parse("${widget.getCartModel.data[i].discount}");
      tax = tax + double.parse("${widget.getCartModel.data[i].tax}");
    }

    double total_pay =total_payment_amount=
        sub_total + discount + tax + coupon_voucher + shipping_fee;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      key: _scaffoldKey,
      bottomNavigationBar: Container(
        height: 60,
        padding: EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_LARGE,
            vertical: Dimensions.PADDING_SIZE_DEFAULT),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
        ),
        child: Center(
            child: Builder(
          builder: (context) => InkWell(
            onTap: () async {
              placedOrder();
              // (Navigator.pushReplacement(
              //     context,
              //     MaterialPageRoute(
              //         builder: (_) => PaymentScreen(
              //           // customerID: userID,
              //           // addressID: Provider.of<ProfileProvider>(context, listen: false).addressList[Provider.of<OrderProvider>(context, listen: false).addressIndex].id.toString(),
              //           // couponCode: Provider.of<CouponProvider>(context, listen: false).discount != null ? Provider.of<CouponProvider>(context, listen: false).coupon.code : '',
              //           // billingId: _billingAddress? Provider.of<ProfileProvider>(context, listen: false).billingAddressList[Provider.of<OrderProvider>(context, listen: false).billingAddressIndex].id.toString():
              //           // Provider.of<ProfileProvider>(context, listen: false).addressList[Provider.of<OrderProvider>(context, listen: false).addressIndex].id.toString(),
              //           // orderNote: orderNote,
              //
              //         ))));
            },
            child: Text('proceed',
                style: titilliumSemiBold.copyWith(
                  fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                  color: Theme.of(context).cardColor,
                )),
          ),
        )),
      ),
      body: Column(
        children: [
          CustomAppBar(title: 'checkout'),
          Expanded(
            child: ListView(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.all(0),
                children: [
                  // Shipping Details
                  Container(
                    padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Card(
                            child: Container(
                              padding: EdgeInsets.all(
                                  Dimensions.PADDING_SIZE_DEFAULT),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    Dimensions.PADDING_SIZE_DEFAULT),
                                color: Theme.of(context).cardColor,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                          child: Text('Shipping address',
                                              style: titilliumBold.copyWith(
                                                  fontSize: Dimensions
                                                      .FONT_SIZE_LARGE))),
                                      InkWell(
                                        onTap: () => {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      EditAddress(
                                                          name: userinfo
                                                              .data[0].name,
                                                          id: userinfo
                                                              .data[0].id
                                                              .toString(),
                                                          email: userinfo
                                                              .data[0].email,
                                                          phone: userinfo
                                                              .data[0].phone,
                                                          address: userinfo
                                                              .data[0].address,
                                                          country: userinfo
                                                              .data[0].country,
                                                          city:
                                                              userinfo.data[0]
                                                                  .city,
                                                          postal: userinfo
                                                              .data[0]
                                                              .postalCode)))
                                        },
                                        // Navigator.of(context).push(
                                        // MaterialPageRoute(builder: (BuildContext context) => SavedAddressListScreen())),
                                        child: Image.asset(Images.address,
                                            scale: 3),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: Dimensions.PADDING_SIZE_DEFAULT,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Container(
                                      //   child: Text(
                                      //     // Provider.of<OrderProvider>(context,listen: false).addressIndex == null ?
                                      //     // '${getTranslated(
                                      //     'address_type',
                                      //     //     , context)}'
                                      //     //     : Provider.of<ProfileProvider>(context, listen: false).addressList[
                                      //     // Provider.of<OrderProvider>(context, listen: false).addressIndex].addressType,
                                      //     style: titilliumBold.copyWith(
                                      //         fontSize:
                                      //             Dimensions.FONT_SIZE_LARGE),
                                      //     maxLines: 3,
                                      //     overflow: TextOverflow.fade,
                                      //   ),
                                      // ),
                                      Divider(),
                                      Container(
                                        child: userinfo != null
                                            ? Obx(() => userinfo.data.isNotEmpty
                                                ? Text(
                                                    _checkoutController
                                                        .shippingAddress.value
                                                        .toString(),
                                                    style: titilliumRegular
                                                        .copyWith(
                                                            fontSize: Dimensions
                                                                .FONT_SIZE_LARGE),
                                                    maxLines: 3,
                                                    overflow: TextOverflow.fade,
                                                  )
                                                : Text(''))
                                            : Text(""),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),

                          SizedBox(
                            height: Dimensions.PADDING_SIZE_SMALL,
                          ),
                          // _billingAddress?
                          // Card(
                          //   child: Container(
                          //     padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                          //     decoration: BoxDecoration(
                          //       borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_DEFAULT),
                          //       color: Theme.of(context).cardColor,
                          //     ),
                          //     child: Column(crossAxisAlignment:CrossAxisAlignment.start,
                          //       children: [
                          //         Row(mainAxisAlignment:MainAxisAlignment.start, crossAxisAlignment:CrossAxisAlignment.start,
                          //           children: [
                          //             Expanded(child: Text('billing_address',
                          //                 style: titilliumRegular.copyWith(fontWeight: FontWeight.w600))),
                          //
                          //
                          //             InkWell(
                          //               onTap: () => {},
                          //                   // Navigator.of(context).push(MaterialPageRoute(
                          //                   // builder: (BuildContext context) => SavedBillingAddressListScreen())),
                          //               child: Image.asset(Images.address, scale: 3),
                          //             ),
                          //           ],
                          //         ),
                          //         SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),
                          //         Column(crossAxisAlignment: CrossAxisAlignment.start,
                          //           children: [
                          //             Container(
                          //               child: Text(
                          //                 // Provider.of<OrderProvider>(context).billingAddressIndex == null ? '${getTranslated(
                          //                     'address_type',
                          //                 //     context)}'
                          //                 //     : Provider.of<ProfileProvider>(context, listen: false).billingAddressList[
                          //                 // Provider.of<OrderProvider>(context, listen: false).billingAddressIndex].addressType,
                          //                 style: titilliumBold.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE),
                          //                 maxLines: 1, overflow: TextOverflow.fade,
                          //               ),
                          //             ),
                          //             Divider(),
                          //             Container(
                          //               child: Text(
                          //                 // Provider.of<OrderProvider>(context).billingAddressIndex == null ? getTranslated(
                          //                     'add_your_address',
                          //                 //     context)
                          //                 //     : Provider.of<ProfileProvider>(context, listen: false).billingAddressList[
                          //                 // shipping.billingAddressIndex].address,
                          //                 style: titilliumRegular.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL),
                          //                 maxLines: 3, overflow: TextOverflow.fade,
                          //               ),
                          //             ),
                          //           ],
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // )
                          // :SizedBox(),
                        ]),
                  ),
                  SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                  // Order Details
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                    child: Text(
                      'ORDER_DETAILS',
                      style: robotoBold.copyWith(
                          fontSize: Dimensions.FONT_SIZE_LARGE),
                    ),
                  ),
                  Container(
                    transform: Matrix4.translationValues(0.0, -30.0, 0.0),
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: widget.getCartModel.data.length,
                        itemBuilder: (ctx, index) {
                          return Padding(
                            padding:
                                EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                            child: Row(children: [
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: .5,
                                      color: Theme.of(context)
                                          .primaryColor
                                          .withOpacity(.25)),
                                  borderRadius: BorderRadius.circular(Dimensions
                                      .PADDING_SIZE_EXTRA_EXTRA_SMALL),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(Dimensions
                                      .PADDING_SIZE_EXTRA_EXTRA_SMALL),
                                  child: FadeInImage.assetNetwork(
                                    placeholder: Images.placeholder,
                                    fit: BoxFit.cover,
                                    width: 50,
                                    height: 50,
                                    image:
                                        "${widget.getCartModel.data[index].thumbnail}",
                                    imageErrorBuilder: (c, o, s) => Image.asset(
                                        Images.placeholder,
                                        fit: BoxFit.cover,
                                        width: 50,
                                        height: 50),
                                  ),
                                ),
                              ),
                              SizedBox(width: Dimensions.MARGIN_SIZE_DEFAULT),
                              Expanded(
                                flex: 3,
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              widget.getCartModel.data[index]
                                                  .name,
                                              style: titilliumRegular.copyWith(
                                                  fontSize: Dimensions
                                                      .FONT_SIZE_DEFAULT,
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          SizedBox(
                                            width:
                                                Dimensions.PADDING_SIZE_SMALL,
                                          ),
                                          Text(
                                            widget.getCartModel.data[index]
                                                .quantity,
                                            style: titilliumSemiBold.copyWith(
                                                fontSize:
                                                    Dimensions.FONT_SIZE_LARGE),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                          height: Dimensions
                                              .MARGIN_SIZE_EXTRA_SMALL),
                                      Row(children: [
                                        Text(
                                            "${double.parse(widget.getCartModel.data[index].price) * double.parse(widget.getCartModel.data[index].quantity)}",
                                            style: titilliumRegular.copyWith()),
                                      ]),
                                    ]),
                              ),
                            ]),
                          );
                        }),
                  ),
                  // Coupon
                  // Padding(
                  //   padding: const EdgeInsets.only(left:Dimensions.PADDING_SIZE_DEFAULT,right:Dimensions.PADDING_SIZE_DEFAULT,
                  //       bottom: Dimensions.PADDING_SIZE_DEFAULT),
                  //   child: Container(height: 50,
                  //     width: MediaQuery.of(context).size.width,
                  //     decoration: BoxDecoration(
                  //         color: Color(0xFFC8E4FF).withOpacity(.5),
                  //         borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  //         border: Border.all(width: .5, color: Theme.of(context).primaryColor.withOpacity(.9))
                  //     ),
                  //     child: Row(children: [
                  //       Expanded(
                  //         child: SizedBox(
                  //           height: 50,
                  //           child: Padding(
                  //             padding: const EdgeInsets.only(left: Dimensions.PADDING_SIZE_SMALL,bottom: 5),
                  //             child: Center(
                  //               child: TextField(controller: _controller, decoration: InputDecoration(
                  //                 hintText: 'Have a coupon?',
                  //                 hintStyle: titilliumRegular.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT),
                  //                 filled: false,
                  //                 fillColor: Color(0xFFF9F9F9),
                  //                 border: InputBorder.none,
                  //               )),
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //       SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                  //       // !Provider.of<CouponProvider>(context).isLoading ?
                  //       InkWell(
                  //         onTap: () {
                  //           // if(_controller.text.isNotEmpty) {
                  //           //   Provider.of<CouponProvider>(context, listen: false).initCoupon(_controller.text, _order).then((value) {
                  //           //     if(value > 0) {
                  //                 ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:
                  //                 Text('You got 300 discount'), backgroundColor: Colors.green));
                  //           //     }else {
                  //           //       _controller.clear();
                  //           //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  //           //         content: Text(getTranslated('invalid_coupon_or', context)),
                  //           //         backgroundColor: Colors.red,
                  //           //       ));
                  //           //     }
                  //           //   });
                  //           // }
                  //         },
                  //         child: Container(width: 100,height: 60,
                  //             decoration: BoxDecoration(
                  //                 color: Theme.of(context).primaryColor,
                  //                 borderRadius: BorderRadius.only(bottomRight: Radius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  //                     topRight: Radius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL))
                  //
                  //             ),
                  //             child: Center(child: Text('APPLY',
                  //               style: titleRegular.copyWith(color: Theme.of(context).cardColor, fontSize: Dimensions.FONT_SIZE_LARGE),
                  //             ))),
                  //       )
                  //           // : CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor)),
                  //     ]),
                  //   ),
                  // ),

                  SizedBox(
                    height: Dimensions.PADDING_SIZE_SMALL,
                  ),

                  Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(.055),
                    ),
                    child: Center(
                        child: Text(
                      // getTranslated(
                      'order_summary',
                      // , context),
                      style: titilliumSemiBold.copyWith(
                          fontSize: Dimensions.FONT_SIZE_LARGE),
                    )),
                  ),
                  // Total bill
                  Container(
                      margin:
                          EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
                      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                      color: Theme.of(context).highlightColor,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AmountWidget(
                                title: 'sub_total',
                                amount: sub_total.toString()),
                            AmountWidget(
                                title: 'SHIPPING_FEE',
                                amount: shipping_fee.toString()),
                            AmountWidget(
                                title: 'DISCOUNT', amount: discount.toString()),
                            AmountWidget(
                                title: 'coupon_voucher',
                                amount: coupon_voucher.toString()),
                            AmountWidget(title: 'TAX', amount: tax.toString()),
                            Divider(
                                height: 5, color: Theme.of(context).hintColor),
                            AmountWidget(
                                title: 'TOTAL_PAYABLE',
                                amount: total_pay.toString()),
                          ])),

                  // Payment Method
                  Container(
                    height: 100,
                    margin: EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
                    padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                    color: Theme.of(context).highlightColor,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'payment_method',
                            style: titilliumSemiBold.copyWith(
                                fontSize: Dimensions.FONT_SIZE_LARGE),
                          ),
                          SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                          Expanded(
                              child: Row(
                            children: [
                              //Text(getTranslated('payment_method', context), style: titilliumSemiBold.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE),),
                              // _cod?
                              Text("COD"),
                              Checkbox(
                                checkColor: Colors.white,
                                //fillColor: Colors.blueAccent,
                                value: isCodSelected,
                                onChanged: (bool value) {
                                  setState(() {
                                    isCodSelected = value;
                                    isOnlineSelected = !value;
                                  });
                                },
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              // :  SizedBox(),
                              // _digitalPayment ?
                              Text("Razor Pay"),
                              Container(
                                  child: Checkbox(
                                checkColor: Colors.white,
                                //fillColor: Colors.blueAccent,
                                value: isOnlineSelected,
                                onChanged: (bool value) {
                                  setState(() {
                                    isOnlineSelected = value;
                                    isCodSelected = !value;
                                  });
                                },
                              ))
                              // : SizedBox(),
                            ],
                          )),
                          // _cod? CustomCheckBox(title: getTranslated('cash_on_delivery', context), index: 0):  SizedBox(),
                          // _digitalPayment ? CustomCheckBox(title: getTranslated('digital_payment', context), index: !_cod ? 0 : 1) : SizedBox(),
                        ]),
                  ),

                  // Container(
                  //   margin: EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
                  //   padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                  //   color: Theme.of(context).highlightColor,
                  //   child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //     Row(
                  //       children: [
                  //         Text(
                  //           'order_note',
                  //           style: robotoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE),),
                  //         Text(
                  //           'extra_inst',
                  //           style: robotoRegular.copyWith(color: Color(0xFF9E9E9E),),
                  //         )],
                  //     ),
                  //     SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                  //     CustomTextField(
                  //       hintText: 'enter_note',
                  //       textInputType: TextInputType.multiline,
                  //       textInputAction: TextInputAction.done,
                  //       maxLine: 3,
                  //       focusNode: _orderNoteNode,
                  //       controller: _orderNoteController,
                  //     ),
                  //   ]),
                  // ),
                ]),
          ),
        ],
      ),
    );
  }

// void _callback(bool isSuccess, String message, String orderID, List<CartModel> carts) async {
//   if(isSuccess) {
//     Provider.of<ProductProvider>(context, listen: false).getLatestProductList(1, context, reload: true,);
//     if(Provider.of<OrderProvider>(context, listen: false).paymentMethodIndex == 0) {
//       Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => DashBoardScreen()), (route) => false);
//       showAnimatedDialog(context, MyDialog(
//         icon: Icons.check,
//         title: getTranslated('order_placed', context),
//         description: getTranslated('your_order_placed', context),
//         isFailed: false,
//       ), dismissible: false, isFlip: true);
//     }else {
//
//     }
//     Provider.of<OrderProvider>(context, listen: false).stopLoader();
//   }else {
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message), backgroundColor: ColorResources.RED));
//   }
// }
}

class PaymentButton extends StatelessWidget {
  final String image;
  final Function onTap;

  PaymentButton({@required this.image, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 45,
        margin: EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(width: 2, color: Color(0xFFF1F1F1)),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Image.asset(image),
      ),
    );
  }
}
