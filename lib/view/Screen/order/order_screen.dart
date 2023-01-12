import 'package:flutter/material.dart';
import 'package:gaadi_part/view/Screen/order/order_controller/order_controller.dart';
import 'package:gaadi_part/view/Screen/order/widget/order_widget.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../data/DAshboard Repository/dashboadRepository.dart';
import '../../../data/model/response/Order/all_order_list.dart';
import '../../../data/model/response/Order/order_details_modal.dart';
import '../../../helper/date_converter.dart';
import '../../../utill/custom_themes.dart';
import '../../../utill/dimensions.dart';
import '../../../utill/images.dart';
import '../../baseWidget/custom_app_bar.dart';
import 'order_details_screen.dart';

// ignore: must_be_immutable
class OrderScreen extends StatefulWidget {
  final bool isBacButtonExist;

  OrderScreen({this.isBacButtonExist = true});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  bool isGuest = false;
  AllOrderList allOrderList;

  getOrderList() async {
    var res = await DashboardApiClient().GetAllOrderList();
    if (res != null) {
      setState(() {
        allOrderList = res;
      });
    }
    print(allOrderList.order);
  }

  @override
  void initState() {
    getOrderList();
    // TODO: implement initState
    super.initState();
  }

  // bool isFirstTime = true;
  @override
  final orderController = Get.put(OrderController());

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9F9F9),
      body: Column(
        children: [
          CustomAppBar(
              title: 'ORDER', isBackButtonExist: widget.isBacButtonExist),
          // isGuestMode ? SizedBox() :
          // Provider.of<OrderProvider>(context).pendingList != null ?
          // Padding(
          //   padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
          //   child: Row(children: [
          //     OrderTypeButton(text: 'RUNNING', index: 0,),
          //     SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
          //     OrderTypeButton(text: 'DELIVERED', index: 1, ),
          //     SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
          //     OrderTypeButton(text: 'CANCELED', index: 2,),
          //   ],),),

          // isGuestMode ? Expanded(child: NotLoggedInWidget()) :
          // Provider.of<OrderProvider>(context).pendingList != null ?
          // Consumer<OrderProvider>(
          //   builder: (context, order, child) {
          // List<OrderModel> orderList = [];
          // if (Provider.of<OrderProvider>(context, listen: false).orderTypeIndex == 0) {
          //   orderList = order.pendingList;
          // }
          //
          // else if (Provider.of<OrderProvider>(context, listen: false).orderTypeIndex == 1) {
          //   orderList = order.deliveredList;
          // }
          //
          // else if (Provider.of<OrderProvider>(context, listen: false).orderTypeIndex == 2) {
          //   orderList = order.canceledList;
          // }
          // return
          Expanded(
            child: RefreshIndicator(
                backgroundColor: Theme.of(context).primaryColor,
                onRefresh: () async {
                  // await Provider.of<OrderProvider>(context, listen: false).initOrderList(context);
                },
                child: (!isGuest)
                    ?(!allOrderList.isBlank) ?(allOrderList != null)
                        ? ListView.builder(
                            itemCount: allOrderList.order.length,
                            padding: EdgeInsets.all(0),
                            itemBuilder: (context, index) {
                              return Card(
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () {
                                      openOrderDetailSheet(
                                          allOrderList.order[index].id);
                                      // Navigator.of(context).push(MaterialPageRoute(
                                      //     builder: (context) => OrderDetailsScreen(orderModel: AllOrderList().order,
                                      //         // orderId: orderModel.id, orderType: AllOrderList().order,
                                      //         // extraDiscount: orderModel.extraDiscount,
                                      //         // extraDiscountType: orderModel.extraDiscountType
                                      //     )));
                                    },
                                    child: ListTile(
                                      // margin: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_SMALL,
                                      //     left: Dimensions.PADDING_SIZE_SMALL, right: Dimensions.PADDING_SIZE_SMALL),
                                      // padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                                      // decoration: BoxDecoration(color: Theme.of(context).highlightColor,
                                      //     borderRadius: BorderRadius.circular(5)),
                                      title: Text(
                                        "ORDER ID : ${allOrderList.order[index].id}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18),
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(children: [
                                            Text(
                                                DateConverter
                                                    .localDateToIsoStringAMPM(
                                                        DateTime.parse(
                                                            allOrderList
                                                                .order[index]
                                                                .createdAt
                                                                .toString())),
                                                style:
                                                    titilliumRegular.copyWith(
                                                  fontSize: Dimensions
                                                      .FONT_SIZE_SMALL,
                                                  color: Theme.of(context)
                                                      .hintColor,
                                                )),
                                          ]),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "Order Placed",
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          // SizedBox(
                                          //   height: 5,
                                          // ),
                                          // // Column(
                                          // //     crossAxisAlignment:
                                          // //         CrossAxisAlignment.start,
                                          // //     mainAxisAlignment:
                                          // //         MainAxisAlignment.start,
                                          // //     children: [
                                          // //       Text('Total price',
                                          // //           style: TextStyle(
                                          // //               fontWeight:
                                          // //                   FontWeight.w400,
                                          // //               fontSize: 14)),
                                          // //       Text(
                                          // //           allOrderList.order[index]
                                          // //               .paymentType
                                          // //               .toString(),
                                          // //           style: titilliumSemiBold),
                                          // //     ]),
                                          // SizedBox(
                                          //   height: 5,
                                          // ),
                                          // (allOrderList.order[index].deliveryStatus.name
                                          //     !="PENDIND")?Container(
                                          //   decoration: BoxDecoration(
                                          //     // color: Colors.greenAccent,
                                          //     borderRadius:
                                          //         BorderRadius.circular(5),
                                          //   ),
                                          //   child: Text(
                                          //       allOrderList
                                          //           .order[index].deliveryStatus.name,
                                          //       style: TextStyle(
                                          //           fontWeight: FontWeight.w400,
                                          //           fontSize: 17,
                                          //           color: Colors.red)),
                                          // ):Container(
                                          //   decoration: BoxDecoration(
                                          //     // color: Colors.greenAccent,
                                          //     borderRadius:
                                          //     BorderRadius.circular(5),
                                          //   ),
                                          //   child: Text(
                                          //       allOrderList
                                          //           .order[index].deliveryStatus.name,
                                          //       style: TextStyle(
                                          //           fontWeight: FontWeight.w400,
                                          //           fontSize: 17,
                                          //           color: Colors.green)),
                                          // )
                                        ],
                                      ),
                                      trailing: (allOrderList.order[index].deliveryStatus.name
                                          !="PENDIND")?Container(
                                        decoration: BoxDecoration(
                                          // color: Colors.greenAccent,
                                          borderRadius:
                                          BorderRadius.circular(5),
                                        ),
                                        child: Text(
                                            allOrderList
                                                .order[index].deliveryStatus.name,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 17,
                                                color: Colors.red)),
                                      ):Container(
                                        decoration: BoxDecoration(
                                          // color: Colors.greenAccent,
                                          borderRadius:
                                          BorderRadius.circular(5),
                                        ),
                                        child: Text(
                                            allOrderList
                                                .order[index].deliveryStatus.name,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 17,
                                                color: Colors.green)),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }) :Center(child: CircularProgressIndicator(),)
                        : Center(child: Text("No data found"),
                          )
                    : Center(
                        child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(image: AssetImage(Images.no_data_found)),
                            Text(
                              "Login first",
                              style: titilliumBold.copyWith(
                                  fontSize: Dimensions.FONT_SIZE_OVER_LARGE),
                            )
                          ],
                        ),
                      ))),
          ),
          // \},)
          //       : Expanded(child: OrderShimmer()),
        ],
      ),
    );
  }

  void openOrderDetailSheet(int orderId) async {


    print(orderId);
    GetOrderDetails getOrderDetailsmodal;
    var isLoading = true.obs;
    //need to hit the api to get order details
    //https://softfix.in/demo/gaadipart/api/v2/order-confirmed/23
    var res = await DashboardApiClient().getOrderDetails(orderId);
    print(res);
    if (res != null) {
      print("1111111111111111111111111111111111111");
      getOrderDetailsmodal = res;
      isLoading.value = false;
    }
    if(Get.isBottomSheetOpen){
      Get.back();
    }
    Get.bottomSheet(Obx(() => SingleChildScrollView(
      child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20), topRight: Radius.circular(20))),
            height: 400,
            child: (isLoading.value)
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Center(
                    child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      Center(
                        widthFactor: double.infinity,
                        child: Container(
                          width: 50,
                          height: 5,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(30)),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Container(
                        child: Text(
                          "Order Details",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 25),
                        ),
                      ),
                      (getOrderDetailsmodal.paymentType == "cash_on_delivery")
                          ? Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Image(
                                      image: AssetImage(Images.cash_image),
                                      height: 50,
                                      width: 50,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          "Payment type",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15),
                                        ),
                                        Text(
                                          "Cash On Delivery",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black45),
                                        ),
                                      ],
                                    ),
                                    Expanded(
                                        child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          "Payment Status",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15),
                                        ),
                                        Container(
                                          alignment: Alignment.centerRight,
                                          child: (getOrderDetailsmodal
                                                      .paymentStatus ==
                                                  "unpaid")
                                              ? Container(
                                                  child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Container(
                                                      height: 15,
                                                      width: 15,
                                                      decoration: BoxDecoration(
                                                          shape: BoxShape.circle,
                                                          color: Colors.red),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text("Unpaid",
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color:
                                                                Colors.black45))
                                                  ],
                                                ))
                                              : Container(
                                                  child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Container(
                                                      height: 15,
                                                      width: 15,
                                                      decoration: BoxDecoration(
                                                          shape: BoxShape.circle,
                                                          color: Colors.green),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text("Paid",
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color:
                                                                Colors.black45))
                                                  ],
                                                )),
                                        ),
                                      ],
                                    ))
                                  ],
                                ),
                              ),
                            )
                          : Card(
                              child: Row(
                                children: [
                                  Image(
                                    image: AssetImage(Images.credit_card),
                                    height: 50,
                                    width: 50,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "Payment type",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15),
                                      ),
                                      Text(
                                        "Online Payment",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black45),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Delivery Address",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 15),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                                "${getOrderDetailsmodal.shippingAddress.address},${getOrderDetailsmodal.shippingAddress.city},${getOrderDetailsmodal.shippingAddress.country},${getOrderDetailsmodal.shippingAddress.postalCode} \nPh.no : ${getOrderDetailsmodal.shippingAddress.phone}",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black45)),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                                "Shipped To : ${getOrderDetailsmodal.shippingAddress.name}",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black)),
                            Text(
                                "Email : ${getOrderDetailsmodal.shippingAddress.email}",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black))
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Product Name",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 15),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                  width: MediaQuery.of(context).size.width/2.4,
                                  child: Text(getOrderDetailsmodal.orderDetails.productName)),
                            ],
                          ),
                          Text("Unit Price: ₹${getOrderDetailsmodal.orderDetails.unitPrice}",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 15),)
                        ],
                      ))
                    ],
                  )),
          ),
    )));

  }
}

class OrderShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      padding: EdgeInsets.all(0),
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(bottom: Dimensions.MARGIN_SIZE_DEFAULT),
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
          color: Theme.of(context).highlightColor,
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300],
            highlightColor: Colors.grey[100],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(height: 10, width: 150, color: Colors.white),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(child: Container(height: 45, color: Colors.white)),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 3,
                      child: Column(
                        children: [
                          Container(height: 20, color: Colors.white),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Container(
                                  height: 10, width: 70, color: Colors.white),
                              SizedBox(width: 10),
                              Container(
                                  height: 10, width: 20, color: Colors.white),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class OrderTypeButton extends StatelessWidget {
  final String text;
  final int index;

  // final List<OrderModel> orderList;

  OrderTypeButton({
    @required this.text,
    @required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextButton(
        // onPressed: () => Provider.of<OrderProvider>(context, listen: false).setIndex(index),
        style: TextButton.styleFrom(padding: EdgeInsets.all(0)),
        child: Container(
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Theme.of(context).highlightColor,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(text + '({orderList})',
              style: titilliumBold.copyWith(
                  color: Theme.of(context).highlightColor)),
        ),
      ),
    );
  }
}
