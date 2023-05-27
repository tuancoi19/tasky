import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky/common/app_colors.dart';
import 'package:tasky/common/app_text_styles.dart';
import 'package:tasky/ui/commons/app_date_time_picker.dart';

class AppTimePicker extends StatelessWidget {
  final String title;
  final Function(TimeOfDay) onChange;
  final Color? borderColor;
  final String? calendarTitle;
  final TimeOfDay? hintTime;

  const AppTimePicker({
    Key? key,
    required this.title,
    required this.onChange,
    this.borderColor,
    this.calendarTitle,
    this.hintTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyle.blackS15W500,
        ),
        SizedBox(height: 20.h),
        SizedBox(
          height: 56.h,
          child: TextField(
            readOnly: true,
            onTap: () async {
              final result = await AppDateTimePicker.selectTime(
                context,
                initialDate: hintTime,
                themeColor: borderColor,
                titleText: calendarTitle ?? '',
              );
              if (result != null) {
                onChange(result);
              }
            },
            textAlign: TextAlign.center,
            style: AppTextStyle.blackO40S14W400,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 16).r,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10).r,
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10).r,
                borderSide: BorderSide(
                  color: borderColor ?? AppColors.primary,
                ),
              ),
              disabledBorder: InputBorder.none,
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10).r,
                borderSide: const BorderSide(
                  color: AppColors.textFieldErrorBorder,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10).r,
                borderSide: const BorderSide(
                  color: AppColors.textFieldErrorBorder,
                ),
              ),
              fillColor: AppColors.backgroundBackButtonColor,
              hintStyle: AppTextStyle.blackO40S14W400,
              hintText: AppDateTimePicker.convertTimeOfDayToString(
                      hintTime ?? TimeOfDay.now())
                  .toString(),
              isDense: true,
              filled: true,
            ),
          ),
        ),
      ],
    );
  }
}
