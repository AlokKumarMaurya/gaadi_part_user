import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

import '../../../../data/DAshboard Repository/dashboadRepository.dart';
import '../../../../data/model/response/RelatedProductModel.dart';
import '../../../baseWidget/product_widget.dart';

class RelatedProductView extends StatefulWidget {
  String url;

  RelatedProductView({@required this.url});

  @override
  State<RelatedProductView> createState() => _RelatedProductViewState();
}

class _RelatedProductViewState extends State<RelatedProductView> {
  RelatedProductsModel _relatedProductsModel;

  getRelatedProduct() async{
    var response = await DashboardApiClient().DashboardRelatedProduct(widget.url);
    print("response related42366$response");
    if (response != null){
      setState(() {
        _relatedProductsModel = response;
        print("related response >>>>>>>>>>>$response");
      });
      return _relatedProductsModel;
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(_relatedProductsModel.toString()),
        backgroundColor: Colors.red,
      ));
    }

    print("related >>>>>>>>>>>$response");

  }

  @override
  void initState() {
    // TODO: implement initState
    getRelatedProduct();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [

     StaggeredGridView.countBuilder(
        crossAxisCount: 2,
        itemCount: _relatedProductsModel.data.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
        itemBuilder: (BuildContext context, int index) {
          return ProductWidget(index: index,fromRelated: true,);
        },
      )
    ]);
  }
}
