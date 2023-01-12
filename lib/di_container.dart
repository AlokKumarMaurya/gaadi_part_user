import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:gaadi_part/provider/auth_provider.dart';
import 'package:gaadi_part/provider/onboarding_provider.dart';
import 'package:gaadi_part/utill/app_constants.dart';

import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/datasource/remote/dio/dio_client.dart';
import 'data/datasource/remote/dio/logging_interceptor.dart';
import 'data/repository/auth_repo.dart';


final sl = GetIt.instance;

Future<void> init() async {
  // Core

  sl.registerLazySingleton(() => DioClient(AppConstants.BASE_URL, sl(), loggingInterceptor: sl(), sharedPreferences: sl()));

  // Repository

  sl.registerLazySingleton(() => AuthRepo(dioClient: sl(), sharedPreferences: sl()));

  // Provider

  sl.registerFactory(() => OnBoardingProvider(onboardingRepo: sl()));
  sl.registerFactory(() => AuthProvider(authRepo: sl()));

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => LoggingInterceptor());
  sl.registerLazySingleton(() => Connectivity());
}
