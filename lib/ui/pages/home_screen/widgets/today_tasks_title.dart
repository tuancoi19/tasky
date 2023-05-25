import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky/common/app_colors.dart';
import 'package:tasky/common/app_text_styles.dart';
import 'package:tasky/generated/l10n.dart';
import 'package:tasky/ui/widgets/app_title_with_add_button.dart';

class TodayTasksTitle extends StatelessWidget {
  final Function() onTap;

  const TodayTasksTitle({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppTitleWithAddButton(
      onTap: onTap,
      titleWidget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            S.current.today_tasks,
            style: AppTextStyle.blackS15W500,
            maxLines: 1,
          ),
          SizedBox(height: 12.h),
          SizedBox(
            width: 60.w,
            child: const Divider(
              color: AppColors.primary,
              thickness: 3,
              height: 0,
            ),
          ),
        ],
      ),
    );
  }
}
