import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:tasky/blocs/app_cubit.dart';
import 'package:tasky/common/app_colors.dart';
import 'package:tasky/common/app_text_styles.dart';
import 'package:tasky/generated/l10n.dart';
import 'package:tasky/models/enums/load_status.dart';
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
import 'package:tasky/ui/widgets/app_circular_progress_indicator.dart';
import 'package:tasky/ui/widgets/empty_list_widget.dart';
import 'package:tasky/ui/widgets/error_list_widget.dart';

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
            BlocBuilder<HomeScreenCubit, HomeScreenState>(
              buildWhen: (previous, current) =>
                  previous.categoriesList != current.categoriesList,
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24).r,
                  child: (state.categoriesList ?? []).length < 6
                      ? CategoryTitle(
                          onTap: () async {
                            await AppDialog.showCustomDialog(
                              content: CategoryPage(
                                arguments: CategoryArguments(
                                  onDone: (value) async {
                                    await _cubit.getCategoriesList();
                                  },
                                ),
                              ),
                            );
                          },
                        )
                      : Text(
                          S.current.categories,
                          style: AppTextStyle.blackS15W500,
                        ),
                );
              },
            ),
            SizedBox(
              height: 236.h,
              child: BlocBuilder<HomeScreenCubit, HomeScreenState>(
                buildWhen: (previous, current) =>
                    previous.loadCategoriesListStatus !=
                        current.loadCategoriesListStatus ||
                    previous.categoriesList != current.categoriesList,
                builder: (context, state) {
                  if (state.loadCategoriesListStatus == LoadStatus.loading) {
                    // return ListView.separated(
                    //   itemBuilder: (context, index) => AppShimmer(
                    //     width: 152.w,
                    //     height: 192.h,
                    //     cornerRadius: 10.r,
                    //   ),
                    //   separatorBuilder: (context, index) =>
                    //       SizedBox(width: 16.w),
                    //   itemCount: 3,
                    //   padding:
                    //       const EdgeInsets.only(left: 24, top: 12, right: 24).r,
                    //   physics: const NeverScrollableScrollPhysics(),
                    //   scrollDirection: Axis.horizontal,
                    // );
                    return const Center(
                      child: AppCircularProgressIndicator(),
                    );
                  } else if (state.loadCategoriesListStatus ==
                      LoadStatus.failure) {
                    return ErrorListWidget(
                      height: 236.h,
                      onRefresh: () async {
                        await _cubit.getCategoriesList();
                      },
                    );
                  } else if ((state.categoriesList ?? []).isEmpty) {
                    return EmptyListWidget(
                      height: 236.h,
                      onRefresh: () async {
                        await AppDialog.showCustomDialog(
                          content: CategoryPage(
                            arguments: CategoryArguments(
                              onDone: (value) async {
                                await _cubit.getCategoriesList();
                              },
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return CategoryListView(
                      categoryList: state.categoriesList ?? [],
                    );
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24).r,
              child: TodayTasksTitle(
                onTap: () async {
                  final needReload =
                      await Get.toNamed(RouteConfig.taskScreen);
                  if (needReload ?? false) {
                    await _cubit.getTasksList();
                  }
                },
              ),
            ),
            SizedBox(height: 12.h),
            Expanded(
              child: BlocBuilder<HomeScreenCubit, HomeScreenState>(
                buildWhen: (previous, current) =>
                    previous.loadTasksListStatus !=
                        current.loadTasksListStatus ||
                    previous.tasksList != current.tasksList,
                builder: (context, state) {
                  if (state.loadTasksListStatus == LoadStatus.loading) {
                    return const Center(
                      child: AppCircularProgressIndicator(),
                    );
                  } else if (state.loadTasksListStatus == LoadStatus.failure) {
                    return ErrorListWidget(
                      onRefresh: () async {
                        await _cubit.getTasksList();
                      },
                    );
                  } else if ((state.tasksList ?? []).isEmpty) {
                    return EmptyListWidget(
                      onRefresh: () async {
                        final needReload =
                            await Get.toNamed(RouteConfig.taskScreen);
                        if (needReload ?? false) {
                          await _cubit.getTasksList();
                        }
                      },
                    );
                  } else {
                    return TodayTasksListView(
                      taskList: state.tasksList ?? [],
                    );
                  }
                },
              ),
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
