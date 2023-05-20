import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasky/common/app_text_styles.dart';
import 'package:tasky/common/app_vectors.dart';
import 'package:tasky/configs/app_configs.dart';
import 'package:tasky/generated/l10n.dart';
import 'package:tasky/ui/pages/task_screen/detail_task_screen/widgets/detail_task_description.dart';
import 'package:tasky/ui/pages/task_screen/detail_task_screen/widgets/detail_task_documents_list_view.dart';
import 'package:tasky/ui/pages/task_screen/detail_task_screen/widgets/detail_task_tab_bar.dart';
import 'package:tasky/ui/widgets/app_schedule.dart';
import 'package:tasky/ui/widgets/app_task_page.dart';

import 'detail_task_screen_cubit.dart';

// class DetailTaskScreenArguments {
//   String param;
//
//   DetailTaskScreenArguments({
//     required this.param,
//   });
// }

class DetailTaskScreenPage extends StatelessWidget {
  // final DetailTaskScreenArguments arguments;

  const DetailTaskScreenPage({
    Key? key,
    // required this.arguments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return DetailTaskScreenCubit();
      },
      child: const DetailTaskScreenChildPage(),
    );
  }
}

class DetailTaskScreenChildPage extends StatefulWidget {
  const DetailTaskScreenChildPage({Key? key}) : super(key: key);

  @override
  State<DetailTaskScreenChildPage> createState() =>
      _DetailTaskScreenChildPageState();
}

class _DetailTaskScreenChildPageState extends State<DetailTaskScreenChildPage>
    with TickerProviderStateMixin {
  late final DetailTaskScreenCubit _cubit;
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
    _tabController =
        TabController(length: AppConfigs.taskDetailTabList.length, vsync: this);
    _cubit.loadInitialData();
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
    return AppTaskPage(
      headerWidget: buildFormDetailTaskHeader(),
      bodyWidget: buildFormDetailTaskBody(),
      bodyHeight: 536.h,
    );
  }

  Widget buildFormDetailTaskHeader() {
    return Container(
      padding: const EdgeInsets.all(28).r,
      width: double.infinity,
      height: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {},
                child: SvgPicture.asset(
                  AppVectors.icArrowLeft,
                  width: 20.w,
                  height: 16.h,
                  colorFilter: const ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: SvgPicture.asset(
                  AppVectors.icPlus,
                  width: 20.h,
                  height: 20.h,
                  colorFilter: const ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 32.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  'Loren Ipsum',
                  style: AppTextStyle.whiteS23W500,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                '11 Dec, 2020',
                style: AppTextStyle.whiteO60S14W500,
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Text(
            '3 ${S.current.tasks}',
            style: AppTextStyle.whiteO60S14W500,
          )
        ],
      ),
    );
  }

  Widget buildFormDetailTaskBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSchedule(height: 252.h),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24).r,
          child: DetailTaskTabBar(
            tabController: _tabController,
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: const [
              DetailTaskDescription(
                content:
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
              ),
              DetailTaskDocumentsListView(),
            ],
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }
}
