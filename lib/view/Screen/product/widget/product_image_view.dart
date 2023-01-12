import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../constantWiget/appBottomSheet.dart';
import '../../../../helper/shared_preference.dart';
import '../../../../utill/custom_themes.dart';
import '../../../../utill/dimensions.dart';
import '../../../../utill/images.dart';
import '../../auth/auth_screen.dart';
import 'favourite_button.dart';

class ProductImageView extends StatelessWidget {
  List image;
  ProductImageView({@required this.image});

  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          child:
          Container(
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
              boxShadow: [BoxShadow(color: Colors.grey[ 300],
                  spreadRadius: 1, blurRadius: 5)],
              gradient: LinearGradient(
                colors: [Color(0xffFFFFFF),Color(0xffE2F0FF)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Stack(children: [
              SizedBox(
                height: MediaQuery.of(context).size.width,
                child:
                PageView.builder(
                  controller: _controller,
                  itemCount: image.length,
                  itemBuilder: (context, index) {
                    return FadeInImage.assetNetwork(fit: BoxFit.cover,
                      placeholder: Images.placeholder, height: MediaQuery.of(context).size.width,
                      width: MediaQuery.of(context).size.width,
                      image: 'https://softfix.in/demo/gaadipart/public/${image[index]}',
                      imageErrorBuilder: (c, o, s) => Image.asset(
                        Images.placeholder, height: MediaQuery.of(context).size.width,
                        width: MediaQuery.of(context).size.width,fit: BoxFit.cover,
                      ),
                    );
                  },
                  onPageChanged: (index) {
                    // Provider.of<ProductDetailsProvider>(context, listen: false).setImageSliderSelectedIndex(index);
                  },
                ),
              ),


              Positioned(left: 0, right: 0, bottom: 30,
                child: Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(),
                    Spacer(),
                    Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: _indicators(context),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: Dimensions.PADDING_SIZE_DEFAULT,bottom: Dimensions.PADDING_SIZE_DEFAULT),
                      child: Text(''),
                    ),
                  ],
                ),
              ),
              Positioned(top: 16, right: 16,
                child: Column(
                  children: [
                    FavouriteButton(
                      backgroundColor: Colors.black,
                      favColor: Colors.redAccent,
                      isSelected: true,
                      productId: 3,
                    ),
                    SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),


                    InkWell(
                      onTap: () async{
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
                        child: Container(width: 30, height: 30,
                          decoration: BoxDecoration(color: Theme.of(context).primaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.share, color: Theme.of(context).cardColor, size: Dimensions.ICON_SIZE_SMALL),
                        ),
                      ),
                    )
                  ],
                ),
              ),


              // productModel.unitPrice !=null && productModel.discount != 0 ?
              // Positioned(
              //   left: 0,top: 0,
              //   child: Column(
              //     children: [
              //       Container(
              //         padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
              //         alignment: Alignment.center,
              //         decoration: BoxDecoration(
              //           color: Theme.of(context).primaryColor,
              //           borderRadius: BorderRadius.only(bottomRight: Radius.circular(Dimensions.PADDING_SIZE_SMALL))
              //         ),
              //         child: Text(categoryProductModel.priceLower.toString(),
              //           style: titilliumRegular.copyWith(color: Theme.of(context).cardColor, fontSize: Dimensions.FONT_SIZE_LARGE),
              //         ),
              //       ),
              //
              //     ],
              //   ),
              // ) ,
              SizedBox.shrink(),


            ]),
          ),
        ),

      ],
    );
  }

  List<Widget> _indicators(BuildContext context) {
    List<Widget> indicators = [];
    for (int index = 0; index < image.length; index++) {
      indicators.add(TabPageSelectorIndicator(
        backgroundColor: Theme.of(context).primaryColor,
        borderColor: Colors.white,
        size: 10,
      ));
    }
    return indicators;
  }

}
