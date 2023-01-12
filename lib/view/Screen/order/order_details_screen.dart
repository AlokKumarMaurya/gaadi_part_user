import 'package:flutter/material.dart';
import 'package:gaadi_part/view/Screen/order/widget/order_details_widget.dart';
import 'package:provider/provider.dart';

import '../../../data/model/response/Order/order_list_response.dart';
import '../../../helper/date_converter.dart';
import '../../../utill/custom_themes.dart';
import '../../../utill/dimensions.dart';
import '../../baseWidget/amount_widget.dart';
import '../../baseWidget/botton/custom_button.dart';
import '../../baseWidget/show_custom_snakbar.dart';
import '../../baseWidget/title_row.dart';
import '../dashboard/dashboard_screen.dart';
import '../payment/payment_screen.dart';
import '../seller/seller_screen.dart';

class OrderDetailsScreen extends StatelessWidget {
  final bool isNotification;
  final List<OrderListModel> orderModel;
  final int index;
  // final OrderModel orderModel;
  final int orderId;
  final String orderType;
  final double extraDiscount;
  final String extraDiscountType;

  OrderDetailsScreen({
    // @required this.orderModel,
    @required this.orderId,
    @required this.orderType,
    this.extraDiscount,
    this.extraDiscountType, this.isNotification = false, this.orderModel, this.index});

