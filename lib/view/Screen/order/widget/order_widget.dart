import 'package:flutter/material.dart';

import '../../../../data/model/response/Order/order_list_response.dart';
import '../../../../helper/date_converter.dart';
import '../../../../utill/custom_themes.dart';
import '../../../../utill/dimensions.dart';
import '../order_details_screen.dart';

class OrderWidget extends StatelessWidget {
  // final OrderModel orderModel;
  List<OrderListModel> orderModel;
  int index;
  OrderWidget({Key key, this.index, this.orderModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            // builder: (context) => OrderDetailsScreen(orderModel: orderModel,
            //     orderId: orderModel.id, orderType: orderModel.orderType,
            //     extraDiscount: orderModel.extraDiscount,
            //     extraDiscountType: orderModel.extraDiscountType)));},
            builder: (context) => OrderDetailsScreen(orderModel: orderModel,index: index,)));},

      child: Container(
        margin: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_SMALL,
            left: Dimensions.PADDING_SIZE_SMALL, right: Dimensions.PADDING_SIZE_SMALL),
        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
        decoration: BoxDecoration(color: Theme.of(context).highlightColor,
            borderRadius: BorderRadius.circular(5)),


        child: Row(children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Text('ORDER ID',
                  style: titilliumRegular.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL)),
              SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
              Text(orderModel[index].id.toString(), style: titilliumSemiBold),
            ]),


            Row(children: [
              Text(DateConverter.localDateToIsoStringAMPM(DateTime.parse(orderModel[index].createdAt.toString())),
                  style: titilliumRegular.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL,
                    color: Theme.of(context).hintColor,
              )),
            ]),

          ]),
          SizedBox(width: Dimensions.PADDING_SIZE_LARGE),



          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('total price',
                  style: titilliumRegular.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL)),
              Text(orderModel[index].orderAmount.toString(), style: titilliumSemiBold),
            ]),
          ),


          Container(alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
            decoration: BoxDecoration(
              color: Colors.greenAccent,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(orderModel[index].orderStatus.toString(), style: titilliumSemiBold),
          ),

        ]),
      ),
    );
  }
}
