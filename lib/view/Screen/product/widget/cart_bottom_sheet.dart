import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gaadi_part/view/Screen/cart/cart_controller.dart';
import 'package:get/get.dart';
import '../../../../data/model/response/cart/add_to_cart_model.dart';
import '../../../../helper/shared_preference.dart';
import '../../../../utill/app_constants.dart';
import '../../../../utill/custom_themes.dart';
import '../../../../utill/dimensions.dart';
import '../../../../utill/images.dart';
import '../../../baseWidget/botton/custom_button.dart';
import '../../cart/cart_screen.dart';
import 'package:quantity_input/quantity_input.dart';
import 'package:http/http.dart' as http;


class CartBottomSheet extends StatefulWidget {
  // final Product product;
  final Function callback;
  String proName;
  String ratingCount;
  String lowerPrice;
  String higherPrice;
  String image;
  String stock;
  String description;
  String id;

  CartBottomSheet(
      {this.callback, this.proName, this.ratingCount, this.lowerPrice, this.higherPrice, this.image, this.stock, this.description, this.id});

  @override
  _CartBottomSheetState createState() => _CartBottomSheetState();
}

class _CartBottomSheetState extends State<CartBottomSheet> {

  AddCartModel _addCartModel;
  final cartController = Get.put(CartController());

  int quantity = 1;
  double totalCost;