  @override
  Widget build(BuildContext context) {
    // _loadData(context);
    return WillPopScope(
      onWillPop: () async {
        isNotification ?
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => DashBoardScreen())) : Navigator
            .pop(context);
        return true;
      },
      child: Scaffold(
        backgroundColor: Color(0xFFF9F9F9),
        appBar: AppBar(iconTheme: IconThemeData(color: Color(0xFF000743)),
          backgroundColor: Theme
              .of(context)
              .cardColor,
          leading: InkWell(
              onTap: () {
                isNotification
                    ?
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) => DashBoardScreen()))
                    : Navigator.pop(context);
              },
              child: Icon(Icons.keyboard_backspace)),
          title: Text('ORDER_DETAILS'),),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //CustomAppBar(title: getTranslated('ORDER_DETAILS', context)),
            Expanded(
              child: ListView(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.all(0),
                children: [
                  SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),
                  Container(
                    margin: EdgeInsets.symmetric(
                        vertical: Dimensions.PADDING_SIZE_DEFAULT,
                        horizontal: Dimensions.PADDING_SIZE_SMALL),
                    child: Row(
                      children: [RichText(text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(text: 'ORDER ID : ',
                              style: titilliumRegular.copyWith(
                                fontSize: Dimensions.FONT_SIZE_LARGE,
                                color: Theme
                                    .of(context)
                                    .textTheme
                                    .bodyText1
                                    .color,)),
                          TextSpan(text: orderModel[index].id.toString(),
                              style: titilliumRegular.copyWith(
                                  fontSize: Dimensions.FONT_SIZE_LARGE,
                                  color: Theme
                                      .of(context)
                                      .primaryColor)),
                        ],
                      ),
                      ),
                        Expanded(child: SizedBox()),


                        Text(DateConverter.localDateToIsoStringAMPM(
                            DateTime.parse(orderModel[index].createdAt.toString())),
                            style: titilliumRegular.copyWith(color: Color(
                                0xFF9E9E9E),
                                fontSize: Dimensions.FONT_SIZE_SMALL)),
                      ],
                    ),
                  ),

                  Container(
                    padding:
                    EdgeInsets.all(Dimensions.MARGIN_SIZE_SMALL),
                    decoration: BoxDecoration(color: Theme
                        .of(context)
                        .highlightColor),
                    child: Column(
                      children: [
                        // orderType == 'POS' ?
                        // Text('pos_order', context)):
                        Row(mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Text('SHIPPING TO : ',
                                  style: titilliumRegular.copyWith(
                                      fontSize: Dimensions.FONT_SIZE_DEFAULT)),

                              Expanded(child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 1),
                                child: Text(orderModel[index].shippingAddress.toString()),
                              )),

                            ]),
                        SizedBox(height: Dimensions.PADDING_SIZE_LARGE),


                        // orderModel !=null && orderModel.billingAddressData != null?


                        // Row(mainAxisAlignment: MainAxisAlignment.start,
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: [
                        //     Text('{getTranslated(',
                        //         style: titilliumRegular.copyWith(
                        //             fontSize: Dimensions.FONT_SIZE_DEFAULT)),
                        //     Expanded(child: Padding(
                        //       padding: const EdgeInsets.symmetric(vertical: 1),
                        //       child: Text(
                        //           ' {orderModel.billingAddressData != null ? orderModel.billingAddressData.address : ''}',
                        //           maxLines: 3,
                        //           overflow: TextOverflow.ellipsis,
                        //           style: titilliumRegular.copyWith(
                        //               fontSize: Dimensions.FONT_SIZE_SMALL)),
                        //     )),
                        //   ],
                        // ),

                        Divider(),
                      ],
                    ),
                  ),

                  // orderModel != null && orderModel.orderNote != null?
                  Padding(padding: EdgeInsets.all(Dimensions.MARGIN_SIZE_SMALL),
                    child: Text.rich(
                      TextSpan(children: [
                        TextSpan(text: 'order_note : ',
                            style: robotoBold.copyWith(
                                fontSize: Dimensions.FONT_SIZE_LARGE,
                                color: Color(0xFF66717C))),

                        TextSpan(
                            text: orderModel[index].orderNote.toString(),
                            style: titilliumRegular.copyWith(
                                fontSize: Dimensions.FONT_SIZE_SMALL)),
                      ],
                      ),
                    ),
                  ),
                  SizedBox(height: Dimensions.PADDING_SIZE_SMALL),


                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                        vertical: Dimensions.PADDING_SIZE_DEFAULT),
                    child: Text(
                        'ORDERED_PRODUCT', style: titilliumSemiBold.copyWith()),
                  ),


                  ListView.builder(
                    itemCount: 5,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.all(0),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.MARGIN_SIZE_EXTRA_LARGE),
                        color: Theme
                            .of(context)
                            .highlightColor,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  // if (Provider.of<SellerProvider>(context, listen: false).orderSellerList.length != 0 && sellerList[index] != 1) {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (_) {
                                        return SellerScreen();
                                      }));
                                  // }
                                },

                                child:
                                // sellerList[index] == 1? SizedBox():

                                InkWell(
                                  onTap: () {
                                    // Navigator.push(context, MaterialPageRoute(builder: (_) => ChatScreen(
                                    //   seller: Provider.of<SellerProvider>(context).orderSellerList[index],
                                    //   shopId:Provider.of<SellerProvider>(context).orderSellerList[index].seller.shop.id,
                                    //   shopName:Provider.of<SellerProvider>(context).orderSellerList[index].seller.shop.name,
                                    //   image: Provider.of<SellerProvider>(context).orderSellerList[index].seller.image )));
                                  },

                                  child: Row(children: [
                                    Expanded(child: Text(
                                        'seller', style: robotoBold)),

                                    Text("sqwsaq"
                                      //   sellerList[index] == 1 ? 'Admin' :
                                      // Provider.of<SellerProvider>(context).orderSellerList.length < index + 1 ?
                                      // sellerList[index].toString() :
                                      // '${Provider.of<SellerProvider>(context).orderSellerList[index].seller.fName} '
                                      //     '${Provider.of<SellerProvider>(context).orderSellerList[index].seller.lName}',
                                      //   style: titilliumRegular.copyWith(color: ColorResources.HINT_TEXT_COLOR),
                                    ),
                                    SizedBox(width: Dimensions
                                        .PADDING_SIZE_EXTRA_SMALL),
                                    Icon(Icons.chat, color: Theme
                                        .of(context)
                                        .primaryColor, size: 20),
                                  ]),
                                ),
                              ),
                              Divider(),


                              // ListView.builder(
                              //   shrinkWrap: true,
                              //   padding: EdgeInsets.all(0),
                              //   itemCount: 4,
                              //   // sellerProductList[index].length,
                              //   physics: NeverScrollableScrollPhysics(),
                              //   itemBuilder: (context, i) =>
                              //       OrderDetailsWidget(
                              //         callback: () {
                              //           showCustomSnackBar(
                              //               'Review submitted successfully',
                              //               context, isError: false);
                              //         },
                              //         orderType: orderType,),
                              // ),
                            ]),
                      );
                    },
                  ),
                  SizedBox(height: Dimensions.MARGIN_SIZE_DEFAULT),

                  // Amounts
                  Container(
                    padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                    color: Theme
                        .of(context)
                        .highlightColor,
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          TitleRow(title: 'TOTAL',),
                          AmountWidget(title: 'ORDER',
                              amount: "213"),


                          orderType == "POS" ? SizedBox() :
                          AmountWidget(title: 'SHIPPING_FEE',
                              amount: "312"),


                          AmountWidget(title: 'DISCOUNT',
                              amount: "231"),

                          AmountWidget(title: 'EXTRA_DISCOUNT',
                              amount: "123"),


                          AmountWidget(title: 'coupon_voucher',
                              amount: "323"),


                          AmountWidget(title: 'TAX',
                              amount: "546"),


                          Padding(
                            padding: EdgeInsets.symmetric(vertical: Dimensions
                                .PADDING_SIZE_EXTRA_SMALL),
                            child: Divider(height: 2, color: Color(
                                0xff9E9E9E)),),


                          AmountWidget(title: 'TOTAL_PAYABLE',
                              amount: "309"),
                        ]),
                  ),
                  SizedBox(height: Dimensions.MARGIN_SIZE_DEFAULT),


                  // order.trackingModel.deliveryMan != null?
                  Container(
                    padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                    decoration: BoxDecoration(color: Theme
                        .of(context)
                        .highlightColor),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Text('shipping_info', style: robotoBold),
                          SizedBox(height: Dimensions.MARGIN_SIZE_EXTRA_SMALL),


                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('delivery_man',
                                    style: titilliumRegular.copyWith(
                                        fontSize: Dimensions.FONT_SIZE_SMALL)),


                                Text("6546",
                                  style: titilliumRegular.copyWith(
                                      fontSize: Dimensions.FONT_SIZE_SMALL),),


                              ]),
                        ]),
                  ),
                  //third party
                  // order.trackingModel.thirdPartyServiceName != null?
                  Container(
                    padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                    decoration: BoxDecoration(color: Theme
                        .of(context)
                        .highlightColor),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('shipping_inf', style: robotoBold),
                          SizedBox(height: Dimensions.MARGIN_SIZE_EXTRA_SMALL),

                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('delivery_service_name ',
                                    style: titilliumRegular.copyWith(
                                        fontSize: Dimensions.FONT_SIZE_SMALL)),

                                Text('',
                                  style: titilliumRegular.copyWith(
                                      fontSize: Dimensions.FONT_SIZE_SMALL),
                                ),
                              ]),
                          SizedBox(height: Dimensions.MARGIN_SIZE_EXTRA_SMALL),


                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('tracking_id',
                                    style: titilliumRegular.copyWith(
                                        fontSize: Dimensions.FONT_SIZE_SMALL)),

                                Text('',
                                    style: titilliumRegular.copyWith(
                                      fontSize: Dimensions.FONT_SIZE_SMALL,
                                    )),
                              ]),
                        ]),
                  ),


                  SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),

                  // Payment
                  Container(
                    padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                    decoration: BoxDecoration(color: Theme
                        .of(context)
                        .highlightColor),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('PAYMENT', style: robotoBold),
                          SizedBox(height: Dimensions.MARGIN_SIZE_EXTRA_SMALL),
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('PAYMENT_STATUS',
                                    style: titilliumRegular.copyWith(
                                        fontSize: Dimensions.FONT_SIZE_SMALL)),

                                Text('Digital Payment',
                                  style: titilliumRegular.copyWith(
                                      fontSize: Dimensions.FONT_SIZE_SMALL),
                                ),
                              ]),
                          SizedBox(height: Dimensions.MARGIN_SIZE_EXTRA_SMALL),

                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('PAYMENT_PLATFORM',
                                    style: titilliumRegular.copyWith(
                                        fontSize: Dimensions.FONT_SIZE_SMALL)),

                                // (order.trackingModel.paymentMethod != 'cash_on_delivery' && order.trackingModel.paymentStatus == 'unpaid') ?
                                InkWell(onTap: () async {
                                  String userID = "2";
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(builder: (_) =>
                                          PaymentScreen(
                                            customerID: userID,
                                            couponCode: '',
                                            addressID: "2",
                                            billingId: "12",)));
                                },


                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: Dimensions
                                            .PADDING_SIZE_EXTRA_SMALL),
                                    decoration: BoxDecoration(color: Theme
                                        .of(context)
                                        .primaryColor,
                                      borderRadius: BorderRadius.circular(5),),


                                    child: Text(
                                        'pay_now', style: titilliumSemiBold
                                        .copyWith(fontSize: Dimensions
                                        .FONT_SIZE_EXTRA_SMALL,
                                      color: Theme
                                          .of(context)
                                          .highlightColor,)),),),
                                Text( 'Digital Payment',
                                    style: titilliumBold.copyWith(color: Theme
                                        .of(context)
                                        .primaryColor,
                                    )),
                              ]),
                        ]),
                  ),
                  SizedBox(height: Dimensions.PADDING_SIZE_SMALL),


                  Padding(padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.PADDING_SIZE_SMALL,
                      vertical: Dimensions.PADDING_SIZE_SMALL),
                    child: Row(
                      children: [
                        Expanded(child:
                        // orderModel != null &&
                        // orderModel.orderStatus =='pending' && orderType != "POS"?

                        // CustomButton(buttonText: getTranslated('cancel_order', context),
                        //     onTap: () => Provider.of<OrderProvider>(context,listen: false).cancelOrder(context, orderId).then((value) {
                        //       if(value.response.statusCode == 200){
                        //         Provider.of<OrderProvider>(context, listen: false).initOrderList(context);
                        //         Navigator.pop(context);
                        //         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        //           content: Text(getTranslated('order_cancelled_successfully', context)),
                        //           backgroundColor: Colors.green,));
                        //       }
                        //     })) :

                        CustomButton(buttonText: 'TRACK_ORDER',
                          onTap: () {

                          }

                          ,),),
                        SizedBox(width: Dimensions.PADDING_SIZE_SMALL),


                        Expanded(child: SizedBox(height: 45,
                          child: TextButton(
                            onPressed: () {

                            },
                            child: Text('SUPPORT_CENTER',
                              style: titilliumSemiBold.copyWith(fontSize: 16,
                                  color: Theme
                                      .of(context)
                                      .primaryColor),),
                            style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                  side: BorderSide(
                                      color: Theme.of(context).primaryColor)),
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
