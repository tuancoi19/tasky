import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:tasky/blocs/app_cubit.dart';
import 'package:tasky/database/share_preferences_helper.dart';
import 'package:tasky/models/entities/user/app_user.dart';
import 'package:tasky/router/route_config.dart';
import 'package:tasky/ui/pages/edit_user_profile/edit_user_profile_page.dart';

import 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final AppCubit appCubit;
  SplashCubit({required this.appCubit}) : super(const SplashState());

  void checkLogin() async {
    await Future.delayed(const Duration(seconds: 2));

    appCubit.authStateChanges.listen((User? user) async {
      if (user == null) {
        print('User is currently signed out!');
        bool isSeenIntro = await SharedPreferencesHelper.isSeenIntro();
        Get.offAllNamed(
            isSeenIntro ? RouteConfig.authentication : RouteConfig.welcome);
      } else {
        print('User is signed in!');
        Get.offAllNamed(
          RouteConfig.mainScreen,
        );
      }
    });
  }
}
