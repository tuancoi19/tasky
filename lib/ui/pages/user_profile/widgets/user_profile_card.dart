import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasky/common/app_images.dart';
import 'package:tasky/common/app_text_styles.dart';
import 'package:tasky/common/app_vectors.dart';
import 'package:tasky/ui/widgets/app_vip_badge.dart';

class UserProfileCard extends StatelessWidget {
  final String displayName;
  final bool isVip;
  final String? avatar;
  final Function() onTap;

  const UserProfileCard({
    Key? key,
    required this.displayName,
    required this.isVip,
    this.avatar,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 24).r,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 84.h,
              height: 84.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9).r,
              ),
              child: Image.asset(
                avatar ?? AppImages.avatarTest,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 24.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    displayName,
                    style: AppTextStyle.blackS17W600,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (isVip) const AppVipBadge(),
                ],
              ),
            ),
            SizedBox(width: 28.w),
            SvgPicture.asset(
              AppVectors.icEnter,
              width: 20.w,
              height: 20.h,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }
}
