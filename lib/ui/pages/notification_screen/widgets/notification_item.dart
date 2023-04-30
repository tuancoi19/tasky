import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasky/common/app_images.dart';
import 'package:tasky/common/app_text_styles.dart';
import 'package:tasky/common/app_vectors.dart';
import 'package:tasky/generated/l10n.dart';

class NotificationItem extends StatelessWidget {
  final String title;
  final bool isCompleted;
  final Function() onTap;

  const NotificationItem({
    Key? key,
    required this.title,
    required this.isCompleted,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap.call(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 16).r,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  isCompleted ? AppImages.icCompleted : AppImages.icFailed,
                  width: 24.w,
                  height: 24.h,
                  fit: BoxFit.cover,
                ),
                SizedBox(width: 32.w),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: AppTextStyle.blackS15W500,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      isCompleted ? S.current.completed : S.current.failed,
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
