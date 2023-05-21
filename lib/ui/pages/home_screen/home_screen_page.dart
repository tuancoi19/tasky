import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:tasky/blocs/app_cubit.dart';
import 'package:tasky/common/app_colors.dart';
import 'package:tasky/common/app_text_styles.dart';
import 'package:tasky/generated/l10n.dart';
import 'package:tasky/ui/pages/home_screen/widgets/hello_text.dart';
import 'package:tasky/ui/pages/home_screen/widgets/home_app_bar.dart';
import 'package:tasky/ui/pages/home_screen/widgets/category_list_view.dart';
import 'package:tasky/ui/pages/home_screen/widgets/today_tasks_list_view.dart';
import 'package:tasky/ui/pages/home_screen/widgets/home_screen_drawer.dart';

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
        return HomeScreenCubit();
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
        appBar: HomeAppBar(
          onTap: () {
            _zoomDrawerController.open?.call();
          },
        ),
        body: SafeArea(
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24).r,
              child: const HelloText(),
            ),
            SizedBox(height: 24.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24).r,
              child: Text(
                S.current.categories,
                style: AppTextStyle.blackS15W500,
              ),
            ),
            const CategoryListView(),
            Container(
              width: 100.w,
              padding: const EdgeInsets.only(left: 24).r,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    S.current.today_tasks,
                    style: AppTextStyle.blackS15W500,
                  ),
                  SizedBox(height: 12.h),
                  Divider(
                    color: AppColors.primary,
                    thickness: 3,
                    height: 0,
                    endIndent: 28.w,
                  ),
                ],
              ),
            ),
            const Expanded(
              child: TodayTasksListView(),
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
