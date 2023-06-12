import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tasky/common/app_text_styles.dart';
import 'package:tasky/generated/l10n.dart';
import 'package:tasky/global/global_data.dart';
import 'package:tasky/router/route_config.dart';
import 'package:tasky/ui/commons/app_snackbar.dart';
import 'package:tasky/ui/pages/search/widgets/search_app_bar.dart';
import 'package:tasky/ui/widgets/app_circular_progress_indicator.dart';
import 'package:tasky/ui/widgets/app_tasks_list_view.dart';
import 'package:tasky/ui/widgets/empty_list_widget.dart';

import 'search_cubit.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return SearchCubit();
      },
      child: const SearchChildPage(),
    );
  }
}

class SearchChildPage extends StatefulWidget {
  const SearchChildPage({Key? key}) : super(key: key);

  @override
  State<SearchChildPage> createState() => _SearchChildPageState();
}

class _SearchChildPageState extends State<SearchChildPage> {
  late final SearchCubit _cubit;
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
    controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchAppBar(
        controller: controller,
        onChanged: (value) {
          _cubit.searchByName(keyword: value);
        },
      ),
      body: SafeArea(
        child: _buildBodyWidget(),
      ),
    );
  }

  Widget _buildBodyWidget() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12).r,
      child: BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) {
          if (GlobalData.instance.tasksList.isEmpty) {
            return EmptyListWidget(
              onRefresh: () async {
                final needReload = await Get.toNamed(RouteConfig.taskScreen);
                if ((needReload ?? false)) {
                  Get.back(result: needReload, closeOverlays: true);
                  AppSnackbar.showSuccess(
                    title: S.current.task,
                    message: S.current.added_successfully,
                  );
                }
              },
            );
          } else {
            if (state.isLoading) {
              return const Center(
                child: AppCircularProgressIndicator(),
              );
            } else if ((state.taskList ?? []).isEmpty) {
              return Center(
                child: Text(
                  S.current.no_results,
                  style: AppTextStyle.blackS20W500,
                ),
              );
            } else {
              return AppTasksListView(
                taskList: state.taskList ?? [],
                onDone: () {
                  Get.back(result: true, closeOverlays: true);
                  AppSnackbar.showSuccess(
                    title: S.current.task,
                    message: S.current.success,
                  );
                },
              );
            }
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _cubit.close();
    controller.dispose();
    super.dispose();
  }
}
