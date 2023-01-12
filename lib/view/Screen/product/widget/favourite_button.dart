import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../constantWiget/appBottomSheet.dart';
import '../../../../helper/shared_preference.dart';
import '../../../../utill/images.dart';
import '../../auth/auth_screen.dart';

class FavouriteButton extends StatelessWidget {
  final Color backgroundColor;
  final Color favColor;
  final bool isSelected;
  final int productId;
  FavouriteButton({this.backgroundColor = Colors.black, this.favColor = Colors.white, this.isSelected = false, this.productId});

  @override
  Widget build(BuildContext context) {
    // bool isGuestMode = !Provider.of<AuthProvider>(context, listen: false).isLoggedIn();

    feedbackMessage(String message) {
      if (message != '') {
        // showCustomSnackBar(message, context, isError: false);
      }
    }

    return GestureDetector(
      onTap: ()async {
        if(    await HelperFunction.getLogin()!=null && await HelperFunction.getLogin()!=false ){


        }else{
        AppBottomSheet.showConfirmationBottomSheet(context,
        description: "Do you want to Login?",onLeftClick: (){
        Navigator.pop(context);

        },
        onRightClick: (){
        Navigator.push(context,MaterialPageRoute(builder: (context) => AuthScreen(),));
        });
        }
      },
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        color: Theme.of(context).cardColor,
        child: Padding(padding: EdgeInsets.all(8),
          child: Image.asset(
            Images.wish_image,
            color: favColor, height: 16, width: 16,
          ),
        ),
      )
    );
  }
}
