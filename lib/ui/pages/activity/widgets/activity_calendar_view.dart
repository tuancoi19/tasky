import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:tasky/common/app_colors.dart';
import 'package:tasky/common/app_text_styles.dart';
import 'package:tasky/configs/app_configs.dart';
import 'package:tasky/global/global_data.dart';
import 'package:tasky/models/entities/task/task_entity.dart';
import 'package:tasky/router/route_config.dart';
import 'package:tasky/ui/pages/task_screen/task_screen_page.dart';

class ActivityCalendarView extends StatelessWidget {
  final CalendarView type;
  final List<Appointment> tasksData;
  final Function() onDone;

  const ActivityCalendarView({
    Key? key,
    required this.type,
    required this.tasksData,
    required this.onDone,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SfCalendar(
      key: ValueKey(type),
      dataSource: TaskDataSource(tasksData),
      view: type,
      showNavigationArrow: true,
      appointmentTextStyle: AppTextStyle.whiteO80S14W500,
      appointmentTimeTextFormat: AppConfigs.timeDisplayFormat,
      scheduleViewSettings: ScheduleViewSettings(
        hideEmptyScheduleWeek: true,
        appointmentItemHeight: 56.h,
      ),
      monthViewSettings: const MonthViewSettings(showAgenda: true),
      timeSlotViewSettings: TimeSlotViewSettings(
        timeFormat: AppConfigs.timeDisplayFormat,
        timeIntervalHeight: 100.h,
        timeTextStyle: AppTextStyle.blackO60S14W500,
      ),
      todayHighlightColor: AppColors.primary,
      headerDateFormat: AppConfigs.dateDisplayFormat,
      showDatePickerButton: true,
      initialDisplayDate: DateTime.now(),
      showWeekNumber: true,
      onTap: (value) async {
        final TaskEntity data = GlobalData.instance.tasksList.firstWhere(
            (element) => element.id == value.appointments?.first.id);
        final needReload = await Get.toNamed(
          RouteConfig.taskScreen,
          arguments: TaskScreenArguments(task: data),
        );
        if (needReload ?? false) {
          onDone.call();
        }
      },
    );
  }
}

class TaskDataSource extends CalendarDataSource {
  TaskDataSource(List<Appointment> data) {
    appointments = data;
  }
}