  route(bool isRoute, String message) async {
    if (isRoute) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message), backgroundColor: Colors.green));
      Navigator.pop(context);
    } else {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message), backgroundColor: Colors.red));
    }
  }

  addCart(quantity, lowerPrice, id) async {

    String qty = quantity.toString();
    String price = lowerPrice.toString();
    String proId = id.toString();
    print(qty);
    print(price);
    print(proId);
    var api = Uri.parse(AppConstants.ADD_TO_CART_URI);
    print(await HelperFunction.getToken());
    String userId = await HelperFunction.getUserId();
    print(userId);
    Map data = {
      'quantity': qty,
      'user_id': userId,
      'price': price,
      'id': proId
    };
    try {
      final response = await http.post(api, body: data);
      print("add to cart Response >>> ${response.body.toString()}");
      if (response.statusCode == 200) {
        cartController.getCart();
        AddCartModel _addCartModel = AddCartModel.fromJson(jsonDecode(response.body));
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(_addCartModel.message.toString(),
              ), backgroundColor: Colors.red,));
        // Navigator.of(context).push(MaterialPageRoute(builder: (context) => CartScreen()));
        Navigator.pop(context);
      }
    }
    catch (e) {

    }

    // var AddCartResponse = await DashboardApiClient().addtoCart(
    //     id, lowerPrice, quantity);
    // print("123123$AddCartResponse");
    // if (AddCartResponse != null) {
    //   setState(() {
    //     _addCartModel = AddCartResponse ;
    //     print("asdsd"+AddCartResponse.toString());
    //
    //   });
    //   return _addCartModel;
    // } else {
    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //     content: Text(AddCartResponse.toString()),
    //     backgroundColor: Colors.red,
    //   ));
    // }
  }

  @override
  void initState() {
    // Provider.of<ProductDetailsProvider>(context, listen: false).initData(widget.product, context);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20), topLeft: Radius.circular(20)),
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, children: [

              // Close Button
              Align(alignment: Alignment.centerRight, child: InkWell(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(shape: BoxShape.circle, color: Theme
                      .of(context)
                      .highlightColor, boxShadow: [BoxShadow(
                    color: Colors.grey[ 200],
                    spreadRadius: 1,
                    blurRadius: 5,
                  )
                  ]),
                  child: Icon(Icons.clear, size: Dimensions.ICON_SIZE_SMALL),
                ),
              )),

              // Product details
              Column(
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                              color: Color(0xFFE2F0FF),
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(width: .5, color: Theme
                                  .of(context)
                                  .primaryColor
                                  .withOpacity(.20))
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: FadeInImage.assetNetwork(
                              placeholder: Images.placeholder,
                              image: 'https://softfix.in/demo/gaadipart/public/${widget
                                  .image}',
                              imageErrorBuilder: (c, o, s) =>
                                  Image.asset(Images.placeholder),
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(widget.proName,
                                    style: titilliumRegular.copyWith(
                                        fontSize: Dimensions.FONT_SIZE_LARGE),
                                    maxLines: 2, overflow: TextOverflow
                                        .ellipsis),

                                SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                                Row(
                                  children: [
                                    Icon(Icons.star, color: Colors.orange),
                                    Text(widget.ratingCount,
                                        style: titilliumSemiBold.copyWith(
                                            fontSize: Dimensions
                                                .FONT_SIZE_LARGE),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis),
                                  ],
                                ),


                              ]),
                        ),


                      ]),
                  Row(
                    children: [
                      // Container(
                      //   margin: EdgeInsets.only(top: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                      //   padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                      //   alignment: Alignment.center,
                      //   decoration: BoxDecoration(
                      //     color:Theme.of(context).primaryColor,
                      //     borderRadius: BorderRadius.circular(8),
                      //   ),
                      //   child: Padding(
                      //     padding: const EdgeInsets.all(8.0),
                      //     child: Text(
                      //       "2131",
                      //       style: titilliumRegular.copyWith(color: Theme.of(context).cardColor,
                      //           fontSize: Dimensions.FONT_SIZE_DEFAULT),
                      //     ),
                      //   ),
                      // ),
                      SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT),
                      // Text(
                      //   "${widget.higherPrice}₹",
                      //   style: titilliumRegular.copyWith(color: Colors.red,
                      //       decoration: TextDecoration.lineThrough),
                      // ),
                      // SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT),
                      Text(
                        "${widget.lowerPrice}₹",
                        style: titilliumRegular.copyWith(color: Theme
                            .of(context)
                            .primaryColor,
                            fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE),
                      ),

                    ],
                  ),
                ],
              ),


              SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
              // Variant
              //  Row( children: [
              //    Text('select_variant',
              //        style: titilliumRegular.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT)),
              //    SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT),
              //    SizedBox(
              //      height: 40,
              //      child: ListView.builder(
              //        itemCount: 1,
              //        shrinkWrap: true,
              //        scrollDirection: Axis.horizontal,
              //        itemBuilder: (ctx, index) {
              //          String colorString = '0xffaaaaaa';
              //          return InkWell(
              //            onTap: () {
              //              // Provider.of<ProductDetailsProvider>(context, listen: false).setCartVariantIndex(widget.product, index, context);
              //            },
              //            child: Container(
              //              decoration: BoxDecoration(
              //                  borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL),
              //                  border: Border.all(width: 1,
              //                      color: Theme.of(context).primaryColor)
              //              ),
              //              child: Padding(padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
              //
              //                child: Container(height: Dimensions.topSpace, width: Dimensions.topSpace,
              //                  padding: EdgeInsets.all( Dimensions.PADDING_SIZE_EXTRA_SMALL),
              //                  alignment: Alignment.center,
              //                  decoration: BoxDecoration(
              //                    color: Color(int.parse(colorString)),
              //                    borderRadius: BorderRadius.circular(5),),
              //                ),
              //              ),
              //            ),
              //          );
              //        },
              //      ),
              //    ),
              //  ]) ,
              // SizedBox(height: Dimensions.PADDING_SIZE_SMALL) ,
              //
              //
              //  // Variation
              //  ListView.builder(
              //    shrinkWrap: true,
              //    itemCount: 1,
              //    physics: NeverScrollableScrollPhysics(),
              //    itemBuilder: (ctx, index) {
              //      return Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              //        Text('{getTranslated342}',
              //            style: titilliumRegular.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT)),
              //        SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
              //
              //
              //        Expanded(
              //          child: Padding(padding: const EdgeInsets.all(2.0),
              //            child: GridView.builder(
              //              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //                crossAxisCount: 4,
              //                crossAxisSpacing: 5,
              //                mainAxisSpacing: 5,
              //                childAspectRatio: (1 / .7),
              //              ),
              //              shrinkWrap: true,
              //              physics: NeverScrollableScrollPhysics(),
              //              itemCount: 1,
              //              itemBuilder: (ctx, i) {
              //                return InkWell(
              //                  onTap: ()  {},
              //                  child: Container(
              //                    decoration: BoxDecoration(
              //                      borderRadius: BorderRadius.circular(5),
              //                      border: Border.all(color: Theme.of(context).primaryColor,),),
              //                    child: Center(
              //                      child: Text("s[i].trim()", maxLines: 1,
              //                          overflow: TextOverflow.ellipsis, style: titilliumRegular.copyWith(
              //                            fontSize: Dimensions.FONT_SIZE_DEFAULT,
              //                            color: Theme.of(context).primaryColor,
              //                          )),
              //                    ),
              //                  ),
              //                );
              //              },
              //            ),
              //          ),
              //        ),
              //      ]);
              //    },
              //  ),
              //  SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),


              // Quantity
              Row(children: [
                Text('quantity', style: robotoBold),
                SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                QuantityInput(

                    value: quantity,
                    maxValue: 5,
                    onChanged: (value) =>
                        setState(() {
                          quantity = int.parse(value.replaceAll(',', ''));
                        })
                )
                // QuantityButton(isIncrement: false, quantity: quantity, stock: int.parse(widget.stock), minimumOrderQuantity: int.parse(widget.minQty),),
                // Text(quantity.toString(), style: titilliumSemiBold),
                // QuantityButton(isIncrement: true, quantity: quantity, stock: 20,minimumOrderQuantity: 10),
              ]),
              SizedBox(height: Dimensions.PADDING_SIZE_SMALL),


              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text('total price', style: robotoBold),
                SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                Text("${(double.parse(widget.lowerPrice) * quantity)
                    .toStringAsFixed(2)}₹",
                  style: titilliumBold.copyWith(color: Theme
                      .of(context)
                      .primaryColor, fontSize: Dimensions.FONT_SIZE_LARGE),
                ),
              ]),
              SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

              Row(children: [

                Expanded(
                  child: CustomButton(buttonText: 'Add to cart',
                      onTap: () {
                        addCart(quantity, widget.lowerPrice, widget.id);


                        if (false) {
                          // CartModel cart = CartModel(
                          //     widget.product.id, widget.product.thumbnail, widget.product.name,
                          //     widget.product.addedBy == 'seller' ?
                          //     '${Provider.of<SellerProvider>(context, listen: false).sellerModel.seller.fName} '
                          //         '${Provider.of<SellerProvider>(context, listen: false).sellerModel.seller.lName}' : 'admin',
                          //     price, priceWithDiscount, details.quantity, _stock,
                          //     widget.product.colors.length > 0 ? widget.product.colors[details.variantIndex].name : '',
                          //     widget.product.colors.length > 0 ? widget.product.colors[details.variantIndex].code : '',
                          //     _variation, widget.product.discount, widget.product.discountType, widget.product.tax,
                          //     widget.product.taxType, 1, '',widget.product.userId,'','','', widget.product.choiceOptions,
                          //     Provider.of<ProductDetailsProvider>(context, listen: false).variationIndex,
                          //     widget.product.isMultiPly==1? widget.product.shippingCost*details.quantity : widget.product.shippingCost ??0,
                          //     widget.product.minimumOrderQuantity
                          // );


                          // cart.variations = _variation;
                          if (true) {
                            // Provider.of<CartProvider>(context, listen: false).addToCartAPI(
                            //   cart, route, context, widget.product.choiceOptions,
                            //   Provider.of<ProductDetailsProvider>(context, listen: false).variationIndex,
                            // );
                          } else {
                            // Provider.of<CartProvider>(context, listen: false).addToCart(cart);
                            // Navigator.pop(context);
                            // showCustomSnackBar(getTranslated('added_to_cart', context), context, isError: false);
                          }
                        }
                      }),),
                SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT),


                // Provider.of<CartProvider>(context, listen: false).isLoading ? SizedBox() :
                // Expanded(
                //   child: CustomButton(isBuy:true,
                //       buttonText: getTranslated(_stock < widget.product.minimumOrderQuantity ? 'out_of_stock' : 'buy_now', context),
                //       onTap: _stock < widget.product.minimumOrderQuantity  ? null :() {
                //         if(_stock > widget.product.minimumOrderQuantity ) {
                //           CartModel cart = CartModel(
                //               widget.product.id, widget.product.thumbnail, widget.product.name,
                //               widget.product.addedBy == 'seller' ?
                //               '${Provider.of<SellerProvider>(context, listen: false).sellerModel.seller.fName} '
                //                   '${Provider.of<SellerProvider>(context, listen: false).sellerModel.seller.lName}' : 'admin',
                //               price, priceWithDiscount, details.quantity, _stock,
                //               widget.product.colors.length > 0 ? widget.product.colors[details.variantIndex].name : '',
                //               widget.product.colors.length > 0 ? widget.product.colors[details.variantIndex].code : '',
                //               _variation, widget.product.discount, widget.product.discountType, widget.product.tax,
                //               widget.product.taxType, 1, '',widget.product.userId,'','','', widget.product.choiceOptions,
                //               Provider.of<ProductDetailsProvider>(context, listen: false).variationIndex,
                //               widget.product.isMultiPly==1? widget.product.shippingCost*details.quantity : widget.product.shippingCost ??0,
                //               widget.product.minimumOrderQuantity
                //           );
                //
                //
                //           // cart.variations = _variation;
                //           if(Provider.of<AuthProvider>(context, listen: false).isLoggedIn()) {
                //             Provider.of<CartProvider>(context, listen: false).addToCartAPI(
                //               cart, route, context, widget.product.choiceOptions,
                //               Provider.of<ProductDetailsProvider>(context, listen: false).variationIndex,).
                //             then((value) {
                //               if(value.response.statusCode == 200){
                //                 _navigateToNextScreen(context);
                //               }
                //
                //
                //
                //
                //             }
                //             );
                //           }else {
                //             Fluttertoast.showToast(
                //                 msg: 'You are not loggedIn',
                //                 toastLength: Toast.LENGTH_SHORT,
                //                 gravity: ToastGravity.CENTER,
                //                 timeInSecForIosWeb: 1,
                //                 backgroundColor: Colors.green,
                //                 textColor: Colors.white,
                //                 fontSize: 16.0
                //             );
                //           }
                //         }}),
                // ),
              ],),
            ])
        ),
      ],
    );
  }

  // void _navigateToNextScreen(BuildContext context) {
  //   Navigator.of(context).push(
  //       MaterialPageRoute(builder: (context) => CartScreen()));
  // }
}

