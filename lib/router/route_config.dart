import 'package:get/get.dart';
import 'package:tasky/ui/pages/authentication/authentication_page.dart';
import 'package:tasky/ui/pages/edit_user_profile/edit_user_profile_page.dart';
import 'package:tasky/ui/pages/onboarding/onboarding_page.dart';
import 'package:tasky/ui/pages/splash/splash_page.dart';
import 'package:tasky/ui/pages/welcome/welcome_page.dart';

class RouteConfig {
  RouteConfig._();

  ///main page
  static const String splash = '/splash';
  static const String welcome = '/welcome';
  static const String onboarding = '/onboarding';
  static const String authentication = '/authentication';
  static const String editUserProfile = '/edit_user_profile';

  ///Alias ​​mapping page
  static final List<GetPage> getPages = [
    GetPage(
      name: splash,
      page: () => const SplashPage(),
    ),
    GetPage(
      name: welcome,
      page: () => const WelcomePage(),
    ),
    GetPage(
      name: onboarding,
      page: () => const OnboardingPage(),
    ),
    GetPage(
      name: authentication,
      page: () => AuthenticationPage(),
    ),
    GetPage(
      name: editUserProfile,
      page: () => EditUserProfilePage(
        arguments: Get.arguments,
      ),
    )
  ];
}
