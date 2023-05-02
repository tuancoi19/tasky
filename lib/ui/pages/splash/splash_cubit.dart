import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:tasky/router/route_config.dart';
import 'package:tasky/ui/pages/edit_user_profile/edit_user_profile_page.dart';

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
    Get.offNamed(
      RouteConfig.editUserProfile,
      arguments: EditUserProfileArguments(fromSignUp: false),
    );
    //   final token = await authRepo.getToken();
    //   if (token == null) {
    //     // Get.offAll(() => const SignInPage());
    //   } else {
    //     try {
    //       //Profile
    //       await userRepo.getProfile();
    //       //Todo
    //       // authService.updateUser(myProfile);
    //     } catch (error, s) {
    //       logger.log(error, stackTrace: s);
    //       //Check 401
    //       if (error is DioError) {
    //         if (error.response?.statusCode == 401) {
    //           //Todo
    //           // authService.signOut();
    //           checkLogin();
    //           return;
    //         }
    //       }
    //       AppDialog.defaultDialog(
    //         message: "An error happened. Please check your connection!",
    //         textConfirm: "Retry",
    //         onConfirm: () {
    //           checkLogin();
    //         },
    //       );
    //       return;
    //     }
    //     Get.offAll(() => const MainPage());
    //   }
  }
}
