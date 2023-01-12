import 'package:gaadi_part/data/DAshboard%20Repository/dashboadRepository.dart';
import 'package:gaadi_part/helper/shared_preference.dart';
import 'package:get/get.dart';

import '../../../../data/model/body/userInfoModal.dart';

class ProfileController extends GetxController{

  final  isLogin = ''.obs;
  var userInfo = UserInfo().obs;

  void getUserInfo() async{
    var response = await DashboardApiClient().MoreUserInfo();
    if(response != null){
      userInfo(response);
    }
    update();
  }

  void getLog() async{
    isLogin(await HelperFunction.getLogin());
    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    getLog();
    getUserInfo();
    super.onInit();
  }


}