import 'package:flutter/material.dart';
import '../data/model/body/login_model.dart';
import '../data/model/response/base/api_response.dart';
import '../data/model/response/base/error_response.dart';
import '../data/repository/auth_repo.dart';

class AuthProvider with ChangeNotifier {
  final AuthRepo authRepo;
  AuthProvider({@required this.authRepo});

  bool _isLoading = false;
  // bool _isRemember = false;
  int _selectedIndex = 0;
  int get selectedIndex =>_selectedIndex;

  updateSelectedIndex(int index){
    _selectedIndex = index;
    notifyListeners();
  }


  bool get isLoading => _isLoading;
  // bool get isRemember => _isRemember;

  // void updateRemember(bool value) {
  //   _isRemember = value;
  //   notifyListeners();
  // }

  Future login(LoginModel loginBody) async {
    print("Login________");
    _isLoading = true;
    notifyListeners();
    ApiResponse apiResponse = await authRepo.login(loginBody);
    _isLoading = false;
    if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
      print("Loginnnnnnnn________");
      Map map = apiResponse.response.data;
      String temporaryToken = '';
      String token = '';
      String message = '';
      // String id = '';
      
      // String token = map["token"];

      try{
        message = map["message"];

      }catch(e){

      }
      try{
        token = map["token"];

      }catch(e){

      }
      try{
        temporaryToken = map["temporary_token"];

      }catch(e){

      }
      
      // callback(true, token, temporaryToken, message);
      // print("idddddddddddddddddddddddddd---------------"+id);
      notifyListeners();
    } else {
      String errorMessage;
      if (apiResponse.error is String) {
        print(apiResponse.error.toString());
        errorMessage = apiResponse.error.toString();
      } else {
        ErrorResponse errorResponse = apiResponse.error;
        print(errorResponse.errors[0].message);
        errorMessage = errorResponse.errors[0].message;
      }
      // callback(false, '', '' , errorMessage);
      notifyListeners();
    }
  }
}
