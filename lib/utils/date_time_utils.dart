import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tasky/configs/app_configs.dart';
import 'package:tasky/models/entities/task/task_entity.dart';

class DateTimeUtils {
  static String convertTimeOfDayToString(TimeOfDay timeOfDay) {
    final DateTime date = DateTime.now().copyWith(
      hour: timeOfDay.hour,
      minute: timeOfDay.minute,
    );
    return DateFormat(AppConfigs.timeDisplayFormat).format(date);
  }

  static String convertDateTimeToString(DateTime dateTime) {
    return DateFormat(AppConfigs.dateAPIFormat).format(dateTime);
  }

  static bool isOverlap({
    required List<TaskEntity> data,
    required String newStartTime,
    required String newEndTime,
  }) {
    if (data.isNotEmpty) {
      DateFormat format = DateFormat(AppConfigs.timeDisplayFormat);
      DateTime parsedNewStartTime = format.parse(newStartTime);
      DateTime parsedNewEndTime = format.parse(newEndTime);

      for (var range in data) {
        DateTime existingStartTime = format.parse(range.start ?? '');
        DateTime existingEndTime = format.parse(range.end ?? '');

        if (parsedNewStartTime.isBefore(existingEndTime) ||
            parsedNewEndTime.isBefore(existingStartTime)) {
          return true; //  // Có sự chồng chéo giữa khoảng thời gian
        }
      }
    }
    return false; // Có sự chồng chéo giữa khoảng thời gian
  }

  static bool isTimeOfDayValid(TimeOfDay selectedTime) {
    DateTime now = DateTime.now();
    DateTime selectedDateTime = DateTime(
        now.year, now.month, now.day, selectedTime.hour, selectedTime.minute);

    return selectedDateTime.isAfter(now);
  }

  static bool isSameDate(DateTime date) {
    DateTime now = DateTime.now();

    return date.day == now.day &&
        date.month == now.month &&
        date.year == now.year;
  }

  static bool isOlderDate(DateTime date) {
    DateTime now = DateTime.now();

    return date.day < now.day && date.month < now.month && date.year < now.year;
  }

  static bool checkTimeValidity(TimeOfDay startTime, TimeOfDay endTime) {
    DateTime now = DateTime.now();
    DateTime startDateTime = DateTime(
        now.year, now.month, now.day, startTime.hour, startTime.minute);
    DateTime endDateTime =
        DateTime(now.year, now.month, now.day, endTime.hour, endTime.minute);

    return endDateTime.difference(startDateTime).inMinutes < 5;
  }

  static TimeOfDay placeHolderTime(int minuteAhead) {
    final time = TimeOfDay.now();
    return TimeOfDay(
      hour: time.hour,
      minute: time.minute + minuteAhead,
    );
  }
}
