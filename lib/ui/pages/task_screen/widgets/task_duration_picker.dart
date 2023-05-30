import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky/common/app_colors.dart';
import 'package:tasky/generated/l10n.dart';
import 'package:tasky/ui/widgets/app_time_picker.dart';

class TaskDurationPicker extends StatelessWidget {
  final Function(TimeOfDay) startTimeOnChange;
  final Function(TimeOfDay) endTimeOnChange;

  final Color? color;
  final TimeOfDay? hintStartTime;
  final TimeOfDay? hintEndTime;

  const TaskDurationPicker({
    Key? key,
    required this.startTimeOnChange,
    required this.endTimeOnChange,
    this.color,
    this.hintStartTime,
    this.hintEndTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: AppTimePicker(
            title: S.current.start_time,
            onChange: startTimeOnChange,
            borderColor: color,
            calendarTitle: S.current.please_select_your_start_time,
            hintTime: hintStartTime,
          ),
        ),
        SizedBox(width: 24.w),
        Expanded(
          child: Divider(
            color: color ?? AppColors.primary,
            thickness: 3,
            height: 56.h,
          ),
        ),
        SizedBox(width: 24.w),
        Expanded(
          child: AppTimePicker(
            title: S.current.end_time,
            onChange: endTimeOnChange,
            borderColor: color,
            calendarTitle: S.current.please_select_your_end_time,
            hintTime: hintEndTime,
          ),
        )
      ],
    );
  }
}
