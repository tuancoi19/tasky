import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tasky/common/app_text_styles.dart';
import 'package:tasky/generated/l10n.dart';
import 'package:tasky/models/entities/category/category_entity.dart';
import 'package:tasky/models/enums/load_status.dart';
import 'package:tasky/router/route_config.dart';
import 'package:tasky/ui/pages/category/category_detail/widgets/category_navigator_header.dart';
import 'package:tasky/ui/pages/task_screen/task_screen_page.dart';
import 'package:tasky/ui/widgets/app_circular_progress_indicator.dart';
import 'package:tasky/ui/widgets/app_detail_page.dart';
import 'package:tasky/ui/widgets/app_tasks_list_view.dart';
import 'package:tasky/ui/widgets/buttons/home_add_button.dart';
import 'package:tasky/ui/widgets/empty_view_widget.dart';
import 'package:tasky/ui/widgets/error_view_widget.dart';

import 'category_detail_cubit.dart';

class CategoryDetailArguments {
  final CategoryEntity category;
  final String background;

  CategoryDetailArguments({
    required this.category,
    required this.background,
  });
}

class CategoryDetailPage extends StatelessWidget {
  final CategoryDetailArguments arguments;

  const CategoryDetailPage({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return CategoryDetailCubit();
      },
      child: CategoryDetailChildPage(arguments: arguments),
    );
  }
}

class CategoryDetailChildPage extends StatefulWidget {
  final CategoryDetailArguments arguments;

  const CategoryDetailChildPage({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  @override
  State<CategoryDetailChildPage> createState() =>
      _CategoryDetailChildPageState();
}

class _CategoryDetailChildPageState extends State<CategoryDetailChildPage> {
  late final CategoryDetailCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
    _cubit.loadInitialData(widget.arguments.category);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _buildBodyWidget(),
      ),
    );
  }

  Widget _buildBodyWidget() {
    return BlocBuilder<CategoryDetailCubit, CategoryDetailState>(
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async {
            Get.back(result: state.needReload);
            return false;
          },
          child: AppDetailPage(
            headerWidget: buildFormAddTaskHeader(),
            bodyWidget: buildFormAddTaskBody(),
            headerColor: Color(state.category?.color ?? 0),
            backgroundHeader: widget.arguments.background,
          ),
        );
      },
    );
  }

  Widget buildFormAddTaskHeader() {
    return BlocBuilder<CategoryDetailCubit, CategoryDetailState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(28).r,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CategoryNavigatorHeader(
                onDelete: () async {
                  _cubit.setNeedReload(needReload: true);
                  await _cubit.deleteCategoryOnFirebase();
                },
                isLoading: false,
                category: state.category ?? CategoryEntity(),
                onEdit: (value) async {
                  _cubit.setNeedReload(needReload: true);
                  await _cubit.loadInitialData(value);
                },
                onBack: () {
                  Get.back(result: state.needReload);
                },
              ),
              SizedBox(height: 32.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      flex: 5,
                      child: Text(
                        state.category?.title ?? '',
                        style: AppTextStyle.whiteS23W500,
                      )),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          (state.category?.numberOfTasks ?? 0).toString(),
                          style: AppTextStyle.whiteS26Bold,
                        ),
                        SizedBox(height: 20.h),
                        Text(
                          S.current.tasks,
                          style: AppTextStyle.whiteO60S14W500,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildFormAddTaskBody() {
    return BlocBuilder<CategoryDetailCubit, CategoryDetailState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 32,
          ).r,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24).r,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      S.current.tasks,
                      style: AppTextStyle.blackS15W500,
                    ),
                    HomeAddButton(
                      onTap: () async {
                        final needReload = await Get.toNamed(
                          RouteConfig.taskScreen,
                          arguments:
                              TaskScreenArguments(category: state.category),
                        );
                        if (needReload ?? false) {
                          _cubit.setNeedReload(needReload: needReload);
                          await _cubit.getTaskList();
                        }
                      },
                      color: Color(state.category!.color!),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              Expanded(
                child: state.loadDataStatus == LoadStatus.loading
                    ? Center(
                        child: AppCircularProgressIndicator(
                          color: Color(state.category?.color ?? 0),
                        ),
                      )
                    : state.loadDataStatus == LoadStatus.failure
                        ? ErrorViewWidget(
                            theme: Color(state.category?.color ?? 0),
                            onRefresh: () async {
                              await _cubit.getTaskList();
                            },
                          )
                        : (state.taskList ?? []).isEmpty
                            ? EmptyViewWidget(
                                theme: Color(state.category?.color ?? 0),
                                onRefresh: () async {
                                  final needReload = await Get.toNamed(
                                    RouteConfig.taskScreen,
                                    arguments: TaskScreenArguments(
                                      category: state.category,
                                    ),
                                  );
                                  if (needReload ?? false) {
                                    _cubit.setNeedReload(
                                        needReload: needReload);
                                    await _cubit.getTaskList();
                                  }
                                },
                              )
                            : AppTasksListView(
                                taskList: state.taskList ?? [],
                                onDone: () async {
                                  _cubit.setNeedReload(needReload: true);
                                  await _cubit.getTaskList();
                                },
                                showDate: true,
                              ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }
}
