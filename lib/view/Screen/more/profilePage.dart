import 'package:flutter/material.dart';
import 'package:gaadi_part/view/Screen/cart/cart_screen.dart';

import '../../../data/DAshboard Repository/dashboadRepository.dart';
// import '../../../data/model/response/getcartItems.dart';
import '../../../utill/dimensions.dart';
import '../../../utill/images.dart';
import '../home/home_screen.dart';
import '../search/search_screen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // const ProfileScreen({Key key}) : super(key: key);
  final ScrollController _scrollController = ScrollController();

  bool isLoading=true;

  // getCartList()async
  // {
  //   var getCartNumber= await DashboardApiClient().GetCartList();
  //   print(getCartNumber);
  //   if(getCartNumber!=null)
  //   {
  //     print("sdsdssdsd");
  //     print(getCartNumber);
  //     setState(() {
  //       isLoading=false;
  //       getcartiteam=getCartNumber;
  //     });
  //   }
  //   else
  //   {
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //       content: Text(getCartNumber.toString()),
  //       backgroundColor: Colors.red,
  //     ));
  //   }
  // }







  @override
  void initState() {
    // TODO: implement initState
    print("2222222222222222222222222222");
    // getCartList();
    print("2222222222222222222222222222");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor:Theme.of(context).highlightColor ,
          title: Image.asset(Images.logo_with_name_image, height: 35),
          centerTitle: false,
          actions: [
            Icon(Icons.person,color: Colors.black,)
          ],
          elevation: 0,
          automaticallyImplyLeading: false,
        ),
        body:SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  // alignment: Alignment.center,
                  child: Text("Dashboard"),),

                SizedBox(height: 15,),
                Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(color: Color(0xffe83e8c),borderRadius: BorderRadius.circular(6)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0,top: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10,),
                        Text("0 Products ",style: TextStyle(fontSize: 30,color: Colors.white,fontWeight: FontWeight.w500),),
                        SizedBox(height: 5,),
                        Text("In your Cart",style: TextStyle(fontSize: 13,color: Colors.white,fontWeight: FontWeight.w500))
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10,),


                Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(color: Color(0xff6f42c1),borderRadius: BorderRadius.circular(6)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0,top: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10,),
                        Text("Products ",style: TextStyle(fontSize: 30,color: Colors.white,fontWeight: FontWeight.w500),),
                        SizedBox(height: 5,),
                        Text("In your wishlist",style: TextStyle(fontSize: 13,color: Colors.white,fontWeight: FontWeight.w500))
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10,),



                Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(color: Color(0xff17a2b8),borderRadius: BorderRadius.circular(6)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0,top: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10,),
                        Text("0 Products ",style: TextStyle(fontSize: 30,color: Colors.white,fontWeight: FontWeight.w500),),
                        SizedBox(height: 5,),
                        Text("you orderd",style: TextStyle(fontSize: 13,color: Colors.white,fontWeight: FontWeight.w500))
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20,),

                Text("Default Shipping Address")
              ],
            ),
          ),
        )
    );
  }
}
