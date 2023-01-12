import 'package:flutter/material.dart';
import 'package:gaadi_part/data/DAshboard%20Repository/dashboadRepository.dart';
import 'package:gaadi_part/data/repository/auth_repo.dart';
import 'package:gaadi_part/helper/shared_preference.dart';
import 'package:gaadi_part/view/Screen/cart/cart_controller.dart';
import 'package:gaadi_part/view/Screen/home/view_all_screen.dart';
import 'package:gaadi_part/view/Screen/home/widget/banner_view.dart';
import 'package:gaadi_part/view/Screen/home/widget/bodyParts.dart';
import 'package:gaadi_part/view/Screen/home/widget/brand_view.dart';
import 'package:gaadi_part/view/Screen/home/widget/breaksAndSuspension.dart';
import 'package:gaadi_part/view/Screen/home/widget/category_view.dart';
import 'package:gaadi_part/view/Screen/home/widget/featured_product.dart';
import 'package:gaadi_part/view/Screen/home/widget/latestProduct.dart';
import 'package:gaadi_part/view/Screen/home/widget/todays_deals.dart';
import 'package:get/get.dart';

import 'package:provider/provider.dart';

import '../../../data/model/response/Dashboard Categories/brands_model.dart';
import '../../../data/model/response/Dashboard Categories/category_model.dart';
import '../../../data/model/response/Dashboard Categories/featuredProductmodel.dart';
import '../../../data/model/response/Dashboard Categories/todays_deal_model.dart';
import '../../../data/model/response/config_model.dart';
import '../../../utill/app_constants.dart';
import '../../../utill/dimensions.dart';
import '../../../utill/images.dart';
import '../cart/cart_screen.dart';
import '../search/search_screen.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  final _cartController = Get.put(CartController());
  ConfigModel Config_Model;
  List<CategoryModel> Category_Model;
  BrandsModel _brandsModel;
  FeaturedProductModel FeaturedProduct;
  FeaturedProductModel BestSellingProduct;
  TodaysDealsModel TodaysDeals_Model;
  var isGuest;

  void passData(int index, String title) {
    index = index;
    title = title;
  }

  configModel() async {
    var configModelResponse = await DashboardApiClient().Config();

    if (configModelResponse != null) {
      setState(() {
        Config_Model = configModelResponse;
      });
      HelperFunction.saveCategory_image_url(
          Config_Model.baseUrls.categoryImageUrl);
      HelperFunction.saveProductThumnail_image_url(
          Config_Model.baseUrls.productThumbnailUrl);
      HelperFunction.saveBrand_image_url(Config_Model.baseUrls.brandImageUrl);
      // print("dkjfgdk${ await HelperFunction.getCategory_image_url()}");
      return Config_Model;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(configModelResponse.toString()),
        backgroundColor: Colors.red,
      ));
    }
  }

  categories() async {
    var categoryResponse = await DashboardApiClient().DashBoardAllCategories();

    if (categoryResponse != null) {
      setState(() {
        // isDataLoaded=true;
        Category_Model = categoryResponse;
        print("asdsd" + Category_Model.toString());
      });
      // imageUrl = await HelperFunction.getCategory_image_url();
      return Category_Model;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(categoryResponse.toString()),
        backgroundColor: Colors.red,
      ));
    }
  }

  getBrands() async {
    var brandsResponse = await DashboardApiClient().DashBoardBrands();

    if (brandsResponse != null) {
      setState(() {
        _brandsModel = brandsResponse;

        print("#2131" + brandsResponse.data.toString());
      });
      return _brandsModel;
    } else {
      print("asdas" + brandsResponse.data.toString());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(brandsResponse.toString()),
        backgroundColor: Colors.red,
      ));
    }
  }

  todaysDeals() async {
    print("ghusa");
    var todaysDealsResponse = await DashboardApiClient().DashBoardTodaysDeals();

    if (todaysDealsResponse != null) {
      setState(() {
        TodaysDeals_Model = todaysDealsResponse;
        print("asdassdsdaasdadssda" + todaysDealsResponse.data.toString());
      });
      return todaysDealsResponse;
    } else {
      print("asdas" + todaysDealsResponse.data.toString());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(todaysDealsResponse.toString()),
        backgroundColor: Colors.red,
      ));
    }
  }

  featuredProduct() async {
    print("feature featured featured");
    var featureProductResponse = await DashboardApiClient()
        .DashBoardFeaturedProduct(AppConstants.FEATURED_PRODUCTS_URI);
    print("feature featured featured");
    if (featureProductResponse != null) {
      print("feature featured featured");
      setState(() {
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

  latestProduct() async {
    // print(BestSelling().isBreak);
    // print(BestSelling().isHomePage);

    print("feature featured featured");
    // var link=(isbreakSuspension)?Uri.parse(AppConstants.BEST_SELLING_PRODUCTS_URI):Uri.parse(AppConstants.BEST_SELLING_PRODUCTS_URI);
    var featureProductResponse = await DashboardApiClient()
        .DashBoardFeaturedProduct(AppConstants.BEST_SELLING_PRODUCTS_URI);
    print("feature featured featured");
    if (featureProductResponse != null) {
      print("feature featured featured");
      setState(() {
        BestSellingProduct = featureProductResponse;
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

  _loadData() async {
    isGuest = await DashboardApiClient().isGuest();
    print('jhadguwhbdouqwdw${isGuest.toString()}');

    print("213123124");
    configModel();
    categories();
    getBrands();
    todaysDeals();
    featuredProduct();
    latestProduct();
  }

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<String> types = [
      'new_arrival',
      'top_product',
      'best_selling',
      'discounted_product',
    ];
    return Scaffold(
      //backgroundColor: Color(0xFFFCFCFC),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: RefreshIndicator(
          backgroundColor: Theme.of(context).primaryColor,
          onRefresh: () async {
            return true;
          },
          child: Stack(
            children: [
              CustomScrollView(
                controller: _scrollController,
                slivers: [
                  // App Bar
                  SliverAppBar(
                    floating: true,
                    elevation: 0,
                    centerTitle: false,
                    automaticallyImplyLeading: false,
                    backgroundColor: Theme.of(context).highlightColor,
                    title: Image.asset(Images.logo_with_name_image, height: 35),
                    actions: [
                      Padding(
                        padding: const EdgeInsets.only(right: 12.0),
                        child: IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => CartScreen()));
                          },
                          icon: Stack(clipBehavior: Clip.none, children: [
                            Image.asset(
                              Images.cart_arrow_down_image,
                              height: Dimensions.ICON_SIZE_DEFAULT,
                              width: Dimensions.ICON_SIZE_DEFAULT,
                              color: Theme.of(context).primaryColor,
                            ),
                            Positioned(
                              top: -4,
                              right: -4,
                              child: CircleAvatar(
                                  radius: 7,
                                  backgroundColor: Colors.red,
                                  child: Obx(() => Text(
                                        isGuest.toString().isEmpty
                                            ? '0'
                                            : _cartController.cartLength
                                                .toString(),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize:
                                              Dimensions.FONT_SIZE_EXTRA_SMALL,
                                        ),
                                      ))),
                            ),
                          ]),
                        ),
                      ),
                    ],
                  ),

                  // Search Button
                  // SliverPersistentHeader(
                  //
                  //     // pinned: true,
                  //     delegate: SliverDelegate(
                  //         child:   Container()
                  //     //     InkWell(
                  //     //   onTap: () => Navigator.push(context,
                  //     //       MaterialPageRoute(builder: (_) => SearchScreen())),
                  //     //   child: Container(
                  //     //     padding: EdgeInsets.symmetric(
                  //     //         horizontal: Dimensions.HOME_PAGE_PADDING,
                  //     //         vertical: Dimensions.PADDING_SIZE_SMALL),
                  //     //     //  color: Color(0xFFFCFCFC),
                  //     //     alignment: Alignment.center,
                  //     //     child: Container(
                  //     //       padding: EdgeInsets.only(
                  //     //         left: Dimensions.HOME_PAGE_PADDING,
                  //     //         right: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                  //     //         top: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                  //     //         bottom: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                  //     //       ),
                  //     //       height: 60,
                  //     //       alignment: Alignment.centerLeft,
                  //     //       decoration: BoxDecoration(
                  //     //         color: Theme.of(context).cardColor,
                  //     //         boxShadow: [
                  //     //           BoxShadow(
                  //     //               color: Colors.grey[200],
                  //     //               spreadRadius: 1,
                  //     //               blurRadius: 1)
                  //     //         ],
                  //     //         borderRadius: BorderRadius.circular(
                  //     //             Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  //     //       ),
                  //     //       child: Row(
                  //     //           mainAxisAlignment:
                  //     //               MainAxisAlignment.spaceBetween,
                  //     //           children: [
                  //     //             Text(
                  //     //               'SEARCH_HINT',
                  //     //             ),
                  //     //             Container(
                  //     //               width: 40,
                  //     //               height: 40,
                  //     //               decoration: BoxDecoration(
                  //     //                   color: Theme.of(context).primaryColor,
                  //     //                   borderRadius: BorderRadius.all(
                  //     //                       Radius.circular(Dimensions
                  //     //                           .PADDING_SIZE_EXTRA_SMALL))),
                  //     //               child: Icon(Icons.search,
                  //     //                   color: Theme.of(context).cardColor,
                  //     //                   size: Dimensions.ICON_SIZE_SMALL),
                  //     //             ),
                  //     //           ]),
                  //     //     ),
                  //     //   ),
                  //     // )
                  //     )),

                
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(
                          Dimensions.HOME_PAGE_PADDING,
                          // Dimensions.PADDING_SIZE_SMALL,
                          0,
                          Dimensions.PADDING_SIZE_DEFAULT,
                          Dimensions.PADDING_SIZE_SMALL),
                      child: Column(
                        children: [
                          SizedBox(height: 29,),
                          BannersView(),
                          const SizedBox(height: Dimensions.HOME_PAGE_PADDING),

                          // Category
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Categories",
                                  style: TextStyle(
                                      fontSize: Dimensions.FONT_SIZE_LARGE,
                                      fontWeight: FontWeight.bold)),
                              InkWell(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ViewAllScreen(
                                            Category_Model: Category_Model,
                                            isHomePage: true,
                                            name: "Categories"))),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('VIEW ALL',
                                          style: TextStyle(
                                              color: Colors.orange,
                                              fontSize: Dimensions
                                                  .FONT_SIZE_DEFAULT)),
                                      Icon(
                                        Icons.arrow_forward_outlined,
                                        color: Colors.orange,
                                        size: Dimensions.FONT_SIZE_DEFAULT,
                                      ),
                                    ]),
                              ),
                            ],
                          ),
                          const SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: Dimensions.HOME_PAGE_PADDING),
                            child: CategoryView(
                                isHomePage: true,
                                Category_Model: Category_Model),
                          ),

                          const SizedBox(height: Dimensions.HOME_PAGE_PADDING),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Brands",
                                  style: TextStyle(
                                      fontSize: Dimensions.FONT_SIZE_LARGE,
                                      fontWeight: FontWeight.bold)),
                              InkWell(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ViewAllScreen(
                                            brandsModel: _brandsModel,
                                            isHomePage: true,
                                            name: "Brands"))),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('VIEW ALL',
                                          style: TextStyle(
                                              color: Colors.orange,
                                              fontSize: Dimensions
                                                  .FONT_SIZE_DEFAULT)),
                                      Icon(
                                        Icons.arrow_forward_outlined,
                                        color: Colors.orange,
                                        size: Dimensions.FONT_SIZE_DEFAULT,
                                      ),
                                    ]),
                              ),
                            ],
                          ),
                          SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                          BrandView(
                              isHomePage: true, brandsModel: _brandsModel),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Todays Deal",
                                  style: TextStyle(
                                      fontSize: Dimensions.FONT_SIZE_LARGE,
                                      fontWeight: FontWeight.bold)),
                              InkWell(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ViewAllScreen(
                                            TodaysDeals_Model:
                                                TodaysDeals_Model,
                                            isHomePage: true,
                                            name: "Todays Deal"))),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('VIEW ALL',
                                          style: TextStyle(
                                              color: Colors.orange,
                                              fontSize: Dimensions
                                                  .FONT_SIZE_DEFAULT)),
                                      Icon(
                                        Icons.arrow_forward_outlined,
                                        color: Colors.orange,
                                        size: Dimensions.FONT_SIZE_DEFAULT,
                                      ),
                                    ]),
                              ),
                            ],
                          ),
                          const SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: Dimensions.HOME_PAGE_PADDING),
                            child: TodaysDeals(
                                isHomePage: true,
                                TodaysDeals_Model: TodaysDeals_Model),
                          ),

                          const SizedBox(height: Dimensions.HOME_PAGE_PADDING),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Featured Product",
                                  style: TextStyle(
                                      fontSize: Dimensions.FONT_SIZE_LARGE,
                                      fontWeight: FontWeight.bold)),
                              InkWell(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ViewAllScreen(
                                            FeaturedProduct: FeaturedProduct,
                                            isHomePage: true,
                                            name: "Featured Product"))),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('VIEW ALL',
                                          style: TextStyle(
                                              color: Colors.orange,
                                              fontSize: Dimensions
                                                  .FONT_SIZE_DEFAULT)),
                                      Icon(
                                        Icons.arrow_forward_outlined,
                                        color: Colors.orange,
                                        size: Dimensions.FONT_SIZE_DEFAULT,
                                      ),
                                    ]),
                              ),
                            ],
                          ),
                          const SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: Dimensions.HOME_PAGE_PADDING),
                            child: FeaturedProductView(
                                isHomePage: true,
                                FeaturedProduct: FeaturedProduct),
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Best Selling",
                                  style: TextStyle(
                                      fontSize: Dimensions.FONT_SIZE_LARGE,
                                      fontWeight: FontWeight.bold)),
                              InkWell(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ViewAllScreen(
                                            FeaturedProduct: BestSellingProduct,
                                            isHomePage: true,
                                            name: "Best Selling"))),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('VIEW ALL',
                                          style: TextStyle(
                                              color: Colors.orange,
                                              fontSize: Dimensions
                                                  .FONT_SIZE_DEFAULT)),
                                      Icon(
                                        Icons.arrow_forward_outlined,
                                        color: Colors.orange,
                                        size: Dimensions.FONT_SIZE_DEFAULT,
                                      ),
                                    ]),
                              ),
                            ],
                          ),
                          const SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: Dimensions.HOME_PAGE_PADDING),
                            child: BestSelling(
                                isHomePage: true,
                                FeaturedProduct: BestSellingProduct),
                          ),

                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     Text("Breaks and Suspensons",
                          //         style: TextStyle(
                          //             fontSize: Dimensions.FONT_SIZE_DEFAULT)),
                          //     Row(
                          //         mainAxisAlignment: MainAxisAlignment.center,
                          //         children: [
                          //           Text('VIEW_ALL',
                          //               style: TextStyle(
                          //                   color: Colors.orange,
                          //                   fontSize:
                          //                   Dimensions.FONT_SIZE_DEFAULT)),
                          //           Icon(
                          //             Icons.arrow_forward_outlined,
                          //             color: Colors.orange,
                          //             size: Dimensions.FONT_SIZE_DEFAULT,
                          //           ),
                          //         ]),
                          //   ],
                          // ),
                          // const SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                          //
                          // Padding(
                          //   padding: const EdgeInsets.only(
                          //       bottom: Dimensions.HOME_PAGE_PADDING),
                          //   child: BreakAndSuspension(isHomePage: true),
                          // ),
                          //
                          //
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     Text("Bodyparts and Mirrors",
                          //         style: TextStyle(
                          //             fontSize: Dimensions.FONT_SIZE_DEFAULT)),
                          //     Row(
                          //         mainAxisAlignment: MainAxisAlignment.center,
                          //         children: [
                          //           Text('VIEW_ALL',
                          //               style: TextStyle(
                          //                   color: Colors.orange,
                          //                   fontSize:
                          //                   Dimensions.FONT_SIZE_DEFAULT)),
                          //           Icon(
                          //             Icons.arrow_forward_outlined,
                          //             color: Colors.orange,
                          //             size: Dimensions.FONT_SIZE_DEFAULT,
                          //           ),
                          //         ]),
                          //   ],
                          // ),
                          // const SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                          //
                          // Padding(
                          //   padding: const EdgeInsets.only(
                          //       bottom: Dimensions.HOME_PAGE_PADDING),
                          //   child: BodyParts(isHomePage: true),
                          // ),

                          const SizedBox(height: Dimensions.HOME_PAGE_PADDING),
                        ],
                      ),
                    ),
                  )
                ],
              ),

              // Provider.of<SplashProvider>(context, listen: false).configModel.announcement.status == '1'?
              // Positioned(top: MediaQuery.of(context).size.height-128,
              //   left: 0,right: 0,
              //   child: Consumer<SplashProvider>(
              //     builder: (context, announcement, _){
              //       return (announcement.configModel.announcement.announcement != null && announcement.onOff)?
              //       AnnouncementScreen(announcement: announcement.configModel.announcement):SizedBox();
              //     },
              //
              //   ),
              // ):SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}

class SliverDelegate extends SliverPersistentHeaderDelegate {
  Widget child;

  SliverDelegate({@required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => 70;

  @override
  double get minExtent => 70;

  @override
  bool shouldRebuild(SliverDelegate oldDelegate) {
    return oldDelegate.maxExtent != 70 ||
        oldDelegate.minExtent != 70 ||
        child != oldDelegate.child;
  }
}
