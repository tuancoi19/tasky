import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky/common/app_text_styles.dart';
import 'package:tasky/configs/app_configs.dart';
import 'package:tasky/generated/l10n.dart';
import 'package:tasky/ui/pages/home_screen/widgets/hello_text.dart';
import 'package:tasky/ui/pages/home_screen/widgets/home_app_bar.dart';
import 'package:tasky/ui/pages/home_screen/widgets/home_list_view.dart';
import 'package:tasky/ui/pages/home_screen/widgets/home_search_bar.dart';
import 'package:tasky/ui/pages/home_screen/widgets/home_status_tab_bar.dart';

import 'home_screen_cubit.dart';

class HomeScreenPage extends StatelessWidget {
  const HomeScreenPage({
    Key? key,
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
  const HomeScreenChildPage({Key? key}) : super(key: key);

  @override
  State<HomeScreenChildPage> createState() => _HomeScreenChildPageState();
}

class _HomeScreenChildPageState extends State<HomeScreenChildPage>
    with TickerProviderStateMixin {
  late final HomeScreenCubit _cubit;
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
    _cubit.loadInitialData();
    _tabController = TabController(
      length: AppConfigs.taskStatusTabList.length,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBar(),
      body: SafeArea(
        child: _buildBodyWidget(),
      ),
    );
  }

  Widget _buildBodyWidget() {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      padding: const EdgeInsets.only(top: 12).r,
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
              child: const HomeSearchBar(),
            ),
            SizedBox(height: 24.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24).r,
              child: Text(
                S.current.my_tasks,
                style: AppTextStyle.blackS15W500,
              ),
            ),
            const HomeListView(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24).r,
              child: HomeStatusTabBar(
                tabController: _tabController,
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: AppConfigs.authTabBarViewList,
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
