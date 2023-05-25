import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky/common/app_colors.dart';
import 'package:tasky/generated/l10n.dart';
import 'package:tasky/ui/widgets/app_time_picker.dart';

class TaskDurationPicker extends StatelessWidget {
  final Function(String?) startTimeOnChange;
  final Function(String?) endTimeOnChange;
  final TextEditingController startTimeController;
  final TextEditingController endTimeController;
  final Color? color;

  const TaskDurationPicker({
    Key? key,
    required this.startTimeOnChange,
    required this.endTimeOnChange,
    required this.startTimeController,
    required this.endTimeController,
    this.color,
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
            controller: startTimeController,
            borderColor: color,
            calendarTitle: S.current.please_select_your_start_time,
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
            controller: endTimeController,
            borderColor: color,
            calendarTitle: S.current.please_select_your_end_time,
          ),
        )
      ],
    );
  }
}
