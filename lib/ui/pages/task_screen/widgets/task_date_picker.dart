import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tasky/common/app_text_styles.dart';
import 'package:tasky/configs/app_configs.dart';
import 'package:tasky/ui/commons/app_date_time_picker.dart';

class TaskDatePicker extends StatelessWidget {
  final TextEditingController controller;
  final Function(DateTime) whenComplete;
  final DateTime? hintDate;
  final Color? themeColor;

  const TaskDatePicker({
    Key? key,
    required this.controller,
    required this.whenComplete,
    this.themeColor,
    this.hintDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      readOnly: true,
      onTap: () async {
        final result = await AppDateTimePicker.selectDate(
          context,
          initialDate: hintDate,
          themeColor: themeColor,
        );
        if (result != null) {
          whenComplete(result);
        }
      },
      decoration: InputDecoration(
        hintText: DateFormat(AppConfigs.dateDisplayFormat)
            .format(hintDate ?? DateTime.now()),
        hintStyle: AppTextStyle.whiteO60S14W500,
        border: InputBorder.none,
      ),
    );
  }
}
