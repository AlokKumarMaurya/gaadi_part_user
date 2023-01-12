import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../../constantWiget/no_data.dart';
import '../../../data/DAshboard Repository/dashboadRepository.dart';
import '../../../data/model/response/brands_products_model.dart';
import '../../../utill/dimensions.dart';
import '../../../utill/images.dart';
import '../../baseWidget/custom_app_bar.dart';
import '../../baseWidget/product_widget.dart';

class BrandAndCategoryProductScreen extends StatefulWidget {
  final bool isBrand;
  final String name;
  final String productsUrl;

  BrandAndCategoryProductScreen({@required this.isBrand, @required this.name, @required this.productsUrl});

  @override
  State<BrandAndCategoryProductScreen> createState() => _BrandAndCategoryProductScreenState();
}

class _BrandAndCategoryProductScreenState extends State<BrandAndCategoryProductScreen> {

  BrandsAndProductsModel _brandsAndProductsModel ;

  getProducts() async {
    var BrandsAndProductResponse = await DashboardApiClient().DashBoardProductsCategory(widget.productsUrl);

    if (BrandsAndProductResponse != null) {
      setState(() {
        _brandsAndProductsModel = BrandsAndProductResponse ;
        print("asdsd"+_brandsAndProductsModel.toString());

      });
      return _brandsAndProductsModel;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(BrandsAndProductResponse.toString()),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Provider.of<ProductProvider>(context, listen: false).initBrandOrCategoryProductList(isBrand, id, context);
    return Scaffold(
      backgroundColor: Color(0xFFF9F9F9),
      body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [

        CustomAppBar(title: widget.name,),

        widget.isBrand ? Container(height: 100,
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
          margin: EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
          color: Theme.of(context).highlightColor,
          child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            FadeInImage.assetNetwork(
              placeholder: Images.placeholder, width: 80, height: 80, fit: BoxFit.cover,
              image: 'https://softfix.in/demo/gaadipart/public/',
              imageErrorBuilder: (c, o, s) => Image.asset(Images.placeholder, width: 80, height: 80, fit: BoxFit.cover),
            ),
            SizedBox(width: Dimensions.PADDING_SIZE_SMALL),


            Text(widget.name, style: TextStyle(fontSize: Dimensions.FONT_SIZE_LARGE)),
          ]),
        ) : SizedBox.shrink(),

        SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

        // Products
        _brandsAndProductsModel!= null?
        _brandsAndProductsModel.data.length!=0? Expanded(
          child: StaggeredGridView.countBuilder(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
            physics: BouncingScrollPhysics(),
            crossAxisCount: 2,
            itemCount: _brandsAndProductsModel.data.length ?? 0,
            shrinkWrap: true,
            staggeredTileBuilder: (int index) => const StaggeredTile.fit(1),
            itemBuilder: (BuildContext context, int index) {
              // return ProductWidget(productModel: productProvider.brandOrCategoryProductList[index]);
              return ProductWidget(index: index,fromRelated: false,brandsAndProductsModel: _brandsAndProductsModel,);
            },
          ),
        ):Container(child: Center(child: NoData()),)

            :Center(heightFactor:15,child: CircularProgressIndicator()),

        // Expanded(child: Center(child: productProvider.hasData ?
        //
        // ProductShimmer(isHomePage: false,
        //     isEnabled: Provider.of<ProductProvider>(context).brandOrCategoryProductList.length == 0)
        //     : NoInternetOrDataScreen(isNoInternet: false),
        // )),

      ])
    );
  }
}