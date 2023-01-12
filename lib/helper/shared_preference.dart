import 'dart:ffi';

import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HelperFunction{

  static const String SharedPreferencestokenKey = "TokenKey";
  static const String SharedPreferencesUserIdKey = "UserIdKey";
  static const String SharedPreferencesisLoged = "Loginkey";
  static const String CatUrl = "CatUrlkey";
  static const String ProThumUrl = "ProThumUrlkey";
  static const String BrandImageUrl = "BrandImageUrlKey";


  static Future saveToken(token) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(SharedPreferencestokenKey, token);
  }

  static Future saveUserId(userId) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(SharedPreferencesUserIdKey, userId);
  }

  static Future getToken() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(SharedPreferencestokenKey);
  }

  static Future getUserId() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(SharedPreferencesUserIdKey);
  }

  static Future saveLogin(islog) async{
    SharedPreferences preferances = await SharedPreferences.getInstance();
    return await preferances.setString(SharedPreferencesisLoged, islog);
  }

  static Future getLogin() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(SharedPreferencesisLoged);
  }


  //Config BaseUrl
  static Future saveCategory_image_url(catUrl) async{
    SharedPreferences preferances = await SharedPreferences.getInstance();
    return await preferances.setString(CatUrl, catUrl);
  }

  static Future saveProductThumnail_image_url(proThumUrl) async{
    SharedPreferences preferances = await SharedPreferences.getInstance();
    return await preferances.setString(ProThumUrl, proThumUrl);
  }

  static Future saveBrand_image_url(brandUrl) async{
    SharedPreferences preferances = await SharedPreferences.getInstance();
    return await preferances.setString(BrandImageUrl, brandUrl);
  }

  static Future getCategory_image_url() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(CatUrl);
  }

  static Future getProductThumnail_image_url() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(ProThumUrl);
  }

  static Future getBrand_image_url() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(BrandImageUrl);
  }
}