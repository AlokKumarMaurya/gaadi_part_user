import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../utill/dimensions.dart';

class ShippingMethodBottomSheet extends StatefulWidget {
  final String groupId;
  final int sellerId;
  final int sellerIndex;
  ShippingMethodBottomSheet({@required this.groupId, @required this.sellerId, @required this.sellerIndex});

  @override
  _ShippingMethodBottomSheetState createState() => _ShippingMethodBottomSheetState();
}

class _ShippingMethodBottomSheetState extends State<ShippingMethodBottomSheet> {
  route(bool isRoute, String message) async {
    if (isRoute) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('shipping_method_added_successfully'), backgroundColor: Colors.green));
     Navigator.pop(context);

    } else {
     Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed'), backgroundColor: Colors.red));
    }
  }
  @override
  void initState() {
    //Provider.of<CartProvider>(context,listen: false).getShippingMethod(context, widget.cart.sellerId,widget.sellerIndex);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
      decoration: BoxDecoration(
        color: Theme.of(context).highlightColor,
        borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
      ),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        // Close Button
        Align(
          alignment: Alignment.centerRight,
          child: InkWell(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 25,
              height: 25,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).highlightColor,
                  boxShadow: [BoxShadow(color: Colors.grey, spreadRadius: 1, blurRadius: 5)]),
              child: Icon(Icons.clear, size: Dimensions.ICON_SIZE_SMALL),
            ),
          ),
        ),
        // order.shippingList[widget.sellerIndex].shippingMethodList != null ? order.shippingList[widget.sellerIndex].shippingMethodList.length != 0 ?
        SizedBox(
              height: 300,
              child: ListView.builder(
                itemCount: 7,
                shrinkWrap: true,
                itemBuilder: (context, index) {

                  return RadioListTile(
                    title: Text('ghfgy647'),
                    value: index,
                    groupValue: 4,
                    activeColor: Theme.of(context).primaryColor,
                    toggleable: false,
                    onChanged: (value) async {
                     //  Provider.of<CartProvider>(context, listen: false).setSelectedShippingMethod(value, widget.sellerIndex);
                     //  ShippingMethodModel shipping = ShippingMethodModel();
                     //  shipping.id = order.shippingList[widget.sellerIndex].shippingMethodList[index].id;
                     // shipping.duration = widget.groupId;
                     //  order.isLoading
                     //      ? Center(child: CircularProgressIndicator(
                     //      valueColor: new AlwaysStoppedAnimation<Color>(
                     //        Theme.of(context).primaryColor,
                     //      ),
                     //    ),
                     //  ) :
                     //  order.addShippingMethod(context, shipping.id, shipping.duration, route);
                     //  // Navigator.pop(context);
                    },
                  );
                },
              ),
            )
            // : Center(child: Text('No method available')) : Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor)));

      ]),
    );
  }
}
