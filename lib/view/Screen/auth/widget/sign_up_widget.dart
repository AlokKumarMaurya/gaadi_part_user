import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gaadi_part/utill/app_constants.dart';
import 'package:gaadi_part/view/Screen/auth/auth_screen.dart';
import 'package:gaadi_part/view/Screen/auth/widget/sign_in_widget.dart';
import 'package:gaadi_part/view/Screen/auth/widget/social_login_widget.dart';
import 'package:http/http.dart' as http;
import '../../../../utill/dimensions.dart';
import '../../../baseWidget/textField/custom_password_textfield.dart';
import '../../../baseWidget/textField/custom_textfield.dart';
import '../../dashboard/dashboard_screen.dart';


class SignUpWidget extends StatefulWidget {
  @override
  _SignUpWidgetState createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  GlobalKey<FormState> _formKey;

  FocusNode _fNameFocus = FocusNode();
  FocusNode _lNameFocus = FocusNode();
  FocusNode _emailFocus = FocusNode();
  FocusNode _phoneFocus = FocusNode();
  FocusNode _passwordFocus = FocusNode();
  FocusNode _confirmPasswordFocus = FocusNode();

  bool isEmailVerified = false;
  bool isLoading=false;

  addUser() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      isEmailVerified = true;

      String _firstName = _firstNameController.text.trim();
      String _lastName = _lastNameController.text.trim();
      String _email = _emailController.text.trim();
      String _phone = _phoneController.text.trim();
      String _phoneNumber = _countryDialCode+_phoneController.text.trim();
      String _password = _passwordController.text.trim();
      String _confirmPassword = _confirmPasswordController.text.trim();

