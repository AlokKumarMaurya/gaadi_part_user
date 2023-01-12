import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../utill/custom_themes.dart';
import '../../../../utill/dimensions.dart';


class ProductTitleView extends StatelessWidget {
  String name;
  String priceHigher;
  String priceLower;
  String ratingCount;
  ProductTitleView({this.name, this.ratingCount, this.priceLower, this.priceHigher});

  @override
  Widget build(BuildContext context) {

    // double _startingPrice = 0;
    // double _endingPrice;
    // if(productModel.variation != null && productModel.variation.length != 0) {
    //   List<double> _priceList = [];
    //   productModel.variation.forEach((variation) => _priceList.add(variation.price));
    //   _priceList.sort((a, b) => a.compareTo(b));
    //   _startingPrice = _priceList[0];
    //   if(_priceList[0] < _priceList[_priceList.length-1]) {
    //     _endingPrice = _priceList[_priceList.length-1];
    //   }
    // }else {
    //   _startingPrice = productModel.unitPrice;
    // }

    return Container(
      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [

          Expanded(child: Text(name,
              style: titleRegular.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE),
              maxLines: 2)),
          SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),


          Column(children: [
            Text("${priceHigher}",
              style: titilliumRegular.copyWith(color: Theme.of(context).hintColor,
                  // decoration: TextDecoration.lineThrough
              ),
            ),
            SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_EXTRA_SMALL),


            Text('${priceLower}₹',
              style: titilliumBold.copyWith(color: Theme.of(context).primaryColor,
                  fontSize: Dimensions.FONT_SIZE_LARGE),
            ),
          ],),
        ]),
        SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),

        Row(children: [
          Text(' reviews | ',
              style: titilliumRegular.copyWith(color: Theme.of(context).hintColor,
                fontSize: Dimensions.FONT_SIZE_DEFAULT,)),

          Text(' orders | ', style: titilliumRegular.copyWith(
            color: Theme.of(context).hintColor,
            fontSize: Dimensions.FONT_SIZE_DEFAULT,
          )),

          Text(' wish', style: titilliumRegular.copyWith(
            color: Theme.of(context).hintColor,
            fontSize: Dimensions.FONT_SIZE_DEFAULT,
          )),

          Expanded(child: SizedBox.shrink()),
          SizedBox(width: 5),


          Row(children: [
            Icon(Icons.star, color: Colors.orange,),
            Text('${ratingCount}')
          ],),

        ]),
        SizedBox(height: Dimensions.PADDING_SIZE_SMALL),



        // productModel.colors.length > 0 ?
        // Row( children: [
        //   Text('eqweqweqw',
        //       style: titilliumRegular.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)),
        //   SizedBox(height: 40,
        //     child: ListView.builder(
        //       itemCount: 3,
        //       shrinkWrap: true,
        //       scrollDirection: Axis.horizontal,
        //       itemBuilder: (context, index) {
        //         String colorString = '0xffaaaaaa';
        //         return Container(
        //           decoration: BoxDecoration(
        //             borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL),
        //           ),
        //           child: Padding(padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
        //             child: Container(height: 30, width: 30,
        //               padding: EdgeInsets.all( Dimensions.PADDING_SIZE_EXTRA_SMALL),
        //               alignment: Alignment.center,
        //               decoration: BoxDecoration(color: Color(int.parse(colorString)),
        //                 borderRadius: BorderRadius.circular(5),
        //               ),
        //             ),
        //           ),
        //         );
        //       },
        //     ),
        //   ),
        // ]) ,
         SizedBox(height: Dimensions.PADDING_SIZE_SMALL),




        // productModel.choiceOptions!=null && productModel.choiceOptions.length>0?
        // ListView.builder(
        //   shrinkWrap: true,
        //   itemCount: 1,
        //   physics: NeverScrollableScrollPhysics(),
        //   itemBuilder: (context, index) {
        //     return Row(crossAxisAlignment: CrossAxisAlignment.center,
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: [
        //           Text('{getTranslated(',
        //               style: titilliumRegular.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)),
        //           SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
        //           Expanded(
        //             child: Padding(
        //               padding: const EdgeInsets.all(2.0),
        //               child: GridView.builder(
        //                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //                   crossAxisCount: 6,
        //                   crossAxisSpacing: 5,
        //                   mainAxisSpacing: 5,
        //                   childAspectRatio: (1 / .7),
        //                 ),
        //                 shrinkWrap: true,
        //                 physics: NeverScrollableScrollPhysics(),
        //                 itemCount: 6,
        //                 itemBuilder: (context, i) {
        //                   return Container(
        //                     decoration: BoxDecoration(
        //                       border: Border.all(width: .3,color: Colors.grey),
        //                       borderRadius: BorderRadius.circular(5),
        //                     ),
        //                     child: Center(
        //                       child: Text("productModel.choiceOptions[index].options[i].trim()", maxLines: 2,
        //                           overflow: TextOverflow.ellipsis, style: titilliumRegular.copyWith(
        //                             fontSize: Dimensions.FONT_SIZE_DEFAULT,
        //                           )),
        //                     ),
        //                   );
        //                 },
        //               ),
        //             ),
        //           ),
        //         ]);
        //   },
        // ),

      ])
    );
  }
}
