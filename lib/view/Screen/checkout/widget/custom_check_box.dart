import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../utill/custom_themes.dart';

class CustomCheckBox extends StatelessWidget {
  final String title;
  final int index;
  CustomCheckBox({@required this.title, @required this.index});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // onTap: () => order.setPaymentMethod(index),
      child: Row(children: [
        Checkbox(
          shape: CircleBorder(),
          value: true,
          // order.paymentMethodIndex == index,
          activeColor: Theme.of(context).primaryColor,
          onChanged: (bool isChecked) => 1,
              // order.setPaymentMethod(index),
        ),
        Expanded(
          child: Text(title, style: titilliumRegular.copyWith(
            color: Color(0xFFE6E6E6),
          )),
        ),
      ]),
    );
  }
}
