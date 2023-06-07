import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tasky/common/app_text_styles.dart';
import 'package:tasky/common/app_vectors.dart';
import 'package:tasky/models/entities/task/task_entity.dart';
import 'package:tasky/router/route_config.dart';
import 'package:tasky/ui/pages/task_screen/task_screen_page.dart';

class TodayTasksListView extends StatelessWidget {
  final List<TaskEntity> taskList;
  final Function() onDone;

  const TodayTasksListView({
    Key? key,
    required this.taskList,
    required this.onDone,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return buildTodayTaskItem(
          index: index % 3,
          data: taskList[index],
          onTap: () async {
            final needReload = await Get.toNamed(
              RouteConfig.taskScreen,
              arguments: TaskScreenArguments(
                task: taskList[index],
              ),
            );
            if (needReload ?? false) {
              onDone.call();
            }
          },
        );
      },
      physics: const BouncingScrollPhysics(),
      itemCount: taskList.length,
    );
  }

  Widget buildTodayTaskItem({
    required final TaskEntity data,
    required final Function() onTap,
    required int index,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 76.h,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 4).r,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        data.start ?? '',
                        style: AppTextStyle.blackS15W500,
                      ),
                      Text(
                        data.end ?? '',
                        style: AppTextStyle.blackO50S13W400,
                      ),
                    ],
                  ),
                  SizedBox(width: 24.w),
                  Container(
                    height: 36.h,
                    width: 4.w,
                    decoration: BoxDecoration(
                      color: Color(data.category?.color ?? 0).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(15).r,
                    ),
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Container(
                          width: 4.w,
                          margin: const EdgeInsets.only(bottom: 12).r,
                          decoration: BoxDecoration(
                            color: Color(data.category?.color ?? 0),
                            borderRadius: BorderRadius.circular(10).r,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 24.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          data.title ?? '',
                          style: AppTextStyle.blackS15W500,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        Text(
                          data.category?.title ?? '',
                          style: AppTextStyle.blackO50S13W400,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 24.w),
            SvgPicture.asset(
              AppVectors.icEnter,
              width: 20.h,
              height: 20.h,
            )
          ],
        ),
      ),
    );
  }
}
