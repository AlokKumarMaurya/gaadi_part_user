import 'package:gaadi_part/data/DAshboard%20Repository/dashboadRepository.dart';
import 'package:get/get.dart';

import '../../../data/model/response/cart/get_cart_model.dart';

class CartController extends GetxController{

  // var CartCount = cartProductList.length.obs;
       var cartLength=0.obs;
  var  cartProductList = GetCartModel().obs;

  void getCart() async{
    var cart = await DashboardApiClient().DashBoardGetCarts();
    if(cart!= null){
      cartProductList.value = cart;
      cartLength.value=cartProductList.value.data.length;
    }  else if(cart ==null){
     cartLength.value=0;
    }
    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    getCart();
    super.onInit();
  }

}