import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utill/custom_themes.dart';
import '../../../utill/dimensions.dart';
import '../../../utill/images.dart';
import '../../baseWidget/custom_app_bar.dart';
import '../../baseWidget/rating_bar.dart';
import '../../baseWidget/search_widget.dart';
import '../home/widget/products_view.dart';

class SellerScreen extends StatefulWidget {
  // final SellerModel seller;
  SellerScreen();

  @override
  State<SellerScreen> createState() => _SellerScreenState();
}

class _SellerScreenState extends State<SellerScreen> {
  ScrollController _scrollController = ScrollController();

  // void _load(){
  //   Provider.of<ProductProvider>(context, listen: false).removeFirstLoading();
  //   Provider.of<ProductProvider>(context, listen: false).clearSellerData();
  //   Provider.of<ProductProvider>(context, listen: false).initSellerProductList(widget.seller.seller.id.toString(), 1, context);
  // }


  @override
  void initState() {
    super.initState();
    // _load();
  }




  @override
  Widget build(BuildContext context) {


    String ratting =  "0";



    return Scaffold(
      backgroundColor: Color(0xFFF9F9F9),

      body: Column(
        children: [
          CustomAppBar(title: '{widget.seller.seller.fName}{widget.seller.seller.lName}'),

          Expanded(
            child: ListView(
              controller: _scrollController,
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.all(0),
              children: [

                // Banner
                Padding(
                  padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: FadeInImage.assetNetwork(
                      placeholder: Images.placeholder, height: 120, fit: BoxFit.cover,
                      image: '{Provider.of<SplashProvider>(context, listen: false).baseUrls.shopImageUrl}/banner/{widget.seller.seller.shop != null ? widget.seller.seller.shop.banner : ''}',
                      imageErrorBuilder: (c, o, s) => Image.asset(Images.placeholder, height: 120, fit: BoxFit.cover),
                    ),
                  ),
                ),

                Container(
                  color: Theme.of(context).highlightColor,
                  padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                  child: Column(children: [

                    // Seller Info
                    Row(children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: FadeInImage.assetNetwork(
                          placeholder: Images.placeholder, height: 80, width: 80, fit: BoxFit.cover,
                          image: '{Provider.of<SplashProvider>(context, listen: false).baseUrls.shopImageUrl}/{widget.seller.seller.shop.image}',
                          imageErrorBuilder: (c, o, s) => Image.asset(Images.placeholder, height: 80, width: 80, fit: BoxFit.cover),
                        ),
                      ),
                      SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                      Expanded(
                        child: Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("widget.seller.seller.shop.name", style: titilliumSemiBold.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE), maxLines: 1, overflow: TextOverflow.ellipsis,),

                            Row(
                              children: [
                                RatingBarr(rating: double.parse(ratting)),
                                Text('({widget.seller.totalReview.toString()})' , style: titilliumRegular.copyWith(), maxLines: 1, overflow: TextOverflow.ellipsis,),

                              ],
                            ),
                            SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                            Row(
                              children: [
                                Text('widget.seller.totalReview.toString() reviews',
                                  style: titleRegular.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE,
                                      color: Color(0xFF66717C)),
                                  maxLines: 1, overflow: TextOverflow.ellipsis,),
                                SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT),

                                Text('|'),
                                SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT),

                                Text('getTranslated(products, context)}',
                                  style: titleRegular.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE,
                                      color: Color(0xFF66717C)),
                                  maxLines: 1, overflow: TextOverflow.ellipsis,),
                              ],
                            ),


                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          // if(!Provider.of<AuthProvider>(context, listen: false).isLoggedIn()) {
                          //   showAnimatedDialog(context, GuestDialog(), isFlip: true);
                          // }else if(widget.seller != null) {
                          //   Navigator.push(context, MaterialPageRoute(builder: (_) => ChatScreen(seller: widget.seller)));
                          // }
                        },
                        icon: Image.asset(Images.chat_image, color: Color(0xff92C6FF), height: Dimensions.ICON_SIZE_DEFAULT),
                      ),
                    ]),

                  ]),
                ),
                SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                Padding(
                  padding:  EdgeInsets.only(left: Dimensions.PADDING_SIZE_SMALL, right: Dimensions.PADDING_SIZE_EXTRA_EXTRA_SMALL),
                  child: SearchWidget(
                    hintText: 'Search product...',
                    // onTextChanged: (String newText) => Provider.of<ProductProvider>(context, listen: false).filterData(newText),
                    onClearPressed: () {},
                    isSeller: true,
                  ),
                ),

                Padding(
                  padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  child: ProductView(isHomePage: false, scrollController: _scrollController, sellerId: "2"),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
