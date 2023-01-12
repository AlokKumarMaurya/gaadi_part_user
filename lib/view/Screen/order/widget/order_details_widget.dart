import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../utill/custom_themes.dart';
import '../../../../utill/dimensions.dart';
import '../../../../utill/images.dart';
import '../../product/review_dialog.dart';

class OrderDetailsWidget extends StatefulWidget {
  // final OrderDetailsModel orderDetailsModel;
  final String orderType;
  final Function callback;
  OrderDetailsWidget({ this.callback, this.orderType});

  @override
  State<OrderDetailsWidget> createState() => _OrderDetailsWidgetState();
}

class _OrderDetailsWidgetState extends State<OrderDetailsWidget> {
  @override
  Widget build(BuildContext context) {

    return InkWell(

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                child: FadeInImage.assetNetwork(
                  placeholder: Images.placeholder, fit: BoxFit.scaleDown, width: 60, height: 60,
                  image: '{Provider.of<SplashProvider>(context, listen: false).baseUrls.productThumbnailUrl}/{widget.orderDetailsModel.productDetails.thumbnail}',
                  imageErrorBuilder: (c, o, s) => Image.asset(Images.placeholder, fit: BoxFit.scaleDown, width: 50, height: 50),),
              ),
              SizedBox(width: Dimensions.MARGIN_SIZE_DEFAULT),



              Expanded(flex: 3,
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Expanded(child: Text("widget.orderDetailsModel.productDetails.name",
                        style: titilliumSemiBold.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL,
                            color: Theme.of(context).hintColor),
                        maxLines: 2, overflow: TextOverflow.ellipsis,),),



                        // Provider.of<OrderProvider>(context).orderTypeIndex == 1 && widget.orderType != "POS"?
                        InkWell(
                          onTap: () {
                            // if(Provider.of<OrderProvider>(context, listen: false).orderTypeIndex == 1) {
                            //   Provider.of<ProductDetailsProvider>(context, listen: false).removeData();
                              showModalBottomSheet(context: context, isScrollControlled: true,
                                  backgroundColor: Colors.transparent, builder: (context) =>
                                  ReviewBottomSheet(
                                      productID: "213",
                                      callback: widget.callback));
                            // }
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: Dimensions.PADDING_SIZE_SMALL),
                            padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                                horizontal: Dimensions.PADDING_SIZE_SMALL),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_DEFAULT),
                              border: Border.all(width: 1, color: Theme.of(context).primaryColor),
                            ),


                            child: Text('review', style: titilliumRegular.copyWith(
                              fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                              color: Color(0xFF000743),
                            )),
                          ),
                        ) ,


                      InkWell(
                        onTap: () {
    // Provider.of<ProductDetailsProvider>(context, listen: false).removeData();
    // refund.getRefundReqInfo(context, widget.orderDetailsModel.id).then((value) {
    //   if(value.response.statusCode==200){
    //     Navigator.push(context, MaterialPageRoute(builder: (_) =>
    //         RefundBottomSheet(product: widget.orderDetailsModel.productDetails,
    //             orderDetailsId: widget.orderDetailsModel.id)));
    //   }
    // });
    //   },
    //
    // child:
    // / refund.isRefund ?
    //  Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor)):
    //  Container(margin: EdgeInsets.only(left: Dimensions.PADDING_SIZE_SMALL),
    //    padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL,
    //        horizontal: Dimensions.PADDING_SIZE_SMALL),
    //    decoration: BoxDecoration(color: ColorResources.getPrimary(context),
    //      borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_DEFAULT),),
    //
    //    child: Text(getTranslated('refund_request', context),
    //        style: titilliumRegular.copyWith(fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
    //          color: Theme.of(context).highlightColor,)),),
    }),


                      InkWell(
                        onTap: () {
                          // Provider.of<ProductDetailsProvider>(context, listen: false).removeData();
                          // refund.getRefundReqInfo(context, widget.orderDetailsModel.id).then((value) {
                          //   if(value.response.statusCode==200){
                          //     Navigator.push(context, MaterialPageRoute(builder: (_) =>
                          //         RefundResultBottomSheet(product: widget.orderDetailsModel.productDetails,
                          //             orderDetailsId: widget.orderDetailsModel.id,
                          //             orderDetailsModel:  widget.orderDetailsModel)));}});
                          },



                        child:
                        // refund.isLoading?
                        Center(
                        child:
                          // CircularProgressIndicator(color: Theme.of(context).primaryColor)):

                        Container(margin: EdgeInsets.only(left: Dimensions.PADDING_SIZE_SMALL),
                          padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                              horizontal: Dimensions.PADDING_SIZE_SMALL),
                          decoration: BoxDecoration(color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_DEFAULT),),

                          child: Text('refund_status_btn',
                              style: titilliumRegular.copyWith(fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                                color: Theme.of(context).highlightColor,)),),
                      ))
                      ],
                    ),
                    SizedBox(height: Dimensions.MARGIN_SIZE_EXTRA_SMALL),


                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Text("666",
                          style: titilliumSemiBold.copyWith(color: Theme.of(context).primaryColor),
                        ),
                        Text('x.qty}',
                            style: titilliumSemiBold.copyWith(color: Theme.of(context).primaryColor)),


                        // widget.orderDetailsModel.discount>0?
                        Container(height: 20,
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: Theme.of(context).primaryColor)),


                          child: Text('amount',
                            style: titilliumRegular.copyWith(fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                                color: Theme.of(context).primaryColor),
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
              ),

            ],
          ),

          // (widget.orderDetailsModel.variant != null && widget.orderDetailsModel.variant.isNotEmpty) ?
          Padding(padding: EdgeInsets.only(left: Dimensions.PADDING_SIZE_SMALL,
              top: Dimensions.PADDING_SIZE_EXTRA_SMALL),

            child: Row(children: [

              SizedBox(width: 65),
              Text('variations',
                  style: titilliumSemiBold.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL)),


              Flexible(child: Text('widget.orderDetailsModel.variant',
                  style: robotoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL,
                    color: Theme.of(context).disabledColor,))),
            ]),
          ) ,

          Divider(),
        ],
      ),
    );
  }
}
