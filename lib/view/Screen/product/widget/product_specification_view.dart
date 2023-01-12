import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html_table/flutter_html_table.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../utill/custom_themes.dart';
import '../../../../utill/dimensions.dart';
import '../../../baseWidget/title_row.dart';
import '../specification_screen.dart';


class ProductSpecification extends StatelessWidget {
  final String productSpecification;
  ProductSpecification({@required this.productSpecification});

  @override
  Widget build(BuildContext context) {

    if(Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    return Column(
      children: [
        TitleRow(title: 'specification', isDetailsPage: true,),
        SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),


        productSpecification != null ?
        Expanded(child: Html(data: productSpecification,
          tagsList: Html.tags,
          customRenders: {
            tableMatcher(): tableRender(),
          },
          style: {
            "table": Style(
              backgroundColor: Color.fromARGB(0x50, 0xee, 0xee, 0xee),
            ),
            "tr": Style(
              border: Border(bottom: BorderSide(color: Colors.grey)),
            ),
            "th": Style(
              padding: EdgeInsets.all(6),
              backgroundColor: Colors.grey,
            ),
            "td": Style(
              padding: EdgeInsets.all(6),
              alignment: Alignment.topLeft,
            ),

          },),
        ) :
        Center(child: Text('No specification')),
        SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),


        InkWell(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SpecificationScreen(specification: productSpecification))),
            child: Text('view full detail',
              style: titleRegular.copyWith(color: Theme.of(context).primaryColor),))

      ],
    );
  }
}
