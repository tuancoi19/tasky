import 'package:flutter/material.dart';
import 'package:tasky/common/app_vectors.dart';
import 'package:tasky/generated/l10n.dart';
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

  static const timeDisplayFormat = 'HH:mm';

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

  static const List<String> listImageFileType = ['PNG', 'JPEG', 'JPG'];

  static const List<String> listTextFileType = [
    'DOC',
    'XLS',
    'DOCX',
    'XLSX',
    'PDF'
  ];

  static final authTabList = [
    Tab(text: S.current.log_in),
    Tab(text: S.current.sign_up)
  ];

  static const authTabBarViewList = [
    LoginPage(),
    SignupPage(),
  ];

  static final taskDetailTabList = [
    Tab(text: S.current.description),
    Tab(text: S.current.documents),
  ];

  static final bottomNavigatorBarIconList = [
    AppVectors.icHome,
    AppVectors.icCalendar,
    AppVectors.icUser,
  ];

  ///Image
  static const int imageSize = 10;
}

class FirebaseConfig {
  //Todo
}

class DatabaseConfig {
  //Todo
  static const int version = 1;
}
