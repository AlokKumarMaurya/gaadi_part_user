import 'package:flutter/material.dart';

import '../../../utill/custom_themes.dart';
import '../../../utill/images.dart';
class AddressListPage extends StatelessWidget {
  // final AddressModel address;
  AddressListPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(
         Images.home_image,
        color: Color(0xFF92C6FF), height: 30, width: 30,
      ),
      title: Text("address.address", style: titilliumRegular),
    );



  }
}
