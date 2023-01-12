import 'package:flutter/material.dart';

class ViewAllButton extends StatelessWidget {
  const ViewAllButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 0, right: 0, bottom: 70, top: 20),
      child: ElevatedButton(

          onPressed: () {


          },
          style: ElevatedButton.styleFrom(primary: Colors.black),
          child:Row(
            children: [
              Text("View All ", style: TextStyle(color: Colors.white,fontSize: 10),),
              Icon(Icons.arrow_forward_outlined,color: Colors.white,)
            ],
          )

      ),
    );
  }
}