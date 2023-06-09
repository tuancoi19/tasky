import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tasky/common/app_colors.dart';
import 'package:tasky/common/app_vectors.dart';

class AppBarWithBackIconWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final bool fromSignUp;
  final Function()? onTap;
  final String? icon;

  const AppBarWithBackIconWidget({
    super.key,
    this.fromSignUp = false,
    this.onTap,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (!fromSignUp)
              InkWell(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  width: 48.h,
                  height: 48.h,
                  margin: const EdgeInsets.only(left: 24).r,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10).r,
                    color: AppColors.backgroundBackButtonColor,
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      AppVectors.icArrowLeft,
                      width: 20.w,
                      height: 16.h,
                    ),
                  ),
                ),
              ),
            InkWell(
              onTap: onTap,
              child: Container(
                width: 48.h,
                height: 48.h,
                margin: const EdgeInsets.only(right: 24).r,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10).r,
                  color: AppColors.backgroundBackButtonColor,
                ),
                child: Center(
                  child: SvgPicture.asset(
                    icon ?? '',
                    width: 24.h,
                    height: 24.h,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(80.h);
}
