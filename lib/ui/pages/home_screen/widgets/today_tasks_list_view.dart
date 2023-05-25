import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasky/common/app_colors.dart';
import 'package:tasky/common/app_text_styles.dart';
import 'package:tasky/common/app_vectors.dart';

class TodayTasksListView extends StatelessWidget {
  const TodayTasksListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return buildInProgressItem(
          index: index % 3,
          title: 'Loren Ipsum',
          taskTitle: 'Loren Ipsum',
          onTap: () {},
        );
      },
      physics: const BouncingScrollPhysics(),
      itemCount: 10,
    );
  }

  Widget buildInProgressItem({
    required final String title,
    required final String taskTitle,
    required final Function() onTap,
    required int index,
  }) {
    return InkWell(
      onTap: onTap.call(),
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
                        '11:00',
                        style: AppTextStyle.blackS15W500,
                      ),
                      Text(
                        '12:00',
                        style: AppTextStyle.blackO50S13W400,
                      ),
                    ],
                  ),
                  SizedBox(width: 24.w),
                  Container(
                    height: 36.h,
                    width: 4.w,
                    decoration: BoxDecoration(
                      color: AppColors.taskColorList[index].withOpacity(0.1),
                      borderRadius: BorderRadius.circular(15).r,
                    ),
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Container(
                          width: 4.w,
                          margin: const EdgeInsets.only(bottom: 12).r,
                          decoration: BoxDecoration(
                            color: AppColors.taskColorList[index],
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
                          title,
                          style: AppTextStyle.blackS15W500,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        Text(
                          taskTitle,
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
