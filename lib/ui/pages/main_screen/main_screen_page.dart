import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:tasky/common/app_colors.dart';
import 'package:tasky/ui/pages/home_screen/home_screen_page.dart';
import 'package:tasky/ui/pages/main_screen/widgets/main_screen_drawer.dart';
import 'package:tasky/ui/pages/main_screen/widgets/main_screen_bottom_navigator_bar.dart';
import 'package:tasky/ui/pages/task_screen/detail_task_screen/detail_task_screen_page.dart';
import 'package:tasky/ui/pages/user_profile/user_profile_page.dart';

import 'main_screen_cubit.dart';

// class MainScreenArguments {
//   String param;
//
//   MainScreenArguments({
//     required this.param,
//   });
// }

class MainScreenPage extends StatelessWidget {
  // final MainScreenArguments arguments;

  const MainScreenPage({
    Key? key,
    // required this.arguments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return MainScreenCubit();
      },
      child: const MainScreenChildPage(),
    );
  }
}

class MainScreenChildPage extends StatefulWidget {
  const MainScreenChildPage({Key? key}) : super(key: key);

  @override
  State<MainScreenChildPage> createState() => _MainScreenChildPageState();
}

class _MainScreenChildPageState extends State<MainScreenChildPage> {
  late final MainScreenCubit _cubit;
  late final PageController _pageController;
  late final ZoomDrawerController _zoomDrawerController;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
    _cubit.loadInitialData();
    _pageController = PageController();
    _zoomDrawerController = ZoomDrawerController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainScreenCubit, MainScreenState>(
      builder: (context, state) {
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
          menuScreen: MainScreenDrawer(
            onTap: () {
              _zoomDrawerController.close?.call();
            },
          ),
          mainScreen: Scaffold(
            body: _buildBodyWidget(),
            bottomNavigationBar: MainScreenBottomNavigatorBar(
              currentIndex: state.currentPage,
              onPageChange: (page) {
                _cubit.setCurrentPage(page);
                _pageController.animateToPage(
                  page,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildBodyWidget() {
    return PageView(
      controller: _pageController,
      onPageChanged: (index) {
        _cubit.setCurrentPage(index);
      },
      children: buildMainScreenPageList(),
    );
  }

  List<Widget> buildMainScreenPageList() {
    return [
      HomeScreenPage(
        arguments: HomeScreenArguments(
          zoomDrawerController: _zoomDrawerController,
        ),
      ),
      Container(color: Colors.red),
      const UserProfilePage(),
      const DetailTaskScreenPage(),
    ];
  }

  @override
  void dispose() {
    _pageController.dispose();
    _cubit.close();
    super.dispose();
  }
}