class QuantityButton extends StatefulWidget {
  final bool isIncrement;
  final int quantity;
  final bool isCartWidget;
  final int stock;
  final int minimumOrderQuantity;

  QuantityButton({
    @required this.isIncrement,
    @required this.quantity,
    @required this.stock,
    this.isCartWidget = false, this.minimumOrderQuantity,
  });

  @override
  State<QuantityButton> createState() => _QuantityButtonState();
}

class _QuantityButtonState extends State<QuantityButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        if (!widget.isIncrement && widget.quantity > 1) {
          if (widget.quantity > widget.minimumOrderQuantity) {
            // Provider.of<ProductDetailsProvider>(context, listen: false).setQuantity(quantity - 1);
          } else {
            Fluttertoast.showToast(
                msg: "{getTranslated('minimum_quantity_is', context)}minimumOrderQuantity",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0
            );
          }
        } else if (widget.isIncrement && widget.quantity < widget.stock) {
          setState(() {

          });
          // Provider.of<ProductDetailsProvider>(context, listen: false).setQuantity(quantity + 1);
        }
      },
      icon: Container(
        width: 40, height: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(width: 1, color: Theme
                .of(context)
                .primaryColor)
        ),
        child: Icon(
          widget.isIncrement ? Icons.add : Icons.remove,
          color: Colors.green,

          size: widget.isCartWidget ? 26 : 20,
        ),
      ),
    );
  }
}


