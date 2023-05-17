import 'package:get/get.dart';
import 'package:tasky/ui/pages/authentication/authentication_page.dart';
import 'package:tasky/ui/pages/dashboard/dashboard_page.dart';
import 'package:tasky/ui/pages/main_screen/main_screen_page.dart';
import 'package:tasky/ui/pages/onboarding/onboarding_page.dart';
import 'package:tasky/ui/pages/splash/splash_page.dart';
import 'package:tasky/ui/pages/task_screen/task_information/task_information_page.dart';
import 'package:tasky/ui/pages/welcome/welcome_page.dart';

class RouteConfig {
  RouteConfig._();

  ///main page
  static const String splash = '/splash';
  static const String welcome = '/welcome';
  static const String onboarding = '/onboarding';
  static const String authentication = '/authentication';
  static const String dashboard = '/dashboard';
  static const String mainScreen = '/main_screen';
  static const String taskInformation = '/task_information';

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
      page: () => const AuthenticationPage(),
    ),
    GetPage(
      name: mainScreen,
      page: () => const MainScreenPage(),
    ),
    GetPage(
      name: dashboard,
      page: () => const DashboardPage(),
    ),
    GetPage(
      name: taskInformation,
      page: () => const TaskInformationPage(),
    ),
  ];
}
