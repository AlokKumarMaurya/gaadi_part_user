import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WidgetUtil {
  static void showSnackBar(BuildContext context, String message) {
    if (message.isNotEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
    }
  }

  static Widget divider() {
    return const Divider(height: 1, thickness: 1);
  }

  static Widget sizedBox({double height = 10}) {
    return SizedBox(height: height);
  }

  static Widget sizedBox1({double height = 4}) {
    return SizedBox(height: height);
  }

  static Widget loader() {
    return Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(color: Colors.purple));
  }

  static void dismissKeyBoard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}