// import 'package:flutter/material.dart';
// import 'package:gaadi_part/view/address/select_location_screen.dart';
// import 'package:geolocator/geolocator.dart';
//
//
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:provider/provider.dart';
//
// import '../../utill/custom_themes.dart';
// import '../../utill/dimensions.dart';
// import '../baseWidget/custom_app_bar.dart';
// import '../baseWidget/textField/custom_textfield.dart';
//
// class AddNewAddressScreen extends StatefulWidget {
//   final bool isEnableUpdate;
//   final bool fromCheckout;
//   // final AddressModel address;
//   final bool isBilling;
//   AddNewAddressScreen({this.isEnableUpdate = false, this.fromCheckout = false, this.isBilling});
//
//   @override
//   State<AddNewAddressScreen> createState() => _AddNewAddressScreenState();
// }
//
// class _AddNewAddressScreenState extends State<AddNewAddressScreen> {
//   final TextEditingController _contactPersonNameController = TextEditingController();
//   final TextEditingController _contactPersonNumberController = TextEditingController();
//   final TextEditingController _cityController = TextEditingController();
//   final TextEditingController _zipCodeController = TextEditingController();
//   final FocusNode _addressNode = FocusNode();
//   final FocusNode _nameNode = FocusNode();
//   final FocusNode _numberNode = FocusNode();
//   final FocusNode _cityNode = FocusNode();
//   final FocusNode _zipNode = FocusNode();
//   GoogleMapController _controller;
//   CameraPosition _cameraPosition;
//   bool _updateAddress = true;
//   Address _address;
//
//
//   @override
//   void initState() {
//     super.initState();
//     // if(widget.isBilling){
//     //   _address = Address.billing;
//     // }else{
//     //   _address = Address.shipping;
//     // }
//     //
//     // Provider.of<LocationProvider>(context, listen: false).initializeAllAddressType(context: context);
//     // Provider.of<LocationProvider>(context, listen: false).updateAddressStatusMessae(message: '');
//     // Provider.of<LocationProvider>(context, listen: false).updateErrorMessage(message: '');
//     // _checkPermission(() => Provider.of<LocationProvider>(context, listen: false).getCurrentLocation(context, true, mapController: _controller),context);
//     // if (widget.isEnableUpdate && widget.address != null) {
//     //   _updateAddress = false;
//     //   Provider.of<LocationProvider>(context, listen: false).updatePosition(CameraPosition(target: LatLng(double.parse(widget.address.latitude), double.parse(widget.address.longitude))), true, widget.address.address, context);
//     //   _contactPersonNameController.text = '${widget.address.contactPersonName}';
//     //   _contactPersonNumberController.text = '${widget.address.phone}';
//     //   if (widget.address.addressType == 'Home') {
//     //     Provider.of<LocationProvider>(context, listen: false).updateAddressIndex(0, false);
//     //   } else if (widget.address.addressType == 'Workplace') {
//     //     Provider.of<LocationProvider>(context, listen: false).updateAddressIndex(1, false);
//     //   } else {
//     //     Provider.of<LocationProvider>(context, listen: false).updateAddressIndex(2, false);
//     //   }
//     // }else {
//     //   if(Provider.of<ProfileProvider>(context, listen: false).userInfoModel!=null){
//     //     _contactPersonNameController.text = '${Provider.of<ProfileProvider>(context, listen: false).userInfoModel.fName ?? ''}'
//     //         ' ${Provider.of<ProfileProvider>(context, listen: false).userInfoModel.lName ?? ''}';
//     //     _contactPersonNumberController.text = Provider.of<ProfileProvider>(context, listen: false).userInfoModel.phone ?? '';
//     //   }
//     //
//     // }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     print('====selected shipping or billing==>${_address.toString()}');
//
//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               CustomAppBar(title: widget.isEnableUpdate ? 'update_address' : 'add_new_address'),
//               Container(
//                 padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
//                 height: MediaQuery.of(context).size.height,
//                 child: Column(
//
//                   children: [
//                   Expanded(
//                     child: Center(
//                       child: SizedBox(
//                         child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Container(
//                             height: 126,
//                             width: MediaQuery.of(context).size.width,
//                             child: ClipRRect(
//                               borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_SMALL),
//                               child: Stack(
//                                 clipBehavior: Clip.none, children: [
//                                 // GoogleMap(
//                                 //   mapType: MapType.normal,
//                                 //   initialCameraPosition: CameraPosition(
//                                 //     target: widget.isEnableUpdate
//                                 //         ? LatLng(double.parse(widget.address.latitude) ?? 0.0, double.parse(widget.address.longitude) ?? 0.0)
//                                 //         : LatLng(locationProvider.position.latitude ?? 0.0, locationProvider.position.longitude ?? 0.0),
//                                 //     zoom: 17,
//                                 //   ),
//                                 //   onTap: (latLng) {
//                                 //     Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => SelectLocationScreen(googleMapController: _controller)));
//                                 //   },
//                                 //   zoomControlsEnabled: false,
//                                 //   compassEnabled: false,
//                                 //   indoorViewEnabled: true,
//                                 //   mapToolbarEnabled: false,
//                                 //   onCameraIdle: () {
//                                 //     if(_updateAddress) {
//                                 //       locationProvider.updatePosition(_cameraPosition, true, null, context);
//                                 //     }else {
//                                 //       _updateAddress = true;
//                                 //     }
//                                 //   },
//                                 //   onCameraMove: ((_position) => _cameraPosition = _position),
//                                 //   onMapCreated: (GoogleMapController controller) {
//                                 //     _controller = controller;
//                                 //     if (!widget.isEnableUpdate && _controller != null) {
//                                 //       Provider.of<LocationProvider>(context, listen: false).getCurrentLocation(context, true, mapController: _controller);
//                                 //     }
//                                 //   },
//                                 // ),
//                                 // locationProvider.loading ? Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme
//                                 //     .of(context).primaryColor))) : SizedBox(),
//                                 Container(
//                                     width: MediaQuery.of(context).size.width,
//                                     alignment: Alignment.center,
//                                     height: MediaQuery.of(context).size.height,
//                                     child: Icon(
//                                       Icons.location_on,
//                                       size: 40,
//                                       color: Theme.of(context).primaryColor,
//                                     )),
//                                 Positioned(
//                                   bottom: 10,
//                                   right: 0,
//                                   child: InkWell(
//                                     onTap: () {
//                                       // _checkPermission(() => locationProvider.getCurrentLocation(context, true, mapController: _controller),context);
//                                     },
//                                     child: Container(
//                                       width: 30,
//                                       height: 30,
//                                       margin: EdgeInsets.only(right: Dimensions.PADDING_SIZE_LARGE),
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_SMALL),
//                                         color: Color(0xFFD4D4D4),
//                                       ),
//                                       child: Icon(
//                                         Icons.my_location,
//                                         color: Theme.of(context).primaryColor,
//                                         size: 20,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 Positioned(
//                                   top: 10,
//                                   right: 0,
//                                   child: InkWell(
//                                     onTap: () {
//
//                                       Navigator.of(context).push(MaterialPageRoute(
//                                           builder: (BuildContext context) => SelectLocationScreen(googleMapController: _controller)));
//                                     },
//                                     child: Container(
//                                       width: 30,
//                                       height: 30,
//                                       margin: EdgeInsets.only(right: Dimensions.PADDING_SIZE_LARGE),
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_SMALL),
//                                         color: Colors.white,
//                                       ),
//                                       child: Icon(
//                                         Icons.fullscreen,
//                                         color: Theme.of(context).primaryColor,
//                                         size: 20,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                               ),
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(top: 10),
//                             child: Center(
//                                 child: Text(
//                                   'add_the_location_correctly',
//                                   style: Theme.of(context).textTheme.headline2.copyWith(color: Color(0xFF000743), fontSize: Dimensions.FONT_SIZE_SMALL),
//                                 )),
//                           ),
//
//
//                           // for label us
//                           Padding(
//                             padding: const EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_EXTRA_EXTRA_SMALL),
//                             child: Text(
//                               'label_us',
//                               style:
//                               Theme.of(context).textTheme.headline3.copyWith(color: Color(0xFF9E9E9E), fontSize: Dimensions.FONT_SIZE_LARGE),
//                             ),
//                           ),
//
//                           Container(
//                             height: 50,
//                             child: ListView.builder(
//                               shrinkWrap: true,
//                               scrollDirection: Axis.horizontal,
//                               physics: BouncingScrollPhysics(),
//                               itemCount: 2,
//                               itemBuilder: (context, index) => InkWell(
//                                 onTap: () {
//                                   // locationProvider.updateAddressIndex(index, true);
//                                 },
//                                 child: Container(
//                                   padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_DEFAULT, horizontal: Dimensions.PADDING_SIZE_LARGE),
//                                   margin: EdgeInsets.only(right: 17),
//                                   decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(
//                                         Dimensions.PADDING_SIZE_SMALL,
//                                       ),
//                                       border: Border.all(
//                                           // color: locationProvider.selectAddressIndex == index
//                                           //     ? Theme.of(context).primaryColor : ColorResources.getHint(context)),
//                                       color:
//                                       // locationProvider.selectAddressIndex == index
//                                       //     ? Theme.of(context).primaryColor :
//                                       Color(0xFFD4D4D4))),
//                                   child: Text(
//                                     "getTranslated(locationProvider.getAllAddressType[index]",
//                                     style: robotoRegular.copyWith(
//                                         color:
//                                         // locationProvider.selectAddressIndex == index
//                                         //     ? Theme.of(context).cardColor :
//                                         Color(0xFF9E9E9E)),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//
//
//                           Container(height: 50,
//                             child: Row(children: <Widget>[
//                               Row(
//                                 children: [
//                                   Radio<Address>(
//                                     value: Address.shipping,
//                                     groupValue: _address,
//                                     onChanged: (Address value) {
//                                       setState(() {
//                                         _address = value;
//                                       });
//                                     },
//                                   ),
//                                   Text('shipping_address'),
//
//                                 ],
//                               ),
//                               Row(
//                                 children: [
//                                   Radio<Address>(
//                                     value: Address.billing,
//                                     groupValue: _address,
//                                     onChanged: (Address value) {
//                                       setState(() {
//                                         _address = value;
//                                       });
//                                     },
//                                   ),
//                                   Text('billing_address'),
//
//
//                                 ],
//                               ),
//                             ],
//                             ),
//                           ),
//
//                           Padding(
//                             padding: const EdgeInsets.only(top: 5,),
//                             child: Text(
//                               'delivery_address',
//                               style: Theme.of(context).textTheme.headline3.copyWith(color: Color(0xFF9E9E9E), fontSize: Dimensions.FONT_SIZE_LARGE),
//                             ),
//                           ),
//
//                           // for Address Field
//                           SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
//                           CustomTextField(
//                             hintText: 'address_line_02',
//                             textInputType: TextInputType.streetAddress,
//                             textInputAction: TextInputAction.next,
//                             focusNode: _addressNode,
//                             nextNode: _nameNode,
//                             controller: _contactPersonNameController,
//                           ),
//                           SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT_ADDRESS),
//                           Text(
//                             'city',
//                             style: robotoRegular.copyWith(color: Color(0xFF9E9E9E)),
//                           ),
//                           SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
//                           CustomTextField(
//                             hintText: 'city',
//                             textInputType: TextInputType.streetAddress,
//                             textInputAction: TextInputAction.next,
//                             focusNode: _cityNode,
//                             nextNode: _zipNode,
//                             controller: _cityController,
//                           ),
//                           SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT_ADDRESS),
//                           Text(
//                             'zip',
//                             style: robotoRegular.copyWith(color: Color(0xFF9E9E9E)),
//                           ),
//                           SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
//                           CustomTextField(
//                             hintText: 'zip',
//                             textInputType: TextInputType.number,
//                             textInputAction: TextInputAction.next,
//                             focusNode: _zipNode,
//                             nextNode: _nameNode,
//                             controller: _zipCodeController,
//                           ),
//                           SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT_ADDRESS),
//
//                           // for Contact Person Name
//                           Text(
//                             'contact_person_name',
//                             style: robotoRegular.copyWith(color: ColorResources.getHint(context)),
//                           ),
//                           SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
//                           CustomTextField(
//                             hintText: 'enter_contact_person_name',
//                             textInputType: TextInputType.name,
//                             controller: _contactPersonNameController,
//                             focusNode: _nameNode,
//                             nextNode: _numberNode,
//                             textInputAction: TextInputAction.next,
//                             capitalization: TextCapitalization.words,
//                           ),
//                           SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT_ADDRESS),
//
//                           // for Contact Person Number
//                           Text(
//                             'contact_person_number',
//                             style: robotoRegular.copyWith(color: Color(0xFF9E9E9E)),),
//                           SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
//                           CustomTextField(
//                             hintText: 'enter_contact_person_number',
//                             textInputType: TextInputType.phone,
//                             textInputAction: TextInputAction.done,
//                             focusNode: _numberNode,
//                             controller: _contactPersonNumberController,
//                           ),
//
//                           SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
//
//                           Container(
//                             height: 50.0,
//                             margin: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
//                             child:
//                             !locationProvider.isLoading ?
//                             CustomButton(
//                               buttonText:
//                               // widget.isEnableUpdate ?
//                               'update_address'
//                                   // : getTranslated('save_location', context),
//                               onTap: locationProvider.loading ? null : () { AddressModel addressModel = AddressModel(
//                                 addressType: locationProvider.getAllAddressType[locationProvider.selectAddressIndex],
//                                 contactPersonName: _contactPersonNameController.text ?? '',
//                                 phone: _contactPersonNumberController.text ?? '',
//                                 city: _cityController.text ?? '',
//                                 zip: _zipCodeController.text?? '',
//                                 isBilling: _address == Address.billing ? 1:0,
//                                 address: locationProvider.locationController.text ?? '',
//                                 latitude: widget.isEnableUpdate ? locationProvider.position.latitude.toString() ?? widget.address.latitude : locationProvider.position.latitude.toString() ?? '',
//                                 longitude: widget.isEnableUpdate ? locationProvider.position.longitude.toString() ?? widget.address.longitude
//                                     : locationProvider.position.longitude.toString() ?? '',
//                               );
//                               if (widget.isEnableUpdate) {
//                                 addressModel.id = widget.address.id;
//                                 addressModel.id = widget.address.id;
//                                 // addressModel.method = 'put';
//                                 locationProvider.updateAddress(context, addressModel: addressModel, addressId: addressModel.id).then((value) {});
//                               } else {
//                                 locationProvider.addAddress(addressModel, context).then((value) {
//                                   if (value.isSuccess) {
//                                     Provider.of<ProfileProvider>(context, listen: false).initAddressList(context);
//                                     Navigator.pop(context);
//                                     if (widget.fromCheckout) {
//                                       Provider.of<ProfileProvider>(context, listen: false).initAddressList(context);
//                                       Provider.of<OrderProvider>(context, listen: false).setAddressIndex(-1);
//                                     } else {
//                                       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value.message), duration: Duration(milliseconds: 600), backgroundColor: Colors.green));
//                                     }
//                                   } else {
//                                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value.message), duration: Duration(milliseconds: 600), backgroundColor: Colors.red));
//                                   }
//                                 });
//                               }
//                               },
//                             )
//                                 : Center(
//                                 child: CircularProgressIndicator(
//                                   valueColor: new AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
//                                 )),
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 // locationProvider.addressStatusMessage != null
//                 //     ? Row(
//                 //   crossAxisAlignment: CrossAxisAlignment.start,
//                 //   children: [
//                 //     locationProvider.addressStatusMessage.length > 0 ? CircleAvatar(backgroundColor: Colors.green, radius: 5) : SizedBox.shrink(),
//                 //     SizedBox(width: 8),
//                 //     Expanded(
//                 //       child: Text(locationProvider.addressStatusMessage ?? "",
//                 //         style: Theme.of(context).textTheme.headline2.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL, color: Colors.green, height: 1),
//                 //       ),
//                 //     )
//                 //   ],
//                 // )
//                 //     : Row(crossAxisAlignment: CrossAxisAlignment.start,
//                 //       children: [
//                 //         locationProvider.errorMessage.length > 0
//                 //         ? CircleAvatar(backgroundColor: Theme.of(context).primaryColor, radius: 5) : SizedBox.shrink(),
//                 //        SizedBox(width: 8),
//                 //        Expanded(
//                 //       child: Text(locationProvider.errorMessage ?? "",
//                 //         style: Theme.of(context).textTheme.headline2.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL, color: Theme.of(context).primaryColor, height: 1),
//                 //       ),
//                 //     )
//                 //   ],
//                 // ),
//
//
//               ],
//             ),
//           );
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//   void _checkPermission(Function callback, BuildContext context) async {
//     LocationPermission permission = await Geolocator.requestPermission();
//     if(permission == LocationPermission.denied || permission == LocationPermission.whileInUse) {
//       InkWell(
//         onTap: () async{
//             Navigator.pop(context);
//             await Geolocator.requestPermission();
//             _checkPermission(callback, context);
//         },
//           child: AlertDialog(content: MyDialog(icon: Icons.location_on_outlined, title: '', description: getTranslated('you_denied', context))));
//     }else if(permission == LocationPermission.deniedForever) {
//       InkWell(
//           onTap: () async{
//               Navigator.pop(context);
//               await Geolocator.openAppSettings();
//               _checkPermission(callback,context);
//           },
//           child: AlertDialog(content: MyDialog(icon: Icons.location_on_outlined, title: '',description: getTranslated('you_denied', context))));
//     }else {
//       callback();
//     }
//   }
// }
//
// enum Address {shipping, billing }