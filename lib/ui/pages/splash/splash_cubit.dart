import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:tasky/blocs/app_cubit.dart';
import 'package:tasky/database/share_preferences_helper.dart';
import 'package:tasky/router/route_config.dart';

import 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final AppCubit appCubit;

  SplashCubit({required this.appCubit}) : super(const SplashState());

  void checkLogin() async {
    appCubit.authStateChanges.listen((User? user) async {
      String route;
      if (user == null) {
        bool isSeenIntro = await SharedPreferencesHelper.isSeenIntro();
        route = isSeenIntro ? RouteConfig.authentication : RouteConfig.welcome;
        SharedPreferencesHelper.setSeenIntro(isSeen: true);
      } else {
        route = RouteConfig.homeScreen;
      }
      Get.offAllNamed(route);
    });
  }
}
