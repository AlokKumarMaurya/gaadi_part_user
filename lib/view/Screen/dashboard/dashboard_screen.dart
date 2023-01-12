import 'package:flutter/material.dart';
import 'package:gaadi_part/data/DAshboard%20Repository/dashboadRepository.dart';
import 'package:provider/provider.dart';

import '../../../data/model/response/Dashboard Categories/category_model.dart';
import '../../../data/model/response/config_model.dart';
import '../../../utill/images.dart';
import '../cart/cart_screen.dart';
import '../chat/inbox_screen.dart';
import '../home/home_screen.dart';
import '../more/more_screen.dart';
import '../notification/notification_screen.dart';
import '../order/order_screen.dart';

class DashBoardScreen extends StatefulWidget {

  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  PageController _pageController = PageController();
  int _pageIndex = 0;
  List<Widget> _screens ;
  DashboardApiClient _dashboardApiClient = DashboardApiClient();
  GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();
  CategoryModel _categoryModel;
  ConfigModel _configModel;

  bool singleVendor = false;
  @override
  void initState() {
    super.initState();

    _screens = [
      HomePage(),
      singleVendor? NotificationScreen(isBacButtonExist: false): OrderScreen(isBacButtonExist: false),
      singleVendor?OrderScreen(isBacButtonExist: false): CartScreen() ,

      //singleVendor? MoreScreen(): NotificationScreen(isBacButtonExist: false),
      singleVendor?SizedBox(): MoreScreen(),
    ];

  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if(_pageIndex != 0) {
          _setPage(0);
          return false;
        }else {
          return true;
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Theme.of(context).textTheme.bodyText1.color,
          showUnselectedLabels: true,
          currentIndex: _pageIndex,
          type: BottomNavigationBarType.fixed,
          items: _getBottomWidget(singleVendor),
          onTap: (int index) {
            _setPage(index);
          },
        ),
        body: PageView.builder(
          controller: _pageController,
          itemCount: _screens.length,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index){
            return _screens[index];
          },
        ),
      ),
    );
  }

  BottomNavigationBarItem _barItem(String icon, String label, int index) {
    return BottomNavigationBarItem(
      icon: Image.asset(icon, color: index == _pageIndex ?
      Theme.of(context).primaryColor : Theme.of(context).textTheme.bodyText1.color.withOpacity(0.5),
        height: 25, width: 25,
      ),
      label: label,
    );
  }

  void _setPage(int pageIndex) {
    setState(() {
      _pageController.jumpToPage(pageIndex);
      _pageIndex = pageIndex;
    });
  }

  List<BottomNavigationBarItem> _getBottomWidget(bool isSingleVendor) {
    List<BottomNavigationBarItem> _list = [];

    if(!isSingleVendor){
      _list.add(_barItem(Images.home_image, 'home', 0));
      //_list.add(_barItem(Images.message_image,'inbox', 1));
      _list.add(_barItem(Images.shopping_image, 'orders', 1));
      _list.add(_barItem(Images.cart_image, 'cart', 2));
      _list.add(_barItem(Images.profileImage,'Profile', 3));
    }else{
      _list.add(_barItem(Images.home_image, 'home', 0));
      _list.add(_barItem(Images.shopping_image, 'orders', 1));
     // _list.add(_barItem(Images.notification, 'notification',  2));
      _list.add(_barItem(Images.profileImage, 'Profile', 2));
    }

    return _list;
  }

}