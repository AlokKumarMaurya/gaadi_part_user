import 'package:flutter/material.dart';
import 'package:gaadi_part/helper/shared_preference.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../data/model/response/Dashboard Categories/brands_model.dart';
import '../../../../utill/dimensions.dart';
import '../../../../utill/images.dart';
import '../../product/brand_and_category_product_screen.dart';

class BrandView extends StatefulWidget {
  final bool isHomePage;
  final BrandsModel brandsModel;
  BrandView({Key key, @required this.isHomePage, this.brandsModel}) : super(key: key);

  @override
  State<BrandView> createState() => _BrandViewState();
}

class _BrandViewState extends State<BrandView> {

  // getBrands() async {
  //   var brandsResponse = await DashboardApiClient().DashBoardBrands();
  //
  //   if (brandsResponse != null) {
  //     setState(() {
  //       _brandsModel = brandsResponse;
  //
  //       print("#2131"+brandsResponse.data.toString());
  //     });
  //     return _brandsModel;
  //   } else {
  //     print("asdas"+brandsResponse.data.toString());
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //       content: Text(brandsResponse.toString()),
  //       backgroundColor: Colors.red,
  //     ));
  //   }
  // }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.brandsModel != null? ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 130),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.brandsModel.data.length,
          itemBuilder: (ctx,index) {
            return InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => BrandAndCategoryProductScreen(
                  isBrand: true,
                  name: widget.brandsModel.data[index].name, productsUrl: widget.brandsModel.data[index].links.products,
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
                            image: "https://softfix.in/demo/gaadipart/public/${widget.brandsModel.data[index].logo}",
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
                          widget.brandsModel.data[index].name,
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
    ): BrandShimmer();
  }
}

class BrandShimmer extends StatelessWidget {
  final bool isHomePage;
  BrandShimmer({ this.isHomePage});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: (1/1.3),
        mainAxisSpacing: 10,
        crossAxisSpacing: 5,
      ),
      itemCount: 4,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {

        return Shimmer.fromColors(
          baseColor: Colors.grey[300],
          highlightColor: Colors.grey[100],
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Expanded(child: Container(decoration: BoxDecoration(color: Color(0xffFFFFFF), shape: BoxShape.circle))),
            Container(height: 10, color: Color(0xffFFFFFF), margin: EdgeInsets.only(left: 25, right: 25)),
          ]),
        );

      },
    );
  }
}
