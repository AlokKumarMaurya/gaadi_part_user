import 'package:flutter/material.dart';
import 'package:gaadi_part/helper/shared_preference.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../data/DAshboard Repository/dashboadRepository.dart';
import '../../../../data/model/response/Dashboard Categories/category_model.dart';
import '../../../../utill/dimensions.dart';
import '../../../../utill/images.dart';
import '../../../data/model/response/Dashboard Categories/brands_model.dart';
import '../../../data/model/response/Dashboard Categories/featuredProductmodel.dart';
import '../../../data/model/response/Dashboard Categories/todays_deal_model.dart';
import '../../baseWidget/custom_app_bar.dart';
import '../product/brand_and_category_product_screen.dart';
import '../product/product_details_screen.dart';

class ViewAllScreen extends StatefulWidget {
  final bool isHomePage;
  final String name;
  final List<CategoryModel> Category_Model;
  final BrandsModel brandsModel;
  final TodaysDealsModel TodaysDeals_Model;
  final FeaturedProductModel FeaturedProduct;
  const ViewAllScreen(
      {Key key, this.isHomePage, this.name, this.Category_Model, this.brandsModel, this.TodaysDeals_Model, this.FeaturedProduct})
      : super(key: key);

  @override
  State<ViewAllScreen> createState() => _ViewAllScreenState();
}

class _ViewAllScreenState extends State<ViewAllScreen> {
  @override
  Widget  build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF9F9F9),
        body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [

          CustomAppBar(title: widget.name),

          SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

          widget.name == "Categories"?getCategory(widget.Category_Model):SizedBox(),

          widget.name == "Brands"?getBrands(widget.brandsModel):SizedBox(),

          widget.name == "Todays Deal"?getTodaysDeals(widget.TodaysDeals_Model):SizedBox(),

          widget.name == "Featured Product"?getFeaturedProducts(widget.FeaturedProduct):SizedBox(),

          widget.name == "Best Selling"?getFeaturedProducts(widget.FeaturedProduct):SizedBox(),
        ])
    );
  }
}

Widget getCategory(List<CategoryModel> category_model) {
  return category_model!= null? GridView.builder(
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3,
      crossAxisSpacing: 15,
      mainAxisSpacing: 5,
      childAspectRatio: 1,
    ),
    itemCount: category_model.length,
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    itemBuilder: (BuildContext context, int index) {
      // print("imageUrl"+imageUrl);
      return InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) =>
                BrandAndCategoryProductScreen(
                  isBrand: false,
                  name: category_model[index].name,
                  productsUrl: category_model[index].links.products,
                )));
          },
          child:
          Column(children: [
            Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .width / 5,
              width: MediaQuery
                  .of(context)
                  .size
                  .width / 5,
              decoration: BoxDecoration(
                border: Border.all(color: Theme
                    .of(context)
                    .primaryColor
                    .withOpacity(.2)),
                borderRadius: BorderRadius.circular(
                    Dimensions.PADDING_SIZE_SMALL),
                color: Theme
                    .of(context)
                    .highlightColor,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                    Dimensions.PADDING_SIZE_SMALL),
                child: FadeInImage.assetNetwork(
                  fit: BoxFit.cover,
                  placeholder: Images.placeholder,
                  image: "https://softfix.in/demo/gaadipart/public/uploads/all/${ category_model[index].banner}",
                  imageErrorBuilder: (c, o, s) =>
                      Image.asset(Images.placeholder, fit: BoxFit.cover,),
                ),
              ),
            ),

            SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
            Container(
              child: Center(
                child: Text("${category_model[index].name}",
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: Dimensions.FONT_SIZE_SMALL,
                      color: Color(0xFF000743)),
                ),
              ),
            ),

          ])
        // ViewAllButton()
      );
    },
  ): SizedBox();
}

Widget getBrands(BrandsModel brandsModel){
  return brandsModel!= null? 
  Expanded(
    child: SingleChildScrollView(
      child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 15,
            mainAxisSpacing: 5,
            childAspectRatio: 1,
          ),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: brandsModel.data.length,

          itemBuilder: (BuildContext context,index) {
            return InkWell(
              onTap: () {

                Navigator.push(context, MaterialPageRoute(builder: (_) => BrandAndCategoryProductScreen(
                  isBrand: true,
                  name: brandsModel.data[index].name, productsUrl: brandsModel.data[index].links.products,
                )));
              },
              child: Padding(
                padding: EdgeInsets.only(right: 10),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: (MediaQuery
                            .of(context)
                            .size
                            .width / 5.9),
                        height: (MediaQuery
                            .of(context)
                            .size
                            .width / 5.9),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                              Radius.circular((MediaQuery
                                  .of(context)
                                  .size
                                  .width / 5))),
                          color: Theme
                              .of(context)
                              .highlightColor,
                        ),

                        child: ClipRRect(
                          borderRadius: BorderRadius.all(
                              Radius.circular((MediaQuery
                                  .of(context)
                                  .size
                                  .width / 5))),
                          child: FadeInImage.assetNetwork(
                            fit: BoxFit.cover,
                            placeholder: Images.placeholder,
                            image: "https://softfix.in/demo/gaadipart/public/${brandsModel.data[index].logo}",
                            imageErrorBuilder: (c, o, s) =>
                                Image.asset(
                                  Images.placeholder, fit: BoxFit.cover,),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: (MediaQuery
                            .of(context)
                            .size
                            .width / 4) * 0.3,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width / 4.2,
                        child: Center(child: Text(
                          brandsModel.data[index].name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: Dimensions.FONT_SIZE_SMALL),
                        )),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    ),
  ):SizedBox();
}

Widget getTodaysDeals(TodaysDealsModel todaysDeals_Model){
  return todaysDeals_Model != null?
  Expanded(
    child: SingleChildScrollView(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 15,
          mainAxisSpacing: 5,
          childAspectRatio: 1,
        ),
        itemCount: todaysDeals_Model.data.isEmpty?0: todaysDeals_Model.data.length,
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
                ProductDetails(proDetailsUrl: todaysDeals_Model.data[index].links.details),
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
                    image: 'https://softfix.in/demo/gaadipart/public/uploads/all/'+"${todaysDeals_Model.data[index].thumbnailImage}",
                    imageErrorBuilder: (c, o, s) => Image.asset(Images.placeholder, fit: BoxFit.cover,),
                  ),
                ),
              ),

              SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
              Container(
                child: Center(
                  child: Text(todaysDeals_Model.data[index].basePrice.toString(),
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
      ),
    ),
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

Widget getFeaturedProducts(FeaturedProductModel featuredProduct){
  return featuredProduct != null?
  Expanded(
    child: SingleChildScrollView(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 15,
          mainAxisSpacing: 5,
          childAspectRatio: 1,
        ),
        itemCount: featuredProduct.data.isNotEmpty? featuredProduct.data.length:0,
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
                  ProductDetails(proDetailsUrl: featuredProduct.data[index].links.details),
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
                      image: 'https://softfix.in/demo/gaadipart/public/'+"${featuredProduct.data[index].thumbnailImage}",
                      imageErrorBuilder: (c, o, s) => Image.asset(Images.placeholder, fit: BoxFit.cover,),
                    ),
                  ),
                ),

                SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                Container(
                  child: Center(
                    child: Text(featuredProduct.data[index].basePrice.toString(),
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
      ),
    ),
  ):
  GridView.builder(
      shrinkWrap: true,
      itemCount: 8,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 15,
        mainAxisSpacing: 5,
        childAspectRatio: 1,
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
