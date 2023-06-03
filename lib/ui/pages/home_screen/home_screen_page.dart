import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:tasky/blocs/app_cubit.dart';
import 'package:tasky/common/app_colors.dart';
import 'package:tasky/router/route_config.dart';
import 'package:tasky/ui/commons/app_dialog.dart';
import 'package:tasky/ui/pages/category/category_page.dart';
import 'package:tasky/ui/pages/home_screen/widgets/category_title.dart';
import 'package:tasky/ui/pages/home_screen/widgets/hello_text.dart';
import 'package:tasky/ui/pages/home_screen/widgets/home_app_bar.dart';
import 'package:tasky/ui/pages/home_screen/widgets/category_list_view.dart';
import 'package:tasky/ui/pages/home_screen/widgets/today_tasks_list_view.dart';
import 'package:tasky/ui/pages/home_screen/widgets/home_screen_drawer.dart';
import 'package:tasky/ui/pages/home_screen/widgets/today_tasks_title.dart';

import 'home_screen_cubit.dart';

// class HomeScreenArguments {
//   HomeScreenArguments();
// }

class HomeScreenPage extends StatelessWidget {
  // final HomeScreenArguments arguments;

  const HomeScreenPage({
    Key? key,
    // required this.arguments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final AppCubit appCubit = BlocProvider.of(context);
        return HomeScreenCubit(appCubit);
      },
      child: const HomeScreenChildPage(),
    );
  }
}

class HomeScreenChildPage extends StatefulWidget {
  const HomeScreenChildPage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreenChildPage> createState() => _HomeScreenChildPageState();
}

class _HomeScreenChildPageState extends State<HomeScreenChildPage> {
  late final HomeScreenCubit _cubit;
  late final ZoomDrawerController _zoomDrawerController;
  late final AppCubit _appCubit;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
    _appCubit = BlocProvider.of(context);
    _cubit.loadInitialData();
    _zoomDrawerController = ZoomDrawerController();
  }

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      controller: _zoomDrawerController,
      moveMenuScreen: true,
      disableDragGesture: true,
      borderRadius: 20.r,
      menuBackgroundColor: AppColors.drawerBackgroundColor,
      slideWidth: 256.w,
      menuScreenWidth: MediaQuery.of(context).size.width * 0.67,
      showShadow: true,
      angle: 0.0,
      shadowLayer2Color: Colors.transparent,
      mainScreenScale: 0.15,
      menuScreen: HomeScreenDrawer(
        onTap: () {
          _zoomDrawerController.close?.call();
        },
        logout: () {
          _appCubit.signOut();
        },
      ),
      mainScreen: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: HomeAppBar(
          onTap: () {
            _zoomDrawerController.open?.call();
          },
        ),
        body: SafeArea(
          bottom: false,
          child: _buildBodyWidget(),
        ),
      ),
    );
  }

  Widget _buildBodyWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12).r,
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<AppCubit, AppState>(
              buildWhen: (previous, current) => previous.user != current.user,
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24).r,
                  child: HelloText(title: state.user?.userName ?? ''),
                );
              },
            ),
            SizedBox(height: 24.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24).r,
              child: CategoryTitle(
                onTap: () {
                  AppDialog.showCustomDialog(
                    content: CategoryPage(
                      arguments: CategoryArguments(),
                    ),
                  );
                },
              ),
            ),
            BlocBuilder<HomeScreenCubit, HomeScreenState>(
              buildWhen: (previous, current) =>
                  previous.loadCategoriesListStatus !=
                      current.loadCategoriesListStatus ||
                  previous.categoriesList != current.categoriesList,
              builder: (context, state) {
                return const CategoryListView();
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24).r,
              child: TodayTasksTitle(
                onTap: () {
                  Get.toNamed(RouteConfig.addTaskScreen);
                },
              ),
            ),
            SizedBox(height: 12.h),
            BlocBuilder<HomeScreenCubit, HomeScreenState>(
              buildWhen: (previous, current) =>
                  previous.loadTasksListStatus != current.loadTasksListStatus ||
                  previous.tasksList != current.tasksList,
              builder: (context, state) {
                return Expanded(
                  child: TodayTasksListView(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }
}
