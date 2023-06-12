import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:tasky/common/app_colors.dart';
import 'package:tasky/common/app_text_styles.dart';
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
              title: 'Day View',
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
              title: 'Week View',
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
              title: 'Month View',
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
              title: 'Schedule',
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
              title: 'Work Week',
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
              title: 'Timeline Day',
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
              title: 'Timeline Week',
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
              title: 'Timeline Work Week',
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
              title: 'Timeline Month',
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
