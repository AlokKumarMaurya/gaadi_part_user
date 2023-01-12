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

class BodyParts extends StatefulWidget {
  final bool isHomePage;

  BodyParts({@required this.isHomePage});

  @override
  State<BodyParts> createState() => _BodyPartsState();
}

class _BodyPartsState extends State<BodyParts> {
  FeaturedProductModel FeaturedProduct;
  bool isDataLoaded=false;
  // bool isbreakSuspension=BestSelling.isBreak;

  latestProduct() async {
    // print(BestSelling().isBreak);
    // print(BestSelling().isHomePage);

    print("feature featured featured");
    // var link=(isbreakSuspension)?Uri.parse(AppConstants.BEST_SELLING_PRODUCTS_URI):Uri.parse(AppConstants.BEST_SELLING_PRODUCTS_URI);
    var featureProductResponse = await DashboardApiClient().DashBoardFeaturedProduct(Uri.parse(AppConstants.BREAK_AND_SUSPENSION));
    print("feature featured featured");
    if (featureProductResponse!= null) {
      print("feature featured featured");
      setState(() {
        isDataLoaded=true;
        FeaturedProduct = featureProductResponse;
        // print("asdassdsdaasdadssda"+todaysDealsResponse.data.toString());
      });
      return featureProductResponse;
    } else {
      print("else featured featured");
      print(featureProductResponse);
      // print("asdas"+todaysDealsResponse.data.toString());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(featureProductResponse.toString()),
        backgroundColor: Colors.red,
      ));
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    print("asdasddsadasdasasasdadinit");
    latestProduct();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  (isDataLoaded)?
    GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 15,
        mainAxisSpacing: 5,
        childAspectRatio: (1/1.3),
      ),
      itemCount: FeaturedProduct.data.isNotEmpty? (FeaturedProduct.data.length >5)?6:FeaturedProduct.data.length:0,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {

        return (index!=5)?
        InkWell(
          onTap: () {

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
                  image: 'https://softfix.in/demo/gaadipart/public/'+"${FeaturedProduct.data[index].thumbnailImage}",
                  imageErrorBuilder: (c, o, s) => Image.asset(Images.placeholder, fit: BoxFit.cover,),
                ),
              ),
            ),

            SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
            Container(
              child: Center(
                child: Text(FeaturedProduct.data[index].basePrice.toString(),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: Dimensions.FONT_SIZE_SMALL,
                      color:  Color(0xFF000743)),
                ),
              ),
            ),

          ]),
        ):ViewAllButton();

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
        });;
  }
}


