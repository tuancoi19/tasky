import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky/common/app_colors.dart';
import 'package:tasky/common/app_text_styles.dart';
import 'package:tasky/configs/app_configs.dart';
import 'package:tasky/models/enums/load_status.dart';
import 'package:tasky/ui/commons/content_laoding_indicator.dart';
import 'package:tasky/ui/pages/authentication/authentication_cubit.dart';

class AuthenticationPage extends StatelessWidget {
  const AuthenticationPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return AuthenticationCubit();
      },
      child: BlocBuilder<AuthenticationCubit, AuthenticationState>(
        builder: (context, state) {
          return Stack(
            children: [
              DefaultTabController(
                length: 2,
                child: Scaffold(
                  appBar: buildAppBar(context),
                  body: SafeArea(
                    bottom: false,
                    child: _buildBodyWidget(),
                  ),
                ),
              ),
              if (state.loadDataStatus == LoadStatus.loading)
                const LoadingIndicator(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildBodyWidget() {
    return const TabBarView(
      children: AppConfigs.authTabBarViewList,
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
        tabs: AppConfigs.authTabList,
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
