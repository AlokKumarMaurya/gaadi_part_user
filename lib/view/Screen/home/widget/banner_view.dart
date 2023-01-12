import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gaadi_part/utill/app_constants.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';

import '../../../../data/DAshboard Repository/dashboadRepository.dart';
import '../../../../data/model/response/Dashboard Categories/mainBanner_model.dart';
import '../../../../utill/images.dart';

class BannersView extends StatefulWidget {
  @override
  State<BannersView> createState() => _BannersViewState();
}

class _BannersViewState extends State<BannersView> {

  MainBannerModel _mainBannerModel;
  bool isLoading=true;
  mainBanner() async {
    print("ghusa");
    var MainBannerResponse = await DashboardApiClient().DashBoardMainBanner();

    if (MainBannerResponse != null) {
      setState(() {
        isLoading=false;
        _mainBannerModel = MainBannerResponse;
        print("asdassdsdaasdadssda"+MainBannerResponse.data.toString());
      });
      return _mainBannerModel;
    } else {
      print("asdas"+MainBannerResponse.data.toString());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(MainBannerResponse.toString()),
        backgroundColor: Colors.red,
      ));
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    print("asdasddsadasdasasasdadinit");
    mainBanner();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return isLoading?

    Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        height:150,
        width: MediaQuery.of(context).size.width,
        child:
        // GridView.builder(
        //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //     crossAxisCount: 1,
        //     // childAspectRatio: (1/1.3),
        //     mainAxisSpacing: 10,
        //     crossAxisSpacing: 5,
        //   ),
        //   itemCount:  1 ,
        //   shrinkWrap: true,
        //
        //   // physics: isHomePage ? NeverScrollableScrollPhysics() : null,
        //   itemBuilder: (BuildContext context, int index) {

        // return
        Shimmer.fromColors(
          baseColor: Colors.grey[300],
          highlightColor: Colors.grey[100],
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Expanded(child: Container(decoration: BoxDecoration(color: Color(0xffFFFFFF),borderRadius: BorderRadius.circular(14)))),
            // Container(height: 10, color: Color(0xffFFFFFF), margin: EdgeInsets.only(left: 25, right: 25)),
          ]),
        )

      // },
      // ),
    )

        :(_mainBannerModel!=null? Column(
      children: [
        Container(
            width: _width,
            height: _width * 0.4,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CarouselSlider.builder(
                  options: CarouselOptions(
                    viewportFraction: 1,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    disableCenter: true,
                    onPageChanged: (index, reason) {
                    },
                  ),
                  itemCount: _mainBannerModel.data.length,
                  itemBuilder: (context, index, _) {
                    return InkWell(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(width:  _width, height: 200,

                              child: FadeInImage.assetNetwork(
                                fit: BoxFit.cover,
                                placeholder: Images.placeholder,
                                image: 'https://softfix.in/demo/gaadipart/public/'+"${ _mainBannerModel.data[index].photo}",
                                imageErrorBuilder: (c, o, s) => Image.asset(Images.placeholder, fit: BoxFit.cover,),
                              ),)
                        ),
                      ),
                    );
                  },
                ),

                Positioned(
                    bottom: 5,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TabPageSelectorIndicator(
                          backgroundColor: Theme.of(context).primaryColor,
                          borderColor: Theme.of(context).primaryColor,
                          size: 10,
                        )
                      ],
                    )
                ),
              ],
            )
        ),

        SizedBox(height: 5),
      ],
    ):Container());
  }
}