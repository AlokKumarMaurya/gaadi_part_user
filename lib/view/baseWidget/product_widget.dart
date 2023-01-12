import 'package:flutter/material.dart';
import 'package:gaadi_part/view/baseWidget/rating_bar.dart';
import '../../data/model/response/RelatedProductModel.dart';
import '../../data/model/response/brands_products_model.dart';
import '../../utill/custom_themes.dart';
import '../../utill/dimensions.dart';
import '../../utill/images.dart';
import '../Screen/product/product_details_screen.dart';

class ProductWidget extends StatelessWidget {

    BrandsAndProductsModel brandsAndProductsModel ;
   final bool fromRelated;
   int index;
  ProductWidget({this.index, this.fromRelated, this.brandsAndProductsModel});
  // ProductWidget();

  @override
  Widget build(BuildContext context) {
      return InkWell(
        onTap: () {
          Navigator.push(context, PageRouteBuilder(
            transitionDuration: Duration(milliseconds: 0),
            pageBuilder: (context, anim1, anim2) =>
            // ProductDetails(product: productModel),
            ProductDetails(proDetailsUrl: brandsAndProductsModel.data[index].links.details),
          ));
        },
        child: Container(
          height: MediaQuery.of(context).size.width/1.5,
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).highlightColor,
            boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), spreadRadius: 1, blurRadius: 5)],
          ),
          child: Stack(children: [
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              // Product Image
              Container(
                height: MediaQuery.of(context).size.width/2.45,
                decoration: BoxDecoration(
                  color: Color(0xFFF9F9F9),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                  child: FadeInImage.assetNetwork(
                    placeholder: Images.placeholder, fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.width/2.45,
                    // image: 'https://softfix.in/demo/gaadipart/public/${fromRelated? relatedProductsModel.data[index].thumbnailImage:categoryProductModel.thumbnailImage}',
                    image: 'https://softfix.in/demo/gaadipart/public/${brandsAndProductsModel.data[index].thumbnailImage}',
                    imageErrorBuilder: (c, o, s) => Image.asset(Images.placeholder_1x1,
                        fit: BoxFit.cover,height: MediaQuery.of(context).size.width/2.45),
                  ),
                ),
              ),

              // Product Details
              Padding(
                padding: EdgeInsets.only(top :Dimensions.PADDING_SIZE_SMALL,bottom: 5, left: 5,right: 5),
                child: Container(

                  child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(brandsAndProductsModel.data[index].name, textAlign: TextAlign.center,
                              style: robotoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL,
                                  fontWeight: FontWeight.w400), maxLines: 2,
                              overflow: TextOverflow.ellipsis),
                          SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),

                          Row(mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RatingBarr(
                                  rating: double.parse(brandsAndProductsModel.data[index].rating.toString()),
                                  size: 18,
                                ),


                                Text(brandsAndProductsModel.data[index].rating.toString(),
                                    style: robotoRegular.copyWith(
                                      fontSize: Dimensions.FONT_SIZE_SMALL,
                                    )),

                              ]),
                          SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),

                          Text(brandsAndProductsModel.data[index].basePrice,
                            style: titleRegular.copyWith(
                              color: Colors.red,
                              decoration: TextDecoration.lineThrough,

                              fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                            ),
                          ),
                          SizedBox(height: 2,),


                          // fromRelated!=true? Text(categoryProductModel.priceHigher.toString(),
                          //   style: titilliumSemiBold.copyWith(color: Theme.of(context).primaryColor,
                          //   ),
                          //
                          //
                          //
                          // ):Container()
                        ],
                      )
                  ),
                ),
              ),
            ]),

            // Off


            Positioned(top: 0, left: 0, child: Container(
              height: 20,
              padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
              ),


              child: Center(
                child: Text('1001',
                  style: robotoRegular.copyWith(color: Theme.of(context).highlightColor,
                      fontSize: Dimensions.FONT_SIZE_SMALL),
                ),
              ),
            ),
            ) ,

          ]),
        ),
      );


  }
}
