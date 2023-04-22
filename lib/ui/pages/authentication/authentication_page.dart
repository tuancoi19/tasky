import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky/common/app_colors.dart';
import 'package:tasky/common/app_text_styles.dart';
import 'package:tasky/configs/app_configs.dart';

class AuthenticationPage extends StatelessWidget {
  const AuthenticationPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: AppConfigs.listAuthTab.length,
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
      children: AppConfigs.listAuthTabBarView,
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
        tabs: AppConfigs.listAuthTab,
        indicatorColor: AppColors.primary,
        indicatorWeight: 3,
        labelStyle: AppTextStyle.blackS20Bold,
        labelColor: AppColors.textBlack,
        unselectedLabelStyle: AppTextStyle.blackO50S20W600,
        unselectedLabelColor: AppColors.textBlack.withOpacity(0.5),
      ),
    );
  }
}
