import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:tasky/database/share_preferences_helper.dart';
import 'package:tasky/models/entities/user/app_user.dart';
import 'package:tasky/router/route_config.dart';

import 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  // final AuthRepository authRepo;
  // final UserRepository userRepo;

  SplashCubit(
      /*{
     required this.authRepo,
     required this.userRepo,
  }*/
      )
      : super(const SplashState());

  void checkLogin() async {
    await Future.delayed(const Duration(seconds: 2));
    final sharedPreferencesHelper = SharedPreferencesHelper();
    bool isSeenIntro = await SharedPreferencesHelper.isSeenIntro();

    AppUser appUser = await sharedPreferencesHelper.loadAppUser();

    final routerName = (appUser.isUserLoggedIn)
        ? RouteConfig.dashboard
        : RouteConfig.authentication;
    Get.offAllNamed(
      isSeenIntro ? routerName : RouteConfig.welcome,
    );
  }
}
