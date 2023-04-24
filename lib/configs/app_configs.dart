import 'package:flutter/material.dart';
import 'package:tasky/common/app_vectors.dart';
import 'package:tasky/generated/l10n.dart';
import 'package:tasky/ui/pages/home_screen/home_screen_page.dart';
import 'package:tasky/ui/pages/login/login_page.dart';
import 'package:tasky/ui/pages/signup/signup_page.dart';

class AppConfigs {
  AppConfigs._();

  static const String appName = "Tasky.";

  ///Paging
  static const pageSize = 40;
  static const pageSizeMax = 1000;

  ///Local
  static const appLocal = 'vi_VN';
  static const appLanguage = 'en';
  static const defaultLocal = Locale.fromSubtags(languageCode: appLanguage);

  ///DateFormat

  static const dateAPIFormat = 'dd/MM/yyyy';
  static const dateDisplayFormat = 'dd/MM/yyyy';

  static const dateTimeAPIFormat =
      "MM/dd/yyyy'T'hh:mm:ss.SSSZ"; //Use DateTime.parse(date) instead of ...
  static const dateTimeDisplayFormat = 'dd/MM/yyyy HH:mm';

  ///Date range
  static final identityMinDate = DateTime(1900, 1, 1);
  static final identityMaxDate = DateTime.now();
  static final birthMinDate = DateTime(1900, 1, 1);
  static final birthMaxDate = DateTime.now();

  ///Font
  static const fontFamily = 'Poppins';

  ///Max file
  static const maxAttachFile = 5;

  static final authTabList = [
    Tab(text: S.current.log_in),
    Tab(text: S.current.sign_up)
  ];

  static const authTabBarViewList = [
    LoginPage(),
    SignupPage(),
  ];

  static final taskStatusTabList = [
    Tab(text: S.current.in_progress),
    Tab(text: S.current.complete),
  ];

  static final bottomNavigatorBarIconList = [
    AppVectors.icHome,
    AppVectors.icActivity,
    AppVectors.icUser,
  ];

  static final mainScreenPageList = [
    const HomeScreenPage(),
    Container(color: Colors.red),
    Container(color: Colors.blue),
  ];
}

class FirebaseConfig {
  //Todo
}

class DatabaseConfig {
  //Todo
  static const int version = 1;
}
