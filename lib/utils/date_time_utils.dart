import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tasky/configs/app_configs.dart';

class DateTimeUtils {
  static String convertTimeOfDayToString(TimeOfDay timeOfDay) {
    final DateTime date = DateTime.now().copyWith(
      hour: timeOfDay.hour,
      minute: timeOfDay.minute,
    );
    return DateFormat(AppConfigs.timeDisplayFormat).format(date);
  }

  static String convertDateTimeToString(DateTime dateTime) {
    return DateFormat(AppConfigs.dateDisplayFormat).format(dateTime);
  }

  static bool isOverlap({
    required String existingStartTime,
    required String existingEndTime,
    required String newStartTime,
    required String newEndTime,
  }) {
    if (newStartTime.compareTo(existingEndTime) >= 0 ||
        newEndTime.compareTo(existingStartTime) <= 0) {
      return false; // Không có sự chồng chéo giữa khoảng thời gian
    }
    return true; // Có sự chồng chéo giữa khoảng thời gian
  }
}
