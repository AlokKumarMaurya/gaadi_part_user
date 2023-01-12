import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utill/custom_themes.dart';
import '../../../utill/dimensions.dart';
import '../home/widget/products_view.dart';

class AllProductScreen extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();
  // final ProductType productType;
  AllProductScreen();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor:  Color(0xFFFCFCFC),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(5), bottomLeft: Radius.circular(5))),
        leading: IconButton(icon: Icon(Icons.arrow_back_ios, size: 20,
            color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Latest Product',
            style: titilliumRegular.copyWith(fontSize: 20, color: Colors.white)),
      ),

      body: SafeArea(
        child: RefreshIndicator(
          backgroundColor: Theme.of(context).primaryColor,
          onRefresh: () async {
            return true;
          },
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverToBoxAdapter(

                child: Padding(
                  padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                  child: ProductView(isHomePage: false, scrollController: _scrollController),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
