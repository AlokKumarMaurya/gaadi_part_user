import 'package:flutter/material.dart';
import 'package:gaadi_part/view/Screen/product/widget/review_widget.dart';

import '../../../utill/custom_themes.dart';
import '../../../utill/dimensions.dart';
import '../../baseWidget/custom_app_bar.dart';

class ReviewScreen extends StatelessWidget {
  // final List<ReviewModel> reviewList;
  // ReviewScreen({this.reviewList});
  ReviewScreen();

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

        CustomAppBar(title: 'reviews'),

        Padding(
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
          child: Text('reviews'+''"({reviewList.length})"'', style: robotoBold),
        ),

        Expanded(child: ListView.builder(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
          itemCount: 5,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_SMALL),
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
              color: Theme.of(context).highlightColor,
              child:
              ReviewWidget(),
              // ReviewWidget(reviewModel: reviewList[index]),
            );
          },
        )),

      ]),
    );
  }
}
