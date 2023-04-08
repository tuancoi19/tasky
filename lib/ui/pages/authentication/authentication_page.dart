import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky/common/app_colors.dart';
import 'package:tasky/common/app_text_styles.dart';
import 'package:tasky/configs/app_configs.dart';
import 'package:tasky/generated/l10n.dart';
import 'package:tasky/ui/pages/login/login_page.dart';
import 'package:tasky/ui/pages/signup/signup_page.dart';

class AuthenticationPage extends StatelessWidget {
  final List<Tab> listTab = [
    Tab(text: S.current.log_in),
    Tab(text: S.current.sign_up)
  ];
  static const List<Widget> listTabBarView = [
    LoginPage(),
    SignupPage(),
  ];

  AuthenticationPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: buildAppBar(context),
        body: SafeArea(
          child: _buildBodyWidget(),
        ),
      ),
    );
  }

  Widget _buildBodyWidget() {
    return const TabBarView(
      children: listTabBarView,
    );
  }

  PreferredSizeWidget buildAppBar(BuildContext context) {
    return AppBar(
      toolbarHeight: 188.h,
      flexibleSpace: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            AppConfigs.appName,
            style: AppTextStyle.primaryS26Bold,
          ),
        ],
      ),
      elevation: 0,
      bottom: TabBar(
        tabs: listTab,
        indicatorColor: AppColors.primary,
        indicatorWeight: 3.h,
        labelStyle: AppTextStyle.blackS20Bold,
        labelColor: AppColors.textBlack,
        unselectedLabelStyle: AppTextStyle.blackO50S20W600,
        unselectedLabelColor: AppColors.textBlack.withOpacity(0.5),
      ),
    );
  }
}
