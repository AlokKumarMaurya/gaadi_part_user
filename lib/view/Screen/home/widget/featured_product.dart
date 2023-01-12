import 'package:flutter/material.dart';
import 'package:gaadi_part/data/model/response/Dashboard%20Categories/featuredProductmodel.dart';
import 'package:gaadi_part/helper/shared_preference.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../data/DAshboard Repository/dashboadRepository.dart';
import '../../../../data/model/response/Dashboard Categories/category_model.dart';
import '../../../../data/model/response/Dashboard Categories/featuredProductmodel.dart';
import '../../../../data/model/response/Dashboard Categories/todays_deal_model.dart';
import '../../../../utill/app_constants.dart';
import '../../../../utill/dimensions.dart';
import '../../../../utill/images.dart';
import '../../../baseWidget/view_all_button.dart';
import '../../product/product_details_screen.dart';

class FeaturedProductView extends StatefulWidget {
  final bool isHomePage;
  final   FeaturedProductModel FeaturedProduct;
  FeaturedProductView({@required this.isHomePage, this.FeaturedProduct});

  @override
  State<FeaturedProductView> createState() => _FeaturedProductViewState();
}

class _FeaturedProductViewState extends State<FeaturedProductView> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.FeaturedProduct != null?
    GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 15,
        mainAxisSpacing: 5,
        childAspectRatio: 1,
      ),
      itemCount: widget.FeaturedProduct.data.isNotEmpty? (widget.FeaturedProduct.data.length >5)?6:widget.FeaturedProduct.data.length:0,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {

        return
          InkWell(
          onTap: () {
            Navigator.push(context, PageRouteBuilder(
              transitionDuration: Duration(milliseconds: 0),
              pageBuilder: (context, anim1, anim2) =>
              // ProductDetails(product: productModel),
              ProductDetails(proDetailsUrl: widget.FeaturedProduct.data[index].links.details),
            ));
          },
          child: Column( children: [
            Container(
              height: MediaQuery.of(context).size.width/5,
              width: MediaQuery.of(context).size.width/5,
              decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).primaryColor.withOpacity(.2)),
                borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_SMALL),
                color: Theme.of(context).highlightColor,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_SMALL),
                child: FadeInImage.assetNetwork(
                  fit: BoxFit.cover,
                  placeholder: Images.placeholder,
                  image: 'https://softfix.in/demo/gaadipart/public/'+"${widget.FeaturedProduct.data[index].thumbnailImage}",
                  imageErrorBuilder: (c, o, s) => Image.asset(Images.placeholder, fit: BoxFit.cover,),
                ),
              ),
            ),

            SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
            Container(
              child: Center(
                child: Text(widget.FeaturedProduct.data[index].basePrice.toString(),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: Dimensions.FONT_SIZE_SMALL,
                      color:  Color(0xFF000743)),
                ),
              ),
            ),

          ]),
        );

      },
    ):
    GridView.builder(
        shrinkWrap: true,
        itemCount: 8,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 15,
          mainAxisSpacing: 5,
          childAspectRatio: (1/1.3),
        ),
        itemBuilder: (context,_){
          return
            Shimmer.fromColors(child:Container(height: MediaQuery.of(context).size.width/5,
                width: MediaQuery.of(context).size.width/5, decoration: BoxDecoration(
                  border: Border.all(color: Theme.of(context).primaryColor.withOpacity(.2)),
                  borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_SMALL),
                  color: Theme.of(context).highlightColor,
                )),  baseColor: Colors.grey.shade300,
                highlightColor: Colors.white);
        });
  }
}


