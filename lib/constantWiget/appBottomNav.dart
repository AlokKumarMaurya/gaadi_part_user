import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppBottomNavButton extends StatelessWidget {
  final String leftLabel, rightLabel;
  final Function() onLeftClick, onRightClick;

  const AppBottomNavButton({

     this.onLeftClick,
     this.onRightClick,
    this.leftLabel = "No",
    this.rightLabel = "Yes",
  }) ;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        children: [
          Expanded(
            child: Expanded(
              child:ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.white
                ),
                child: Text(leftLabel,style: TextStyle(color: Colors.black)),
                onPressed: () => onLeftClick(),
              ),
            ),
          ),
          SizedBox(width:5, ),
          Expanded(
            child:ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.purple
              ),
              child: Text(rightLabel,style: TextStyle(color: Colors.white)),
              onPressed: () => onRightClick(),
            ),
          ),
        ],
      ),
    );
  }
}