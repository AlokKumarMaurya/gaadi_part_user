import 'package:flutter/material.dart';
import 'package:gaadi_part/helper/shared_preference.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../data/DAshboard Repository/dashboadRepository.dart';
import '../../../../data/model/response/Dashboard Categories/category_model.dart';
import '../../../../utill/dimensions.dart';
import '../../../../utill/images.dart';
import '../../../baseWidget/view_all_button.dart';
import '../../product/brand_and_category_product_screen.dart';

class CategoryView extends StatefulWidget {
  final bool isHomePage;
  List<CategoryModel> Category_Model;
  CategoryView({@required this.isHomePage, this.Category_Model});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {

  // var isDataLoaded=false;
  // String imageUrl='';
  // categories() async {
  //   var categoryResponse = await DashboardApiClient().DashBoardAllCategories();
  //
  //   if (categoryResponse != null) {
  //     setState(() {
  //       isDataLoaded=true;
  //       Category_Model = categoryResponse ;
  //       print("asdsd"+Category_Model.toString());
  //
  //     });
  //     imageUrl = await HelperFunction.getCategory_image_url();
  //     return Category_Model;
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //       content: Text(categoryResponse.toString()),
  //       backgroundColor: Colors.red,
  //     ));
  //   }
  // }
  initState(){
    // categories();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return
      widget.Category_Model!= null?
    GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 15,
        mainAxisSpacing: 5,
        childAspectRatio: 1,
      ),
      itemCount: (widget.Category_Model.length >5)?6:widget.Category_Model.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {

        // print("imageUrl"+imageUrl);
        return InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => BrandAndCategoryProductScreen(
                isBrand: false,
                name: widget.Category_Model[index].name, productsUrl: widget.Category_Model[index].links.products,
              )));
            },
            child:
            Column( children: [
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
                    image: "https://softfix.in/demo/gaadipart/public/uploads/all/${ widget.Category_Model[index].banner}",
                    imageErrorBuilder: (c, o, s) => Image.asset(Images.placeholder, fit: BoxFit.cover,),
                  ),
                ),
              ),

              SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
              Container(
                child: Center(
                  child: Text("${widget.Category_Model[index].name}",
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: Dimensions.FONT_SIZE_SMALL,
                        color:  Color(0xFF000743)),
                  ),
                ),
              ),

            ])
            // ViewAllButton()
        );

      },
    ):
    GridView.builder(
        shrinkWrap: true,
        itemCount: 6,
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
}