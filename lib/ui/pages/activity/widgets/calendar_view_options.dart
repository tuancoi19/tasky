import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:tasky/common/app_colors.dart';
import 'package:tasky/common/app_text_styles.dart';
import 'package:tasky/generated/l10n.dart';
import 'package:tasky/ui/widgets/buttons/app_button.dart';

class CalendarViewOptions extends StatelessWidget {
  final Function(CalendarView) onChange;

  const CalendarViewOptions({
    Key? key,
    required this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: 32,
        vertical: 24,
      ).r,
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppButton(
              onPressed: () {
                Get.back();
                onChange.call(CalendarView.day);
              },
              title: S.current.day_view,
              textStyle: AppTextStyle.blackS18Bold,
              backgroundColor: AppColors.buttonBGWhite,
              cornerRadius: 8.r,
            ),
            SizedBox(height: 8.h),
            AppButton(
              onPressed: () {
                Get.back();
                onChange.call(CalendarView.week);
              },
              title: S.current.week_view,
              textStyle: AppTextStyle.blackS18Bold,
              backgroundColor: AppColors.buttonBGWhite,
              cornerRadius: 8.r,
            ),
            SizedBox(height: 8.h),
            AppButton(
              onPressed: () {
                Get.back();
                onChange.call(CalendarView.month);
              },
              title: S.current.month_view,
              textStyle: AppTextStyle.blackS18Bold,
              backgroundColor: AppColors.buttonBGWhite,
              cornerRadius: 8.r,
            ),
            SizedBox(height: 8.h),
            AppButton(
              onPressed: () {
                Get.back();
                onChange.call(CalendarView.schedule);
              },
              title: S.current.schedule,
              textStyle: AppTextStyle.blackS18Bold,
              backgroundColor: AppColors.buttonBGWhite,
              cornerRadius: 8.r,
            ),
            SizedBox(height: 8.h),
            AppButton(
              onPressed: () {
                Get.back();
                onChange.call(CalendarView.workWeek);
              },
              title: S.current.work_week,
              textStyle: AppTextStyle.blackS18Bold,
              backgroundColor: AppColors.buttonBGWhite,
              cornerRadius: 8.r,
            ),
            SizedBox(height: 8.h),
            AppButton(
              onPressed: () {
                Get.back();
                onChange.call(CalendarView.timelineDay);
              },
              title: S.current.timeline_day,
              textStyle: AppTextStyle.blackS18Bold,
              backgroundColor: AppColors.buttonBGWhite,
              cornerRadius: 8.r,
            ),
            SizedBox(height: 8.h),
            AppButton(
              onPressed: () {
                Get.back();
                onChange.call(CalendarView.timelineWeek);
              },
              title: S.current.timeline_week,
              textStyle: AppTextStyle.blackS18Bold,
              backgroundColor: AppColors.buttonBGWhite,
              cornerRadius: 8.r,
            ),
            SizedBox(height: 8.h),
            AppButton(
              onPressed: () {
                Get.back();
                onChange.call(CalendarView.timelineWorkWeek);
              },
              title: S.current.timeline_work_week,
              textStyle: AppTextStyle.blackS18Bold,
              backgroundColor: AppColors.buttonBGWhite,
              cornerRadius: 8.r,
            ),
            SizedBox(height: 8.h),
            AppButton(
              onPressed: () {
                Get.back();
                onChange.call(CalendarView.timelineMonth);
              },
              title: S.current.timeline_month,
              textStyle: AppTextStyle.blackS18Bold,
              backgroundColor: AppColors.buttonBGWhite,
              cornerRadius: 8.r,
            ),
          ],
        ),
      ),
    );
  }
}
