import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:gaadi_part/data/DAshboard%20Repository/dashboadRepository.dart';
import 'package:gaadi_part/helper/shared_preference.dart';
import 'package:gaadi_part/view/Screen/auth/widget/sign_up_widget.dart';
import 'package:gaadi_part/view/Screen/more/profilePage.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';
import '../../../data/model/body/userInfoModal.dart';
import '../../../data/model/response/htmlModal.dart';
import '../../../utill/app_constants.dart';
import '../../../utill/dimensions.dart';
import '../../../utill/images.dart';
import '../auth/auth_screen.dart';
import '../auth/widget/sign_in_widget.dart';
import '../checkout/checkout_controller.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({Key key}) : super(key: key);

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  // final _checkoutController = Get.put(CheckOutController());
  UserInfo userinfo;
  bool isGuest = false;
  String name;
  String address;
  String email;
  String phoneNumber;
  String Privacy;
  String TermsAndConditions;
  String returnPlocicy;
  String SupportPolicy;
  bool isLoading = true;

  getUserInfo() async {
    var userinfoResponse = await DashboardApiClient().MoreUserInfo();
    if (userinfoResponse != null) {
      setState(() {
        userinfo = userinfoResponse;
        isLoading = false;
      });
      return userinfo;
    } else {
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //   content: Text(userinfo.toString()),
      //   backgroundColor: Colors.red,
      // ));
      setState(() {
        isLoading = false;
      });
    }
  }

  showBottomsheet() {
    showModalBottomSheet(
        isDismissible: false,
        isScrollControlled: true,
        context: context,
        builder: (builder) {
          return Container(
            height: MediaQuery
                .of(context)
                .size
                .height / 1.5,
            padding: EdgeInsets.only(left: 10, right: 10, top: 10),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 10, right: 10, top: 0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black26),
                      borderRadius: BorderRadius.circular(12)),
                  child: TextFormField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter name",
                        label: Text("Name")),
                    onChanged: (val) {
                      setState(() {
                        name = val;
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.only(left: 10, right: 10, top: 0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black26),
                      borderRadius: BorderRadius.circular(12)),
                  child: TextFormField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter address",
                        label: Text("Address")),
                    onChanged: (val) {
                      setState(() {
                        address = val;
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.only(left: 10, right: 10, top: 0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black26),
                      borderRadius: BorderRadius.circular(12)),
                  child: TextFormField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter email",
                        label: Text("Email")),
                    onChanged: (val) {
                      setState(() {
                        email = val;
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.only(left: 10, right: 10, top: 0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black26),
                      borderRadius: BorderRadius.circular(12)),
                  child: TextFormField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter phoneNumber",
                        label: Text("PhoneNumber")),
                    onChanged: (val) {
                      setState(() {
                        phoneNumber = val;
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    TextButton(
                        onPressed: () {
                          print("22222222222222222222");
                          updateUserInfo();

                          print("3333333333333333333333333");
                        },
                        child: Text("Submit")),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Close")),
                  ],
                )
              ],
            ),
          );
        });
  }

  checkGuest() async {
    var token = await HelperFunction.getToken();
    print(token);
    print("12121223456^7768878898989");
    if (token == null || token == "") {
      setState(() {
        isGuest = true;
      });
    }
  }

  updateUserInfo() async {
    String SharedPreferencesUserIdKey = "UserIdKey";
    String SharedPreferencestokenKey = "TokenKey";
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var id = await preferences.getString(SharedPreferencesUserIdKey);
    var token = await preferences.getString(SharedPreferencestokenKey);
    var api = Uri.parse(AppConstants.USER_INFO_UPDATE);
    try {
      final response = await http.post(api, body: {
        "user_id": "16",
        "name": name,
        "address": address,
        "email": email,
        "country": "",
        "city": "",
        "postal_code": "",
        "phone": phoneNumber,
      }, headers: {
        'Authorization': 'Bearer $token'
      });
      print(response.statusCode.toString());
      print(response.body);
      print("555555555555555555");
      if (response.statusCode == 200) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Profile Updated successfully"),
          backgroundColor: Colors.red,
        ));
      }
    } catch (e) {
      print(e);
      print("44444444444444444444");
    }
  }

  var privacypolicy = PrivacyPolicy();
  var termsAndconditions = PrivacyPolicy();
  var retutnpolicy = PrivacyPolicy();
  var supportApi = PrivacyPolicy();

  getPrivacyPolicy() async {
    var response = await DashboardApiClient()
        .GETPrivacyPolicy(AppConstants.GET_PRIVACY_POLICY);

    if (response != null) {
      setState(() {
        privacypolicy = response;
        Privacy = privacypolicy.data[0].content;
      });
      print(privacypolicy.data[0].content);
    }
  }

  getTermsAndConditions() async {
    var api = Uri.parse(AppConstants.TERMS_AND_CONDITIONS);

    var response = await http.get(api);
    var aa = jsonDecode(response.body);
    if (response != null) {
      setState(() {
        TermsAndConditions = aa["content"];
        //Privacy=termsAndconditions.data[0].content;
      });
      print(response);
    }
  }

  getReturnPolicy() async {
    var response =
    await DashboardApiClient().GETPrivacyPolicy(AppConstants.RETURN_POLICY);

    if (response != null) {
      setState(() {
        retutnpolicy = response;
        returnPlocicy = retutnpolicy.data[0].content;
      });
      print(retutnpolicy.data[0].content);
    }
  }

  getSupportPolicy() async {
    var response =
    await DashboardApiClient().GETPrivacyPolicy(AppConstants.SUPPORT_API);

    if (response != null) {
      setState(() {
        supportApi = response;
        SupportPolicy = supportApi.data[0].content;
      });
      print(supportApi.data[0].content);
    }
  }

  @override
  void initState() {
    checkGuest();
    getUserInfo();
    getPrivacyPolicy();
    getTermsAndConditions();
    getReturnPolicy();
    getSupportPolicy();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Image.asset(
            Images.more_page_header,
            height: 100,
            fit: BoxFit.fill,
            color: Theme
                .of(context)
                .primaryColor,
          ),
        ),
        Positioned(
            top: 20,
            left: Dimensions.PADDING_SIZE_SMALL,
            right: Dimensions.PADDING_SIZE_SMALL,
            child: Row(children: [
              Padding(
                padding:
                const EdgeInsets.only(top: Dimensions.PADDING_SIZE_LARGE),
                child: Image.asset(Images.logo_with_name_image,
                    height: 35, color: Colors.black26),
              ),
              Expanded(child: SizedBox.shrink()),
              (!isGuest)
                  ? Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: InkWell(
                  onTap: () {
                    //Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProfileScreen() ));
                  },
                  child: Row(children: [
                    Text("Edit Profile"),
                    IconButton(
                        onPressed: () {
                          showBottomsheet();
                        },
                        icon: Icon(Icons.edit))
                  ]),
                ),
              )
                  : Container(),
            ])),
        isLoading
            ? Center(child: CircularProgressIndicator())
            : Container(
          margin: EdgeInsets.only(top: 120),
          decoration: BoxDecoration(
            // color: ColorResources.getIconBg(context),
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20)),
          ),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

                  Container(
                      height: 200,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.all(Radius.circular(5)),),
                      child: isGuest ? ClipRRect(
                        borderRadius: BorderRadius.circular(200),
                          child: Image.asset('assets/images/profile.jpg',)) : Image.network(
                        userinfo.data[0].avatarOriginal,scale: 200, errorBuilder: (BuildContext context, Object exception, StackTrace stacktrace){
                         return ClipRRect(
                             borderRadius: BorderRadius.circular(200),
                             child: Image.asset('assets/images/profile.jpg',));
                      },)
                  ),

                  SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                  Container(
                    child: Column(
                      children: [
                        (isGuest)
                            ? Text("Guest user")
                            : userinfo.data[0].name!=null?Text(userinfo.data[0].name):const Text("")
                      ],
                    ),
                  ),

                  const SizedBox(height: 15),
                  (!isGuest)
                      ? Container(
                    padding: const EdgeInsets.only(left: 17),
                    width: double.infinity,
                    child: Row(
                      children: [
                        const Icon(Icons.home),
                        const SizedBox(
                          width: 30,
                        ),
                        Text(userinfo.data[0].address ?? 'No address')
                      ],
                    ),
                  )
                      : Container(),

                  (!isGuest) ? SizedBox(height: 25) : Container(),
                  (!isGuest)
                      ? Container(
                    padding: EdgeInsets.only(left: 17),
                    width: double.infinity,
                    child: Row(
                      children: [
                        Icon(Icons.phone_android),
                        SizedBox(
                          width: 30,
                        ),
                        (!isGuest)
                            ? Text(userinfo.data[0].phone)
                            : Text("-")
                      ],
                    ),
                  )
                      : Container(),

                  (!isGuest) ? SizedBox(height: 25) : Container(),
                  (!isGuest)
                      ? Container(
                    padding: EdgeInsets.only(left: 17),
                    width: double.infinity,
                    child: Row(
                      children: [
                        Icon(Icons.email_outlined),
                        SizedBox(
                          width: 30,
                        ),
                        (!isGuest)
                            ? Text(userinfo.data[0].email)
                            : Text("-")
                      ],
                    ),
                  )
                      : Container(),

                  SizedBox(height: 10),

                  TitleButton(
                      image: Images.term_condition,
                      title: 'terms_condition',
                      navigateTo: WalletScreen(
                        title: 'terms_condition',
                        url: TermsAndConditions,
                      )),
                  //navigateTo: HtmlViewScreen(title: 'terms_condition',)),
                  // url: Provider.of<SplashProvider>(context, listen: false).configModel.termsConditions,)),

                  TitleButton(
                      image: Images.privacy_policy,
                      title: 'privacy_policy',
                      navigateTo: WalletScreen(
                        title: 'privacy_policy',
                        url: Privacy,
                      )),
                  // navigateTo: HtmlViewScreen(title: 'privacy_policy',)),
                  // url: Provider.of<SplashProvider>(context, listen: false).configModel.termsConditions,)),

                  TitleButton(
                      image: Images.help_center,
                      title: 'Return Policy',
                      navigateTo: WalletScreen(
                        title: 'Return Policy',
                        url: returnPlocicy,
                      )),
                  // navigateTo: FaqScreen(title: 'faq', )),

                  TitleButton(
                      image: Images.about_us,
                      title: 'Support Us',
                      navigateTo: WalletScreen(
                        title: 'Support Us',
                        url: SupportPolicy,
                      )),
                  // navigateTo: HtmlViewScreen(title: 'about_us',)),
                  // url: Provider.of<SplashProvider>(context, listen: false).configModel.aboutUs,)),

                  // TitleButton(image: Images.contact_us, title: 'contact_us',
                  //     navigateTo: WalletScreen(title: 'contact_us',
                  //     // navigateTo: WebViewScreen(title: 'contact_us',
                  //       // url: Provider.of<SplashProvider>(context, listen: false).configModel.staticUrls.contactUs,
                  //     )),

                  ListTile(
                    leading: Image.asset(
                      Images.logo_image,
                      width: 25,
                      height: 25,
                      fit: BoxFit.fill,
                      color: Colors.orange,
                    ),
                    title: Text('app_info',
                        style: TextStyle(
                            fontSize: Dimensions.FONT_SIZE_LARGE)),
                    trailing: Text(AppConstants.APP_VERSION),
                  ),

                  // isGuestMode ? SizedBox() :
                  // ListTile(
                  //   leading: Icon(Icons.exit_to_app, color: Colors.orange, size: 25),
                  //   title: Text('sign_out',
                  //       style: TextStyle(fontSize: Dimensions.FONT_SIZE_LARGE)),
                  //   // onTap: () => showAnimatedDialog(context, SignOutConfirmationDialog(), isFlip: true),
                  //   onTap: (){
                  //     Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => AuthScreen()));
                  //     HelperFunction.saveToken("");
                  //   }
                  // ),

                  SizedBox(height: 5),
                  InkWell(
                    onTap: () async {
                      HelperFunction.saveToken("");
                      HelperFunction.saveLogin('false');
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AuthScreen()));
                    },
                    child: Container(
                      padding: EdgeInsets.only(left: 17),
                      width: double.infinity,
                      child: Row(
                        children: [
                          Icon(Icons.exit_to_app),
                          SizedBox(
                            width: 30,
                          ),
                          (!isGuest) ? Text("SignOut") : Text("SignIn")
                        ],
                      ),
                    ),
                  ),
                ]),
          ),
        )
      ]),
    );
  }

  GuestUi() {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          Container(
            height: 200,
            decoration:
            BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
            child: Icon(
              Icons.person,
              size: 200,
            ),
          ),
          SizedBox(
            height: 40,
          ),
          TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignInWidget()));
              },
              child: Text(
                "Login First",
                style: TextStyle(fontSize: 30),
              ))
        ],
      ),
    );
  }
}

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key key, this.title, this.url}) : super(key: key);
  final String url;
  final String title;

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    //print(widget.url+"212121212121212121212121212");
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(widget.title),
      ),
      body: Container(child: SingleChildScrollView(child: Html(data: widget.url))),
    );
  }
}

