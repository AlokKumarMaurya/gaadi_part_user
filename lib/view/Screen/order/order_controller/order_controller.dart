import 'package:gaadi_part/data/DAshboard%20Repository/dashboadRepository.dart';
import 'package:gaadi_part/data/model/response/Order/order_list_response.dart';
import 'package:get/get.dart';

class OrderController extends GetxController{

  var orderList = List<OrderListModel>().obs;
  
  getOrderList() async{
    var response = await DashboardApiClient().getOrderList();
    if(response!=null){
      orderList(response);
      print('#orderlist #123$orderList');
    }
    update();
  }
  
  @override
  void onInit() {
    // TODO: implement onInit
    getOrderList();
    super.onInit();
  }
}