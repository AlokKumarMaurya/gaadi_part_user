import 'dart:async';
import 'dart:convert';
import 'package:gaadi_part/helper/shared_preference.dart';
import 'package:gaadi_part/utill/app_constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../model/body/userInfoModal.dart';
import '../model/response/Dashboard Categories/brands_model.dart';
import '../model/response/Dashboard Categories/category_model.dart';
import '../model/response/Dashboard Categories/featuredProductmodel.dart';
import '../model/response/Dashboard Categories/mainBanner_model.dart';
import '../model/response/Dashboard Categories/todays_deal_model.dart';
import '../model/response/Order/all_order_list.dart';
import '../model/response/Order/order_details_modal.dart';
import '../model/response/Order/order_list_response.dart';
import '../model/response/Order/order_placed.dart';
import '../model/response/RelatedProductModel.dart';
import '../model/response/brands_products_model.dart';
import '../model/response/cart/add_to_cart_model.dart';
import '../model/response/cart/get_cart_model.dart';
import '../model/response/config_model.dart';
import '../model/response/getAllAddress.dart';
import '../model/response/htmlModal.dart';
import '../model/response/product_details_model.dart';

class DashboardApiClient {
  static var client = http.Client();

  isGuest() async {
    var token = await HelperFunction.getToken();
    return token;
  }

  FutureOr<UserInfo> MoreUserInfo() async {
    // String SharedPreferencesUserIdKey = "UserIdKey";
    // String SharedPreferencestokenKey = "TokenKey";
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // var id=await preferences.getString(SharedPreferencesUserIdKey);
    // var token=await preferences.getString(SharedPreferencestokenKey);
    var id = await HelperFunction.getUserId();
    var token = await HelperFunction.getToken();
    var api = Uri.parse(AppConstants.USER_INFO + "$id");
    print(token);
    try {
      final response =
          await http.get(api, headers: {'Authorization': 'Bearer $token'});
      if (response.statusCode == 200) {
        UserInfo modal = UserInfo.fromJson(jsonDecode(response.body));
        return modal;
      }
    } catch (e) {}
  }

  FutureOr<GetOrderDetails> getOrderDetails(int id) async {
    var api = Uri.parse(AppConstants.ORDER_CONFIRMED_URI + id.toString());
    try {
      var response=await http.get(api);
      if(response.statusCode==200){
        GetOrderDetails modal=GetOrderDetails.fromJson(jsonDecode(response.body));
        return modal;
      }
    } catch (e) {}
  }

  FutureOr<AllOrderList> GetAllOrderList() async {
    var token = await HelperFunction.getToken();
    var api = Uri.parse(AppConstants.GET_ORDER_LIST);
    print(token);
    try {
      final res =
          await http.get(api, headers: {'Authorization': 'Bearer $token'});

      print(res.body);

      if (res.statusCode == 200) {
        print("============================");
        print("==================");
        AllOrderList modal = AllOrderList.fromJson(jsonDecode(res.body));
        print("============================");
        print(modal.order.length);
        return modal;
      }
    } catch (e) {}
  }

  Future<ConfigModel> Config() async {
    var api = Uri.parse(AppConstants.CONFIG_URI);

    try {
      final response = await http.get(api);
      if (response.statusCode == 200) {
        ConfigModel modal = ConfigModel.fromJson(jsonDecode(response.body));
        return modal;
      }
    } catch (e) {}
  }