class SquareButton extends StatelessWidget {
  final String image;
  final String title;
  final Widget navigateTo;
  final int count;
  final bool hasCount;

  SquareButton({@required this.image,
    @required this.title,
    @required this.navigateTo,
    @required this.count,
    @required this.hasCount});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery
        .of(context)
        .size
        .width - 100;
    return InkWell(
      onTap: () =>
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => navigateTo)),
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: width / 4,
            height: width / 4,
            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black,
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Image.asset(image, color: Theme
                    .of(context)
                    .highlightColor),
                Positioned(
                    top: -4,
                    right: -4,
                    child: CircleAvatar(
                      radius: 7,
                      backgroundColor: Colors.red,
                      child: Text(count.toString(),
                          style: TextStyle(
                            color: Theme
                                .of(context)
                                .cardColor,
                            fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                          )),
                    ))
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Text(title,
              style: TextStyle(fontSize: Dimensions.FONT_SIZE_DEFAULT)),
        ),
      ]),
    );
  }
}

class TitleButton extends StatelessWidget {
  final String image;
  final String title;
  final Widget navigateTo;

  TitleButton(
      {@required this.image, @required this.title, @required this.navigateTo});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(
        image,
        width: 25,
        height: 25,
        fit: BoxFit.fill,
      ),
      title:
      Text(title, style: TextStyle(fontSize: Dimensions.FONT_SIZE_LARGE)),
      onTap: () =>
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => navigateTo),
          ),
    );
  }
}
