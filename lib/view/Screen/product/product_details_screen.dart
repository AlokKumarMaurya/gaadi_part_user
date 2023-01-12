import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gaadi_part/view/Screen/product/widget/bottom_cart_view.dart';
import 'package:gaadi_part/view/Screen/product/widget/product_image_view.dart';
import 'package:gaadi_part/view/Screen/product/widget/product_specification_view.dart';
import 'package:gaadi_part/view/Screen/product/widget/product_title_view.dart';
import 'package:gaadi_part/view/Screen/product/widget/promise_screen.dart';
import 'package:gaadi_part/view/Screen/product/widget/related_product_view.dart';
import '../../../data/DAshboard Repository/dashboadRepository.dart';
import '../../../data/model/response/product_details_model.dart';
import '../../../utill/custom_themes.dart';
import '../../../utill/dimensions.dart';
import '../../baseWidget/rating_bar.dart';
import '../../baseWidget/title_row.dart';

class ProductDetails extends StatefulWidget {
  final String proDetailsUrl;

  ProductDetails({@required this.proDetailsUrl});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  ProductDetailsModel _productDetailsModel;

  getProductDetails() async {


    print("widget.proDetailsUrl"+widget.proDetailsUrl);
    var ProductDetailsResponse = await DashboardApiClient()
        .DashBoardProductDetails(widget.proDetailsUrl);
    // print("BJHEBCJERCBLER${categoryProductResponse[0].id}");

    if (ProductDetailsResponse != null) {
      setState(() {
        _productDetailsModel = ProductDetailsResponse;
        print("asdsd" + _productDetailsModel.toString());
      });

      return _productDetailsModel;
    } else {
      print("asdsd" + _productDetailsModel.toString());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(ProductDetailsResponse.toString()),
        backgroundColor: Colors.red,
      ));

    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getProductDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return _productDetailsModel != null? Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      appBar: AppBar(
        title: Row(children: [
          InkWell(
            child: Icon(Icons.arrow_back_ios,
                color: Theme.of(context).cardColor, size: 20),
            onTap: () => Navigator.pop(context),
          ),
          SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
          SizedBox(
            width: MediaQuery.of(context).size.width*0.8,
            child: Text(_productDetailsModel.data[0].name,
                style: robotoRegular.copyWith(
                    fontSize: 20, color: Theme.of(context).cardColor, overflow: TextOverflow.ellipsis)),
          ),
        ]),
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: null,
      ),
      bottomNavigationBar: BottomCartView(
          image: _productDetailsModel.data[0].thumbnailImage,
          higherPrice: _productDetailsModel.data[0].priceHighLow,
          lowerPrice: _productDetailsModel.data[0].unitPrice,
          proName: _productDetailsModel.data[0].name,
          ratingCount: _productDetailsModel.data[0].ratingCount.toString(),
          stock: _productDetailsModel.data[0].currentStock.toString(),
          description: _productDetailsModel.data[0].description,
          proId: _productDetailsModel.data[0].id.toString(),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            ProductImageView(
              image: _productDetailsModel.data[0].photos,
            ),
            Container(
              transform: Matrix4.translationValues(0.0, -25.0, 0.0),
              padding: EdgeInsets.only(top: Dimensions.FONT_SIZE_DEFAULT),
              decoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
                borderRadius: BorderRadius.only(
                    topLeft:
                        Radius.circular(Dimensions.PADDING_SIZE_EXTRA_LARGE),
                    topRight:
                        Radius.circular(Dimensions.PADDING_SIZE_EXTRA_LARGE)),
              ),
              child: Column(
                children: [
                  ProductTitleView(
                    name: _productDetailsModel.data[0].name,
                    priceLower: _productDetailsModel.data[0].mainPrice,
                    priceHigher: _productDetailsModel.data[0].priceHighLow,
                    ratingCount: _productDetailsModel.data[0].ratingCount.toString(),
                  ),

                  // (widget.product.details != null && widget.product.details.isNotEmpty) ?
                  Container(
                    height: 100,
                    margin: EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
                    padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                    child: ProductSpecification(
                        productSpecification: _productDetailsModel.data[0].description),
                  ),

                  // YoutubeVideoWidget(url: "widget.product.videoUrl"),

                  Container(
                      padding: EdgeInsets.symmetric(
                          vertical: Dimensions.PADDING_SIZE_DEFAULT,
                          horizontal: Dimensions.FONT_SIZE_DEFAULT),
                      decoration:
                          BoxDecoration(color: Theme.of(context).cardColor),
                      child: PromiseScreen()),

                  // widget.product.addedBy == 'seller' ? SellerView(sellerId: widget.product.userId.toString()) : SizedBox.shrink(),

                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
                    padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                    color: Theme.of(context).cardColor,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'customer reviews',
                            style: titilliumSemiBold.copyWith(
                                fontSize: Dimensions.FONT_SIZE_LARGE),
                          ),
                          SizedBox(
                            height: Dimensions.PADDING_SIZE_DEFAULT,
                          ),
                          Container(
                            width: 230,
                            height: 30,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(
                                  Dimensions.PADDING_SIZE_EXTRA_LARGE),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                RatingBarr(
                                  rating: double.parse(_productDetailsModel.data[0].ratingCount.toString()),
                                  size: 18,
                                ),
                                // SizedBox(
                                //     width: Dimensions.PADDING_SIZE_DEFAULT),
                                // Text(widget.categoryProductModel.ratingCount.toString()),
                                SizedBox(
                                    width: Dimensions.PADDING_SIZE_DEFAULT),
                                Text("out of 5"),
                              ],
                            ),
                          ),

                          SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                          // Text('dawdewdsac'),

                          //
                          // details.reviewList != null ? details.reviewList.length != 0 ? ReviewWidget(reviewModel: details.reviewList[0])
                          //     : SizedBox() : ReviewShimmer(),
                          // details.reviewList != null ? details.reviewList.length > 1 ? ReviewWidget(reviewModel: details.reviewList[1])
                          //     : SizedBox() : ReviewShimmer(),
                          // details.reviewList != null ? details.reviewList.length > 2 ? ReviewWidget(reviewModel: details.reviewList[2])
                          //     : SizedBox() : ReviewShimmer(),

                          InkWell(
                              onTap: () {
                                // if(details.reviewList != null)
                                // {Navigator.push(context, MaterialPageRoute(builder: (_) =>
                                //     ReviewScreen(reviewList: details.reviewList)));}
                              },
                              child: Text(
                                'view more',
                                style: titilliumRegular.copyWith(
                                    color: Theme.of(context).primaryColor),
                              ))
                        ]),
                  ),

                  Padding(
                    padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                    child: TitleRow(
                        title: 'more from the shop', isDetailsPage: true),
                  ),

                  // widget.product.addedBy == 'seller' ?
                  // Padding(padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  //   child: ProductView(isHomePage: true, productType: ProductType.SELLER_PRODUCT,
                  //       scrollController: _scrollController, sellerId: widget.product.userId.toString()),):SizedBox(),

                  Container(
                    margin: EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
                    padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                              vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                          child: TitleRow(
                              title: 'related_products', isDetailsPage: true),
                        ),
                        SizedBox(height: 5),
                        // RelatedProductView(
                        //   url: _productDetailsModel.data[0],
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ) : Container(height: 40,width: 40,child: Center(child: CircularProgressIndicator()));
  }
}
