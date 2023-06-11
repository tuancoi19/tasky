import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:tasky/common/app_colors.dart';
import 'package:tasky/common/app_vectors.dart';
import 'package:tasky/router/route_config.dart';
import 'package:tasky/ui/commons/app_bottom_sheet.dart';
import 'package:tasky/ui/pages/activity/widgets/calendar_view_options.dart';
import 'package:tasky/ui/widgets/buttons/home_add_button.dart';

class ActivityAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Function(CalendarView) onTap;
  final Function() onDone;
  final bool needReload;

  const ActivityAppBar({
    Key? key,
    required this.onTap,
    required this.onDone,
    required this.needReload,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16).r,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildIconButton(
              icon: SvgPicture.asset(
                AppVectors.icArrowLeft,
                width: 20.w,
                height: 16.h,
              ),
              onTap: () {
                Get.back(result: needReload);
              },
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                HomeAddButton(
                  onTap: () async {
                    final needReload =
                        await Get.toNamed(RouteConfig.taskScreen);
                    if (needReload ?? false) {
                      onDone.call();
                    }
                  },
                ),
                SizedBox(width: 16.w),
                buildIconButton(
                  icon: SvgPicture.asset(
                    AppVectors.icFilter,
                    width: 24.h,
                    height: 24.h,
                  ),
                  onTap: () {
                    AppBottomSheet.show(
                      bottomSheet: CalendarViewOptions(onChange: onTap),
                      isDismissible: true,
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildIconButton({
    required Widget icon,
    required Function() onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 48.h,
        height: 48.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10).r,
          color: AppColors.backgroundBackButtonColor,
        ),
        child: Center(child: icon),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(80.h);
}
