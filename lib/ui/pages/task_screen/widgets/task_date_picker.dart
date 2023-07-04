import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tasky/common/app_text_styles.dart';
import 'package:tasky/configs/app_configs.dart';
import 'package:tasky/ui/commons/app_date_time_picker.dart';

class TaskDatePicker extends StatelessWidget {
  final Function(DateTime) whenComplete;
  final DateTime? hintDate;
  final Color? themeColor;
  final bool readOnly;

  const TaskDatePicker({
    Key? key,
    required this.whenComplete,
    this.themeColor,
    this.hintDate,
    required this.readOnly,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: true,
      onTap: readOnly
          ? null
          : () async {
              final result = await AppDateTimePicker.selectDate(
                context,
                initialDate:
                    (hintDate ?? DateTime.now()).isBefore(DateTime.now())
                        ? DateTime.now()
                        : hintDate,
                themeColor: themeColor,
              );
              if (result != null) {
                whenComplete(result);
              }
            },
      textAlign: TextAlign.right,
      decoration: InputDecoration(
        hintText: DateFormat(AppConfigs.dateDisplayFormat)
            .format(hintDate ?? DateTime.now()),
        hintStyle: AppTextStyle.whiteO60S14W500,
        border: InputBorder.none,
      ),
    );
  }
}
