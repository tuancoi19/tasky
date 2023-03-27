import 'package:get/get.dart';
import 'package:tasky/ui/pages/splash/splash_page.dart';


class RouteConfig {
  RouteConfig._();

  ///main page
  static const String splash = "/splash";
  static const String main = "/main";

  ///Alias ​​mapping page
  static final List<GetPage> getPages = [
    GetPage(name: splash, page: () => const SplashPage()),
  ];
}
