import 'dart:ui';

class AppColors {
  AppColors._();

  ///Common
  static const Color primary = Color(0xFFF26950);
  static const Color secondary = Color(0xFFE5E5E5);

  ///Background
  static const Color backgroundLight = Color(0xFFFFFFFF);
  static const Color backgroundDark = Color(0xFF0F1B2B);

  ///Shadow
  static const Color shadow = Color(0x25606060);

  ///Border
  static const Color border = Color(0xFF606060);

  ///Divider
  static const Color divider = Color(0xFF606060);

  ///Text
  static const Color textWhite = Color(0xFFFFFFFF);
  static const Color textBlack = Color(0xFF303030);
  static const Color textBlue = Color(0xFF0000FF);
  static const Color textDisable = Color(0xFF89a3b1);
  static const Color textGray = Color(0xFF252729);

  ///TextField
  static const Color textFieldEnabledBorder = Color(0xFF919191);
  static const Color textFieldErrorBorder = Color(0xFFd74315);
  static const Color textFieldDisabledBorder = Color(0xFF919191);
  static const Color textFieldCursor = Color(0xFF919191);

  ///Button
  static const Color buttonBGWhite = Color(0xFFcdd0d5);
  static const Color buttonBGTint = secondary;
  static const Color buttonBorder = secondary;

  /// Tabs
  static const Color imageBG = Color(0xFF919191);

  ///BottomNavigationBar
  static const Color bottomNavigationBar = Color(0xFF919191);

  static const Color secondaryTextBlackColor = Color(0xFF212121);

  static final Color dotColor = secondaryTextBlackColor.withOpacity(0.2);

  static final Color titleColor = secondaryTextBlackColor.withOpacity(0.8);

  static const Color welcomeBackgroundColor = Color(0xFFC4C4C4);

  static const Color boxShadowColor = Color(0xFFC5C5C5);

  static const Color authBackgroundColor = Color(0xFFFAFAFA);

  static const Color backgroundTextFieldColor = Color(0xFFF9F9F9);

  static const Color backgroundBackButtonColor = Color(0xFFFBFBFB);

  static const List<Color> taskColorList = [
    Color(0xFF5486E9),
    Color(0xFFED918E),
    Color(0xFF3EAF99),
  ];

  static const Color drawerBackgroundColor = Color(0xFF0E1F53);
}
