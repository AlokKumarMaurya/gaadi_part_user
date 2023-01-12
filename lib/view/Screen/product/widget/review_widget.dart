import 'package:flutter/material.dart';

import '../../../../utill/custom_themes.dart';
import '../../../../utill/dimensions.dart';
import '../../../../utill/images.dart';

class ReviewWidget extends StatelessWidget {
  // final ReviewModel reviewModel;
  // ReviewWidget({@required this.reviewModel});
  ReviewWidget();

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_DEFAULT),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage.assetNetwork(
              placeholder: Images.placeholder, height: Dimensions.chooseReviewImageSize,
              width: Dimensions.chooseReviewImageSize, fit: BoxFit.cover,
              image: 'baseUrls.customerImageUrl',
              imageErrorBuilder: (c, o, s) => Image.asset(Images.placeholder, height: Dimensions.chooseReviewImageSize,
                  width: Dimensions.chooseReviewImageSize, fit: BoxFit.cover),
            ),
          ),
          SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),


          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Text('user_not_exist',
                style: titilliumRegular.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
            ]),


            Row(children: [
              Icon(Icons.star,color: Colors.orange),

              Text('/5',
                style: titilliumRegular.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT),
                maxLines: 1, overflow: TextOverflow.ellipsis,
              ),
            ]),
          ]),
        ]),
        SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),

        Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
          child: Text('fvttft', textAlign: TextAlign.left,
            style: titilliumRegular.copyWith(color: Theme.of(context).hintColor,
                fontSize: Dimensions.FONT_SIZE_DEFAULT),
            maxLines: 3, overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),

        SizedBox(
          height: 40,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: 8,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(right: Dimensions.PADDING_SIZE_SMALL),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: FadeInImage.assetNetwork(
                    placeholder: Images.placeholder, height: Dimensions.chooseReviewImageSize,
                    width: Dimensions.chooseReviewImageSize, fit: BoxFit.cover,
                    image: '{Provider.of<SplashProvider>(context, listen: false).baseUrls.reviewImageUrl}/review/{reviewModel.attachment[index]}',
                    imageErrorBuilder: (c, o, s) => Image.asset(Images.placeholder,
                        height: Dimensions.chooseReviewImageSize, width: Dimensions.chooseReviewImageSize, fit: BoxFit.cover),
                  ),
                ),
              );
            },
          ),
        )
      ]),
    );
  }
}

// class ReviewShimmer extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Shimmer.fromColors(
//       baseColor: Colors.grey[300],
//       highlightColor: Colors.grey[100],
//       enabled: Provider.of<ProductDetailsProvider>(context).reviewList == null,
//       child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//         Row(children: [
//           CircleAvatar(
//             maxRadius: 15,
//             backgroundColor: ColorResources.SELLER_TXT,
//             child: Icon(Icons.person),
//           ),
//           SizedBox(width: 5),
//           Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//             Row(children: [
//               Container(height: 10, width: 50, color: ColorResources.WHITE),
//               SizedBox(width: 5),
//               RatingBar(rating: 0, size: 12),
//             ]),
//             Container(height: 10, width: 50, color: ColorResources.WHITE),
//           ]),
//         ]),
//         SizedBox(height: 5),
//         Container(height: 20, width: 200, color: ColorResources.WHITE),
//       ]),
//     );
//   }
// }
