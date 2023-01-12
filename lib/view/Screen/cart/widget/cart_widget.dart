import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../../../data/model/response/cart/get_cart_model.dart';
import '../../../../helper/shared_preference.dart';
import '../../../../utill/app_constants.dart';
import '../../../../utill/custom_themes.dart';
import '../../../../utill/dimensions.dart';
import '../../../../utill/images.dart';

class CartWidget extends StatefulWidget {
  final GetCartModel cartModel;
  final int index;
  final bool fromCheckout;
  final Function() deleteCart;
  final Function() updateCart;
  final orderAmount;
  const CartWidget({Key key, @required this.index, @required this.fromCheckout, @required this.cartModel, this.deleteCart, this.updateCart, this.orderAmount});

  @override
  State<CartWidget> createState() => _CartWidgetState();
}



class _CartWidgetState extends State<CartWidget> {

  updateQty(int quantity, int cartId) async{
    print("object");
    EasyLoading.show(status: 'loading...');
    if(quantity > 0){
      var api = Uri.parse(AppConstants.UPDATE_CART_QUANTITY_URI);
      String token = await HelperFunction.getToken();
      Map data = {
        "quantity": '$quantity',
        "id": "$cartId"
      };
      print("Quantity"+quantity.toString());
      try{
        var response = await http.post(api, body: data, headers: {'Authorization': 'Bearer $token'});
        print("response212 >>> ${response.body.toString()}");
        var res = await jsonDecode(response.body.toString());
        if(response.statusCode == 200){
          if(res['message'] == 'Cart updated'){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(res['message'])));
            EasyLoading.dismiss();
          }
        }
      }catch(e){
        EasyLoading.dismiss();
      }
    }
    else if(quantity == 0){
      widget.deleteCart();
      widget.updateCart();
      EasyLoading.dismiss();
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("not accepted")));
      EasyLoading.dismiss();
    }
  }

  @override
  Widget build(BuildContext context) {

    int qty = int.parse(widget.cartModel.data[widget.index].quantity);
    int CartId = widget.cartModel.data[widget.index].id;
    int maxQty = widget.cartModel.data[widget.index].minimumOrderQty;
    print("22222222222222222222222222");
    print(qty);
    return Container(
      margin: EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
      decoration: BoxDecoration(color: Theme.of(context).highlightColor,

      ),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment:  MainAxisAlignment.start,
          children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL),
              border: Border.all(color: Theme.of(context).primaryColor.withOpacity(.20),width: 1)
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL),
            child: FadeInImage.assetNetwork(
              placeholder: Images.placeholder, height: 60, width: 60,
              image: "${widget.cartModel.data[widget.index].thumbnail}",
              imageErrorBuilder: (c, o, s) => Image.asset(Images.placeholder,fit: BoxFit.cover, height: 60, width: 60),
            ),
          ),
        ),

        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(widget.cartModel.data[widget.index].name, maxLines: 1, overflow: TextOverflow.ellipsis,
                            style: titilliumBold.copyWith(
                          fontSize: Dimensions.FONT_SIZE_DEFAULT,
                          color: Color(0xFF66717C),
                        )),
                      ),
                      SizedBox(width: Dimensions.PADDING_SIZE_SMALL,),
                      !widget.fromCheckout ? InkWell(
                        onTap: () {
                          widget.deleteCart();
                          // if(Provider.of<AuthProvider>(context, listen: false).isLoggedIn()) {
                          //   Provider.of<CartProvider>(context, listen: false).removeFromCartAPI(context,cartModel.id);
                          // }else {
                          //   Provider.of<CartProvider>(context, listen: false).removeFromCart(index);
                          // }
                        },
                        child: Container(width: 20,height: 20,
                            child: Image.asset(Images.delete,scale: .5,)),
                      ) : SizedBox.shrink(),
                    ],

                  ),
                  SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),
                  Row(
                    children: [

                      // cartModel.discount>0?
                      // Text("65898567",
                      //   // PriceConverter.convertPrice(context, cartModel.price),maxLines: 1,overflow: TextOverflow.ellipsis,
                      //   style: titilliumSemiBold.copyWith(color: Color(0xFFFF5555),
                      //       decoration: TextDecoration.lineThrough,
                      //   ),
                      // ),
                      SizedBox(width: Dimensions.FONT_SIZE_DEFAULT,),
                      Text("${double.parse(widget.cartModel.data[widget.index].price)*qty}",
                        // PriceConverter.convertPrice(context, cartModel.price,
                        //     discount: cartModel.discount,discountType: 'amount'),
                        maxLines: 1,overflow: TextOverflow.ellipsis,
                        style: titilliumRegular.copyWith(
                            color: Theme.of(context).primaryColor,

                            fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE
                            ),
                      ),
                    ],
                  ),


                  //variation
                  // (cartModel.variant != null && cartModel.variant.isNotEmpty) ?
                  // Padding(
                  //   padding: EdgeInsets.only(top: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  //   child: Row(children: [
                  //     Flexible(child: Text(
                  //         "cartModel.variant",
                  //         style: robotoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT,
                  //           color: Color(0xFF66717C)))),
                  //   ]),
                  // ),
                      // : SizedBox(),
                  SizedBox(width: Dimensions.PADDING_SIZE_SMALL),


                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    // cartModel.shippingType !='order_wise' && Provider.of<AuthProvider>(context, listen: false).isLoggedIn()?
                    Padding(
                      padding: EdgeInsets.only(top: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                      child: Row(children: [
                        Text('Shipping cost',
                            style: titilliumSemiBold.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT,
                                color: Color(0xFF66717C))),
                        Text(widget.cartModel.data[widget.index].shippingCost,
                            style: robotoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL,
                          color: Theme.of(context).disabledColor,)),
                      ]),
                    ),

                    // Provider.of<AuthProvider>(context, listen: false).isLoggedIn() ?
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: Dimensions.PADDING_SIZE_SMALL),
                          child: IconButton(
                              icon: Icon(Icons.remove),
                              onPressed: () => updateQty(qty-1, CartId).then((value){
                                widget.updateCart();

                              })),
                        ),
                        Text(qty.toString(), style: titilliumSemiBold),
                        Padding(
                          padding: EdgeInsets.only(left: Dimensions.PADDING_SIZE_SMALL),
                          child: IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () {
    updateQty(qty+1, CartId).then((value){
    widget.updateCart();

    });
    },
                        ),
                        )],
                    ),
                  ],),

                ],
              ),
          ),
        ),



      ]),
    );
  }
}


// class Counter extends ChangeNotifier {
//   final GetCartModel cartModel;
//   final bool isIncrement;
//   final int quantity;
//   final int index;
//   final int maxQty;
//   final int minimumOrderQuantity;
//
//   int _count = 0;
//
//   Counter(this.cartModel, this.isIncrement, this.quantity, this.index, this.maxQty, this.minimumOrderQuantity);
//
//   // Counter(this.index, this.isIncrement, this.quantity, this.maxQty, this.minimumOrderQuantity, this.cartModel);
//   int get getCounter => _count;
//   // int  _count = int.parse(cartModel.data[index].quantity);
//
//   void incrementCounter() {
//     // _count = int.parse(cartModel.data[index].quantity)+1;
//     _count += 1;
//     notifyListeners();
//   }
//
//   void decrementCounter(){
//     // _count = int.parse(cartModel.data[index].quantity)-1;
//     _count -= 1;
//     notifyListeners();
//   }
// }