      if (_firstName.isEmpty) {
        setState(() {
          isLoading=false;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('first_name_field_is_required'),
          backgroundColor: Colors.red,
        ));
      }else if (_lastName.isEmpty) {
        setState(() {
          isLoading=false;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('last_name_field_is_required'),
          backgroundColor: Colors.red,
        ));
      } else if (_email.isEmpty) {
        setState(() {
          isLoading=false;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('EMAIL_MUST_BE_REQUIRED'),
          backgroundColor: Colors.red,
        ));
      }
      else if (!_emailController.text.contains("@gmail.com")) {
        setState(() {
          isLoading=false;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(('enter_valid_email_address')),
          backgroundColor: Colors.red,
        ));
      }
      else if (_phone.isEmpty) {
        setState(() {
          isLoading=false;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('PHONE_MUST_BE_REQUIRED'),
          backgroundColor: Colors.red,
        ));
      }
      else if(_phone.length!=10 && _phone.length!=12)
      {
        setState(() {
          isLoading=false;
        });
        print(_phone.length);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Enter a valid phone number'),
          backgroundColor: Colors.red,
        ));
      }

      else if (_password.isEmpty) {
        setState(() {
          isLoading=false;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('PASSWORD_MUST_BE_REQUIRED'),
          backgroundColor: Colors.red,
        ));
      }
      else if(_password.length <7 ){
        setState(() {
          isLoading=false;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('PASSWORD_MUST_BE_Atleast 8 character'),
          backgroundColor: Colors.red,
        ));

      }
      else if (_confirmPassword.isEmpty) {
        setState(() {
          isLoading=false;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('CONFIRM_PASSWORD_MUST_BE_REQUIRED'),
          backgroundColor: Colors.red,
        ));
      } else if (_password != _confirmPassword) {
        setState(() {
          isLoading=false;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('PASSWORD_DID_NOT_MATCH',),
          backgroundColor: Colors.red,
        ));
      } else {
        print("fName.text"+_firstNameController.text);
        print("lName.text"+_lastNameController.text);
        print("email.text"+_emailController.text);
        print("phone.text"+_phoneNumber.toString());
        print("password.text"+_passwordController.text);

        Map data = {
          'name': _firstNameController.text,
          'email': _emailController.text,
          'password': _passwordController.text
        };
        var response = await http.post(Uri.parse(AppConstants.REGISTRATION_URI), body: data);
        var res = await jsonDecode(response.body);
        print("response++++++++${response.body}");
        if(response.statusCode == 201){
          setState(() {
            isLoading=false;
          });
          Fluttertoast.showToast(msg: "Registered Successfull");

          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => AuthScreen(initialPage: 0,)));
        }


      }
    } else {
      isEmailVerified = false;
    }
  }


  String _countryDialCode = "+880";
  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {

    return ListView(
      padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL),
      children: [
        Form(
          key: _formKey,
          child: Column(
            children: [
              // for first and last name
              Container(
                margin: EdgeInsets.only(left: Dimensions.MARGIN_SIZE_DEFAULT, right: Dimensions.MARGIN_SIZE_DEFAULT),
                child: Row(
                  children: [
                    Expanded(child: CustomTextField(
                      hintText: 'FIRST NAME',
                      textInputType: TextInputType.name,
                      focusNode: _fNameFocus,
                      nextNode: _lNameFocus,
                      isPhoneNumber: false,
                      capitalization: TextCapitalization.words,
                      controller: _firstNameController,)),
                    SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT),


                    Expanded(child: CustomTextField(
                      hintText: 'LAST NAME',
                      focusNode: _lNameFocus,
                      nextNode: _emailFocus,
                      capitalization: TextCapitalization.words,
                      controller: _lastNameController,)),
                  ],
                ),
              ),



              Container(
                margin: EdgeInsets.only(left: Dimensions.MARGIN_SIZE_DEFAULT, right: Dimensions.MARGIN_SIZE_DEFAULT,
                    top: Dimensions.MARGIN_SIZE_SMALL),
                child: CustomTextField(
                  hintText: 'ENTER YOUR EMAIL',
                  focusNode: _emailFocus,
                  nextNode: _phoneFocus,
                  textInputType: TextInputType.emailAddress,
                  controller: _emailController,
                ),
              ),



              Container(
                margin: EdgeInsets.only(left: Dimensions.MARGIN_SIZE_DEFAULT,
                    right: Dimensions.MARGIN_SIZE_DEFAULT, top: Dimensions.MARGIN_SIZE_SMALL),
                child: Row(children: [
                  // CodePickerWidget(
                  //   onChanged: (CountryCode countryCode) {
                  //     _countryDialCode = countryCode.dialCode;
                  //   },
                  //   initialSelection: _countryDialCode,
                  //   favorite: [_countryDialCode],
                  //   showDropDownButton: true,
                  //   padding: EdgeInsets.zero,
                  //   showFlagMain: true,
                  //   textStyle: TextStyle(color: Theme.of(context).textTheme.headline1.color),
                  //
                  // ),

                  Expanded(child: CustomTextField(
                    hintText: 'ENTER MOBILE NUMBER',
                    controller: _phoneController,
                    focusNode: _phoneFocus,
                    nextNode: _passwordFocus,
                    isPhoneNumber: true,
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.phone,

                  )),
                ]),
              ),




              Container(
                margin: EdgeInsets.only(left: Dimensions.MARGIN_SIZE_DEFAULT,
                    right: Dimensions.MARGIN_SIZE_DEFAULT, top: Dimensions.MARGIN_SIZE_SMALL),
                child: CustomPasswordTextField(
                  hintTxt: 'PASSWORD',
                  controller: _passwordController,
                  focusNode: _passwordFocus,
                  nextNode: _confirmPasswordFocus,
                  textInputAction: TextInputAction.next,
                ),
              ),



              Container(
                margin: EdgeInsets.only(left: Dimensions.MARGIN_SIZE_DEFAULT,
                    right: Dimensions.MARGIN_SIZE_DEFAULT, top: Dimensions.MARGIN_SIZE_SMALL),
                child: CustomPasswordTextField(
                  hintTxt: 'RE ENTER PASSWORD',
                  controller: _confirmPasswordController,
                  focusNode: _confirmPasswordFocus,
                  textInputAction: TextInputAction.done,
                ),
              ),
            ],
          ),
        ),



        Container(
          margin: EdgeInsets.only(left: Dimensions.MARGIN_SIZE_LARGE, right: Dimensions.MARGIN_SIZE_LARGE,
              bottom: Dimensions.MARGIN_SIZE_LARGE, top: Dimensions.MARGIN_SIZE_LARGE),
          child: ElevatedButton(
            onPressed: (){
              setState(() {
                isLoading=true;
              });
              addUser();},
            style: ElevatedButton.styleFrom(primary: Colors.black),
            /* style: ButtonStyle(
                backgroundColor:
                MaterialStatePropertyAll<Color>(Colors.black)),*/
            child: (!isLoading)?Text("Sign Up", style: TextStyle(color: Colors.white),):CircularProgressIndicator(color: Colors.white,),
          ),
        ),

        SocialLoginWidget(),

        // for skip for now
        Center(
            child: Row(mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [TextButton(
                // Widget: Text(),
                onPressed: () =>
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => DashBoardScreen())),
                child: Text('SKIP FOR NOW', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
                Icon(Icons.arrow_forward, size: 15,)
              ],
            )),
      ],
    );
  }
}