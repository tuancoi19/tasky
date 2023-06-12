import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:tasky/models/enums/load_status.dart';
import 'package:tasky/router/route_config.dart';
import 'package:tasky/ui/pages/activity/widgets/activity_app_bar.dart';
import 'package:tasky/ui/pages/activity/widgets/activity_calendar_view.dart';
import 'package:tasky/ui/widgets/app_circular_progress_indicator.dart';
import 'package:tasky/ui/widgets/empty_view_widget.dart';
import 'package:tasky/ui/widgets/error_view_widget.dart';

import 'activity_cubit.dart';

class ActivityPage extends StatelessWidget {
  const ActivityPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return ActivityCubit();
      },
      child: const ActivityChildPage(),
    );
  }
}

class ActivityChildPage extends StatefulWidget {
  const ActivityChildPage({Key? key}) : super(key: key);

  @override
  State<ActivityChildPage> createState() => _ActivityChildPageState();
}

class _ActivityChildPageState extends State<ActivityChildPage> {
  late final ActivityCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
    _cubit.loadInitialData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ActivityCubit, ActivityState>(
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async {
            Get.back(result: state.needReload);
            return false;
          },
          child: Scaffold(
            appBar: ActivityAppBar(
              onTap: (value) {
                _cubit.changeType(type: value);
              },
              onDone: () async {
                _cubit.setNeedReload(needReload: true);
                await _cubit.getTasksList();
              },
              needReload: state.needReload,
            ),
            body: SafeArea(
              child: _buildBodyWidget(),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBodyWidget() {
    return BlocBuilder<ActivityCubit, ActivityState>(
      builder: (context, state) {
        if (state.loadDataStatus == LoadStatus.loading) {
          return const Center(
            child: AppCircularProgressIndicator(),
          );
        } else if (state.loadDataStatus == LoadStatus.failure) {
          return ErrorViewWidget(
            onRefresh: () async {
              await _cubit.getTasksList();
            },
          );
        } else if ({state.tasksData ?? []}.isEmpty) {
          return EmptyViewWidget(
            onRefresh: () async {
              final needReload = await Get.toNamed(RouteConfig.taskScreen);
              if (needReload ?? false) {
                _cubit.setNeedReload(needReload: needReload);
                await _cubit.getTasksList();
              }
            },
          );
        } else {
          return ActivityCalendarView(
            type: state.type,
            tasksData: state.tasksData ?? [],
            onDone: () async {
              _cubit.setNeedReload(needReload: true);
              await _cubit.getTasksList();
            },
          );
        }
      },
    );
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }
}
