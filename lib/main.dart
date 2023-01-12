import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:gaadi_part/provider/auth_provider.dart';
import 'package:gaadi_part/utill/app_constants.dart';
import 'package:gaadi_part/view/Screen/cart/widget/cart_widget.dart';
import 'package:gaadi_part/view/Screen/order/order_details_screen.dart';
import 'package:gaadi_part/view/Screen/search/search_screen.dart';
import 'package:gaadi_part/view/Screen/splash/splash_screen.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//updatedrsr
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final NotificationAppLaunchDetails notificationAppLaunchDetails =
  await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  int _orderID;
  if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
    _orderID = (notificationAppLaunchDetails.payload != null &&
        notificationAppLaunchDetails.payload.isNotEmpty)
        ? int.parse(notificationAppLaunchDetails.payload) : null;
  }

  runApp(
      MultiProvider(
          providers: [
      ChangeNotifierProvider<AuthProvider>(create: (context) => AuthProvider()),
      ChangeNotifierProvider<SearchHistory>(create: (context) => SearchHistory())
  ],

  child: MyApp(orderId: _orderID)
  )
  ,
  );
}

class MyApp extends StatelessWidget {
  final int orderId;

  MyApp({@required this.orderId});
//lmgkugngbyfvkigfkdyctkxytki
  static final navigatorKey = new GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    List<Locale> _locals = [];
    AppConstants.languages.forEach((language) {
      _locals.add(Locale(language.languageCode, language.countryCode));
    });
    return GetMaterialApp(
      title: AppConstants.APP_NAME,
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(),
      supportedLocales: _locals,
      home: orderId == null ? SplashScreen() : OrderDetailsScreen(),
    );
  }
}
