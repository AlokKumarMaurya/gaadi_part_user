import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gaadi_part/helper/shared_preference.dart';
import 'package:gaadi_part/view/Screen/checkout/checkout_controller.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../data/DAshboard Repository/dashboadRepository.dart';
import '../../../data/model/response/getAllAddress.dart';
import '../../../utill/app_constants.dart';
import '../../../utill/custom_themes.dart';
import '../../../utill/dimensions.dart';
import '../../baseWidget/custom_app_bar.dart';
import '../more/profile_controller/profile_controller.dart';

List<String> selectedAddress = [];

class EditAddress extends StatefulWidget {
  final String email;
  final String phone;
  final String name;
  final String id;
  final String address;
  final String country;
  final String city;
  final String postal;

  const EditAddress(
      {Key key,
      this.name,
      this.email,
      this.phone,
      this.id,
      this.city,
      this.country,
      this.address,
      this.postal})
      : super(key: key);

  @override
  State<EditAddress> createState() => _EditAddressState();
}

class _EditAddressState extends State<EditAddress> {
  final profileController = Get.put(ProfileController());
  final _checkoutController = Get.put(CheckOutController());
  final addressCont = TextEditingController();
  final countryCont = TextEditingController();
  final cityCont = TextEditingController();
  final postalCodeCont = TextEditingController();
  final phoneCont = TextEditingController();
  bool isLoading = true;

  updateUserInfo() async {
    // String SharedPreferencesUserIdKey = "UserIdKey";
    // String SharedPreferencestokenKey = "TokenKey";
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    var id = await HelperFunction.getUserId();
    var token = await HelperFunction.getToken();
    var api = Uri.parse(AppConstants.ADD_SHIPPING_ADDRES);
    try {
      final response = await http.post(api, body: {
        "user_id": id,
        // "name": widget.name,
        "address": addressCont.text,
        //"email": widget.email,
        "country": countryCont.text,
        "city": cityCont.text,
        "postal_code": postalCodeCont.text,
        "phone": phoneCont.text,
      }, headers: {
        'Authorization': 'Bearer $token'
      });
      print(response.statusCode.toString());
      print(response.body);
      print("555555555555555555");
      if (response.statusCode == 200) {
        // Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Address added successfully"),
          backgroundColor: Colors.red,
        ));
      }
    } catch (e) {
      print(e);
      print("44444444444444444444");
    }
  }

  AllAddress allAddress;

  // getAllAdderessList() async {
  //   var response = await DashboardApiClient().getAllAddress();
  //   if (response != null) {
  //     setState(() {
  //       allAddress = response;
  //       isLoading = false;
  //     });
  //   }
  // }

  @override
  void initState() {
    // getAllAdderessList();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Address"),
      ),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            //CustomAppBar(title: 'Edit Address'),
            SizedBox(
              height: 20,
            ),
            Container(
              child: Row(
                children: [
                  SizedBox(width: 20),
                  Text("Selcted  Address"),
                  SizedBox(
                    width: 10,
                  ),
                  // Container(
                  //     // decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                  //     child: (selectedAddress.isNotEmpty)?Text(selectedAddress[0]):Text("None"))
                ],
              ),
            ),

            SizedBox(
              height: 50,
            ),
            Container(
              child: Column(
                children: [
                  Obx(() => ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: _checkoutController.Address.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              _checkoutController.updateShippingAddress(
                                  _checkoutController.Address[index]
                                      .toString());
                              Navigator.pop(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black)),
                                child: ListTile(
                                  title: Stack(
                                    children: [
                                      Positioned(
                                          right: 0,
                                          top: 0,
                                          bottom: 0,
                                          child: IconButton(
                                            color: Colors.red,
                                            onPressed: () {
                                              _checkoutController
                                                  .deleteAddress(index);
                                            },
                                            icon: Icon(Icons.remove_circle),
                                          )),
                                      Obx(() => Text(
                                            _checkoutController.Address[index]
                                                .toString(),
                                            style: titilliumRegular.copyWith(
                                                fontSize:
                                                    Dimensions.FONT_SIZE_LARGE),
                                            maxLines: 3,
                                            overflow: TextOverflow.fade,
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      )),
                ],
              ),
            ),

            SizedBox(
              height: 10,
            ),
            Obx(() => Container(
              height: MediaQuery.of(context).size.height / 1.5,
              padding: EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Column(
                children: [
                  Text(
                    "Add new address",
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding:
                    EdgeInsets.only(left: 10, right: 10, top: 0),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black26),
                        borderRadius: BorderRadius.circular(12)),
                    child: TextFormField(
                      controller: addressCont
                        ..text = profileController
                            .userInfo.value.data[0].address
                            .toString(),
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter address line 1",
                          label: Text("address")),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding:
                    EdgeInsets.only(left: 10, right: 10, top: 0),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black26),
                        borderRadius: BorderRadius.circular(12)),
                    child: TextFormField(
                      controller: countryCont..text = profileController.userInfo.value.data[0].country.toString(),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter country",
                          label: Text("country")),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding:
                    EdgeInsets.only(left: 10, right: 10, top: 0),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black26),
                        borderRadius: BorderRadius.circular(12)),
                    child: TextFormField(
                      controller: cityCont..text = profileController.userInfo.value.data[0].city.toString(),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter city",
                          label: Text("address city")),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding:
                    EdgeInsets.only(left: 10, right: 10, top: 0),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black26),
                        borderRadius: BorderRadius.circular(12)),
                    child: TextFormField(
                      controller: postalCodeCont..text = profileController.userInfo.value.data[0].postalCode.toString(),
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter postal code",
                          label: Text("Postal code")),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding:
                    EdgeInsets.only(left: 10, right: 10, top: 0),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black26),
                        borderRadius: BorderRadius.circular(12)),
                    child: TextFormField(
                      controller: phoneCont..text = profileController.userInfo.value.data[0].phone.toString(),
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter phone",
                          label: Text("Phone number")),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: () {
                            print("22222222222222222222");
                            if (addressCont.text.toString().isEmpty) {
                              Fluttertoast.showToast(
                                  msg: "Enter address first");
                            } else if (countryCont.text
                                .toString()
                                .isEmpty) {
                              Fluttertoast.showToast(
                                  msg: "Enter country first");
                            } else if (cityCont.text
                                .toString()
                                .isEmpty) {
                              Fluttertoast.showToast(
                                  msg: "Enter City first");
                            } else if (postalCodeCont.text
                                .toString()
                                .isEmpty) {
                              Fluttertoast.showToast(
                                  msg: "Enter Postal code first");
                            } else if (phoneCont.text
                                .toString()
                                .isEmpty) {
                              Fluttertoast.showToast(
                                  msg: "Enter Phone number first");
                            } else {
                              _checkoutController.addAddress(
                                "${addressCont.text.toString()},${cityCont.text.toString()},${countryCont.text.toString()},${postalCodeCont.text.toString()},${phoneCont.text.toString()}",
                              );
                              updateUserInfo();
                            }

                            print("3333333333333333333333333");
                          },
                          child: Text("Submit")),
                    ],
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
