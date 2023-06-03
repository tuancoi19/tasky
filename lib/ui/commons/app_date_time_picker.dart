import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tasky/common/app_colors.dart';
import 'package:tasky/configs/app_configs.dart';
import 'package:tasky/generated/l10n.dart';

class AppDateTimePicker {
  static Future<DateTime?> selectDate(
    BuildContext context, {
    DateTime? initialDate,
    Color? themeColor,
  }) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      locale: AppConfigs.defaultLocal,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      helpText: S.current.please_select_your_date,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
                  primary: themeColor ?? AppColors.primary,
                ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: themeColor ?? AppColors.primary,
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    return picked;
  }

  static Future<TimeOfDay?> selectTime(
    BuildContext context, {
    TimeOfDay? initialDate,
    required String titleText,
    Color? themeColor,
  }) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      helpText: titleText,
      initialTime: initialDate ?? TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
                  primary: themeColor ?? AppColors.primary,
                ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: themeColor ?? AppColors.primary,
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    return picked;
  }
}
