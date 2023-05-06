import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasky/common/app_colors.dart';
import 'package:tasky/common/app_text_styles.dart';
import 'package:tasky/common/app_vectors.dart';

class InProgressListView extends StatelessWidget {
  const InProgressListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return buildInProgressItem(
          title: 'Loren Ipsum',
          taskTitle: 'Loren Ipsum',
          onTap: () {},
        );
      },
      physics: const BouncingScrollPhysics(),
      itemCount: 5,
    );
  }

  Widget buildInProgressItem({
    required final String title,
    required final String taskTitle,
    required final Function() onTap,
  }) {
    return InkWell(
      onTap: onTap.call(),
      child: Container(
        height: 76.h,
        padding: const EdgeInsets.symmetric(horizontal: 44, vertical: 16).r,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 36.h,
                  width: 4.w,
                  decoration: BoxDecoration(
                    color: AppColors.taskColorList[1].withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15).r,
                  ),
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Container(
                        width: 4.w,
                        margin: const EdgeInsets.only(bottom: 12).r,
                        decoration: BoxDecoration(
                          color: AppColors.taskColorList[1],
                          borderRadius: BorderRadius.circular(10).r,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 24.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: AppTextStyle.blackS15W500,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      taskTitle,
                      style: AppTextStyle.blackO50S13W400,
                    ),
                  ],
                )
              ],
            ),
            InkWell(
              onTap: () {},
              child: SvgPicture.asset(
                AppVectors.icMoreHorizontal,
                width: 24.w,
                height: 24.h,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.45),
                  BlendMode.srcIn,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
