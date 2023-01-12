import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gaadi_part/helper/shared_preference.dart';
import 'package:gaadi_part/utill/app_constants.dart';
import 'package:gaadi_part/view/Screen/auth/widget/social_login_widget.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../../utill/custom_themes.dart';
import '../../../../utill/dimensions.dart';
import '../../../baseWidget/textField/custom_password_textfield.dart';
import '../../../baseWidget/textField/custom_textfield.dart';
import '../../dashboard/dashboard_screen.dart';
import '../../more/profile_controller/profile_controller.dart';
import '../forget_password.dart';

class SignInWidget extends StatefulWidget {
  @override
  _SignInWidgetState createState() => _SignInWidgetState();
}

class _SignInWidgetState extends State<SignInWidget> {
  final profileController = Get.put(ProfileController());
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  GlobalKey<FormState> _formKeyLogin;
  bool isRemember = false;

  @override
  void initState() {
    super.initState();
  }

  FocusNode _emailNode = FocusNode();
  FocusNode _passNode = FocusNode();
  bool isLoading = false;

  void loginUser() async {
    if (_emailController.text.isEmpty) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Email_field_is_required'),
        backgroundColor: Colors.red,
      ));
    } else if (!_emailController.text.contains("@gmail")) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Enter a valid email'),
        backgroundColor: Colors.red,
      ));
    } else if (_passwordController.text.isEmpty) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Password field is required'),
        backgroundColor: Colors.red,
      ));
    } else {
      Map data = {
        'email': _emailController.text,
        'password': _passwordController.text
      };
                   print("LoginMapdata"+data.toString());
      var response =
          await http.post(Uri.parse(AppConstants.LOGIN_URI), body: data);

      print(response.statusCode);
      print("Tokenn___${response.body}");
      if (response.statusCode != 302) {
        var res = json.decode(response.body);

        try {
          if (response.statusCode == 200) {
            setState(() {
              isLoading = false;
            });
            print("Tokenn___${res['access_token']}------------------------------------------");
            await HelperFunction.saveToken(await res['access_token']);
            String userId = res['user_id'].toString();
            await HelperFunction.saveUserId(userId);
            await HelperFunction.saveLogin("true");
            String getToken=await HelperFunction.getToken();
            print("+++++++"+getToken.length.toString()+"+++++++++");
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => DashBoardScreen()));
          }
        } catch (e) {
          print(e);
        }
      } else {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Invalid credentials'),
          backgroundColor: Colors.red,
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: Dimensions.MARGIN_SIZE_LARGE),
      child: Form(
        key: _formKeyLogin,
        child: ListView(
          padding:
              EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL),
          children: [
            Container(
                margin: EdgeInsets.only(bottom: Dimensions.MARGIN_SIZE_SMALL),
                child: CustomTextField(
                  hintText: 'ENTER YOUR EMAIL or mobile ',
                  focusNode: _emailNode,
                  nextNode: _passNode,
                  textInputType: TextInputType.emailAddress,
                  controller: _emailController,
                )),

            Container(
                margin: EdgeInsets.only(bottom: Dimensions.MARGIN_SIZE_DEFAULT),
                child: CustomPasswordTextField(
                  hintTxt: 'ENTER YOUR PASSWORD',
                  textInputAction: TextInputAction.done,
                  focusNode: _passNode,
                  controller: _passwordController,
                )),

            Container(
              margin: EdgeInsets.only(right: Dimensions.MARGIN_SIZE_SMALL),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  /*   Row(
                    children: [
                      Checkbox(
                        value: this.isRemember,
                        onChanged: (bool isRemember) {
                          setState(() {
                            this.isRemember = isRemember;
                          });
                        },
                      ),
                      Text('REMEMBER', style: titilliumRegular),
                    ],
                  ),*/
                  InkWell(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => ForgetPasswordScreen())),
                    child: Text('FORGET PASSWORD'),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 30),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    isLoading = true;
                  });
                  print(_emailController.text);
                  print(_passwordController.text);
                  loginUser();
                },
                style: ElevatedButton.styleFrom(primary: Colors.black),
                child: (!isLoading)
                    ? Text(
                        "Sign In",
                        style: TextStyle(color: Colors.white),
                      )
                    : CircularProgressIndicator(color: Colors.white),
              ),
            ),
            // CustomButton(onTap: loginUser, buttonText:'SIGN_IN'),),

            SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT),

            SocialLoginWidget(),

            SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT),

            Center(
                child: Text('OR',
                    style: titilliumRegular.copyWith(
                        fontSize: Dimensions.FONT_SIZE_DEFAULT))),

            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) => DashBoardScreen()));
                HelperFunction.saveLogin('false');
              },
              child: Container(
                margin: EdgeInsets.only(
                    left: Dimensions.MARGIN_SIZE_AUTH,
                    right: Dimensions.MARGIN_SIZE_AUTH,
                    top: Dimensions.MARGIN_SIZE_AUTH_SMALL),
                width: double.infinity,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'CONTINUE AS GUEST',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
