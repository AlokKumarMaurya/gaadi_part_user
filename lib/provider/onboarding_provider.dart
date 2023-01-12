import 'package:flutter/material.dart';

import '../data/repository/onboarding_repo.dart';


class OnBoardingProvider with ChangeNotifier {
  final OnBoardingRepo onboardingRepo;

  OnBoardingProvider({@required this.onboardingRepo});

  // List<OnboardingModel> _onBoardingList = [];
  // List<OnboardingModel> get onBoardingList => _onBoardingList;

  int _selectedIndex = 0;
  int get selectedIndex =>_selectedIndex;

  changeSelectIndex(int index){
    _selectedIndex=index;
    notifyListeners();
  }

  // void initBoardingList(BuildContext context) async {
  //   // ApiResponse apiResponse = await onboardingRepo.getOnBoardingList(context);
  //   if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
  //     // _onBoardingList.clear();
  //     _onBoa/rdingList.addAll(apiResponse.response.data);
  //   } else {
  //     ApiChecker.checkApi(context, apiResponse);
  //   }
  //   notifyListeners();
  // }
}
