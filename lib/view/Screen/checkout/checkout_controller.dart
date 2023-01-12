
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CheckOutController extends GetxController{

  final List Address = [].obs as List;
  final shippingAddress = ''.obs;
  // final shippingAddressController = TextEditingController();

  addAddress(address){
    Address.add(address);
    update();
  }

  deleteAddress(index){
    Address.removeAt(index);
    update();
  }

  updateShippingAddress(String address){
    shippingAddress(address);
    update();
  }
}