import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky/common/app_colors.dart';
import 'package:tasky/common/app_text_styles.dart';
import 'package:tasky/configs/app_configs.dart';

class HomeStatusTabBar extends StatelessWidget {
  final TabController tabController;

  const HomeStatusTabBar({Key? key, required this.tabController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: AppConfigs.listTaskStatusTab.length,
      child: TabBar(
        controller: tabController,
        tabs: AppConfigs.listTaskStatusTab
            .map(
              (child) => Padding(
                padding: const EdgeInsets.only(right: 16).r,
                child: child,
              ),
            )
            .toList(),
        indicatorColor: AppColors.primary,
        indicatorWeight: 3,
        indicatorPadding: const EdgeInsets.only(right: 28).r,
        labelStyle: AppTextStyle.blackS15W500,
        labelColor: AppColors.textBlack,
        unselectedLabelStyle: AppTextStyle.blackO50S15W500,
        unselectedLabelColor: AppColors.textBlack.withOpacity(0.5),
        labelPadding: EdgeInsets.zero,
        isScrollable: true,
      ),
    );
  }
}
