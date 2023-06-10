import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:tasky/blocs/app_cubit.dart';
import 'package:tasky/database/share_preferences_helper.dart';
import 'package:tasky/models/entities/user/user_entity.dart';
import 'package:tasky/router/route_config.dart';

import 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final AppCubit appCubit;

  SplashCubit({required this.appCubit}) : super(const SplashState());

  void checkLogin() async {
    bool isLoggIn = await appCubit.isSignedIn();
    String route;

    if (isLoggIn) {
      UserEntity? user = await appCubit.getUser();
      if(user != null){
        route = RouteConfig.homeScreen;
      }else{
        bool isSeenIntro = await SharedPreferencesHelper.isSeenIntro();
        route = isSeenIntro ? RouteConfig.authentication : RouteConfig.welcome;
      }
    } else {
      bool isSeenIntro = await SharedPreferencesHelper.isSeenIntro();
      route = isSeenIntro ? RouteConfig.authentication : RouteConfig.welcome;
      SharedPreferencesHelper.setSeenIntro(isSeen: true);
    }
    Get.offAllNamed(route);
  }
}
