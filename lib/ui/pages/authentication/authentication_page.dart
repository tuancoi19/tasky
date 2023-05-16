import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky/common/app_colors.dart';
import 'package:tasky/common/app_text_styles.dart';
import 'package:tasky/configs/app_configs.dart';
import 'package:tasky/models/enums/load_status.dart';
import 'package:tasky/ui/commons/content_laoding_indicator.dart';
import 'package:tasky/ui/pages/authentication/authentication_cubit.dart';
import 'package:tasky/ui/pages/login/login_page.dart';
import 'package:tasky/ui/pages/signup/signup_page.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({
    Key? key,
  }) : super(key: key);

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  void dispose() {
    tabController.dispose();
    super.dispose();
  }

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
    return TabBarView(controller: tabController, children: [
      const LoginPage(),
      SignupPage(
        tabController: tabController,
      ),
    ]);
  }

  PreferredSizeWidget buildAppBar(BuildContext context) {
    return AppBar(
      toolbarHeight: 188.h,
      flexibleSpace: Center(
        child: Text(
          AppConfigs.appName,
          style: AppTextStyle.primaryS26Bold,
        ),
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
        controller: tabController,
      ),
    );
  }
}
