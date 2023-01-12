import 'package:gaadi_part/data/DAshboard%20Repository/dashboadRepository.dart';
import 'package:get/get.dart';

class IsLoginController extends GetxController{

  final isGuest = "".obs;

  getToken() async{
   var token = await DashboardApiClient().isGuest();
   isGuest(token);
  }

}