  FutureOr<AllAddress> getAllAddress() async {
    String SharedPreferencesUserIdKey = "UserIdKey";
    String SharedPreferencestokenKey = "TokenKey";
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var id = await preferences.getString(SharedPreferencesUserIdKey);
    var token = await preferences.getString(SharedPreferencestokenKey);
    var api = Uri.parse(AppConstants.GET_ALL_ADDRESS + id);
    try {
      final response =
          await http.get(api, headers: {'Authorization': 'Bearer $token'});
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        AllAddress modal = AllAddress.fromJson(jsonDecode(response.body));
        return modal;
      }
    } catch (e) {}
  }

  GETPrivacyPolicy(String url) async {
    var api = Uri.parse(url);

    try {
      final response = await http.get(api);
      if (response.statusCode == 200) {
        print("config response >>>>>>>>>>>>>>>>>>>${response.body}");
        PrivacyPolicy modal = PrivacyPolicy.fromJson(jsonDecode(response.body));
        return modal;
      }
    } catch (e) {}
  }

  FutureOr<List<CategoryModel>> DashBoardAllCategories() async {
    var api = Uri.parse(AppConstants.CATEGORIES_URI);

    try {
      final response = await http.get(api);

      print("Category>>>>>>>" + response.body.toString());
      if (response.statusCode == 200) {
        print("skjdhsakjdfhasf1111111111111111");
        List<CategoryModel> modal = List<CategoryModel>.from(json.decode(response.body).map((x) => CategoryModel.fromJson(x)));
        return modal;
      }
    } catch (e) {}
  }

  FutureOr<TodaysDealsModel> DashBoardTodaysDeals() async {
    var api = Uri.parse(AppConstants.DEAL_OF_THE_DAY_URI);

    try {
      final response = await http.get(api);

      print("TodaysDeals>>>>>>>" + response.body.toString());
      if (response.statusCode == 200) {
        print("skjdhsakjdfhasf");
        TodaysDealsModel modal =
            TodaysDealsModel.fromJson(jsonDecode(response.body));
        return modal;
      }
    } catch (e) {}
  }

  FutureOr<BrandsModel> DashBoardBrands() async {
    var api = Uri.parse(AppConstants.BRANDS_URI);

    try {
      final response = await http.get(api);

      print("Brands>>>>>>>" + response.body.toString());
      if (response.statusCode == 200) {
        print("asdada___________");
        BrandsModel modal = BrandsModel.fromJson(jsonDecode(response.body));
        return modal;
      }
    } catch (e) {}
  }

  FutureOr<MainBannerModel> DashBoardMainBanner() async {
    var api = Uri.parse(AppConstants.MAIN_BANNER_URI);

    try {
      final response = await http.get(api);

      print("TodaysDeals>>>>>>>" + response.body.toString());
      if (response.statusCode == 200) {
        print("skjdhsakjdfhasf");
        MainBannerModel modal =
            MainBannerModel.fromJson(jsonDecode(response.body));
        return modal;
      }
    } catch (e) {}
  }

  FutureOr<BrandsAndProductsModel> DashBoardProductsCategory(productUrl) async {
    // print("dkgdjhsfdpi");
    var api = Uri.parse("${productUrl}");

    try {
      final response = await http.get(api);

      // print("Category products...>>>>>>>" + response.body.toString());
      if (response.statusCode == 200) {
        print("skjdhsakjdfhasf");
        BrandsAndProductsModel modal =
            BrandsAndProductsModel.fromJson(jsonDecode(response.body));
        print("11111111111111");
        return modal;
      }
    } catch (e) {}
  }

  FutureOr<RelatedProductsModel> DashboardRelatedProduct(String url) async {
    var api = Uri.parse(url);

    try {
      final response = await http.get(api);
      if (response.statusCode == 200) {
        print("related parent response >>>>>>>>>${response.body}");
        RelatedProductsModel modal =
            RelatedProductsModel.fromJson(jsonDecode(response.body));
        return modal;
      }
    } catch (e) {}
  }

  FutureOr<FeaturedProductModel> DashBoardFeaturedProduct(url) async {
    var api = Uri.parse(url);

    try {
      final response = await http.get(api);

      print("TodaysDeals>>>>>>>" + response.body.toString());
      if (response.statusCode == 200) {
        print("skjdhsakjdfhasf");
        FeaturedProductModel modal =
            FeaturedProductModel.fromJson(jsonDecode(response.body));
        return modal;
      }
    } catch (e) {}
  }

  FutureOr<ProductDetailsModel> DashBoardProductDetails(var url) async {
    var api = Uri.parse(url);

    try {
      final response = await http.get(api);

      print("Product Details-->>>>>>>" + response.body.toString());
      if (response.statusCode == 200) {
        print("skjdhsakjdfhasf");
        ProductDetailsModel modal =
            ProductDetailsModel.fromJson(jsonDecode(response.body));
        return modal;
      }
    } catch (e) {}
  }

  FutureOr<GetCartModel> DashBoardGetCarts() async {
    var api = Uri.parse(AppConstants.GET_CART_DATA_URI);
    String token = await HelperFunction.getToken();
    print("token $token");
    try {
      final response =
          await client.get(api, headers: {'Authorization': 'Bearer $token'});
      if (response.statusCode == 200) {
        var jsonString = response.body;
        GetCartModel modal = GetCartModel.fromJson(jsonDecode(response.body));
        // return getCartModelFromJson(jsonString);
        return modal;
      }
    } catch (e) {}
  }

  FutureOr<OrderPlaced> placedOrder(map) async {
    var api = Uri.parse(AppConstants.ORDER_PLACE_URI);
    try {
      final response = await client.post(api, body: map);
      print("3213212${response.body}");
      if (response.statusCode == 200) {
        OrderPlaced modal = OrderPlaced.fromJson(jsonDecode(response.body));
        return modal;
      }
    } catch (e) {
      print(e);
    }
  }

  FutureOr<List<OrderListModel>> getOrderList() async {
    print("23123");
    var api = Uri.parse(AppConstants.ORDER_LIST_URI);
    var token = await HelperFunction.getToken();
    try {
      var response =
          await client.post(api, headers: {'Authorization': 'Bearer $token'});
      print("Order List response #1231${response.body}");
      if (response.statusCode == 200) {
        List<OrderListModel> model = List<OrderListModel>.from(
            json.decode(response.body).map((x) => OrderListModel.fromJson(x)));
        return model;
      }
    } catch (e) {
      print(e);
    }
  }
}
