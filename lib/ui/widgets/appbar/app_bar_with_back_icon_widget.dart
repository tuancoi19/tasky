import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tasky/common/app_colors.dart';
import 'package:tasky/common/app_vectors.dart';

class AppBarWithBackIconWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final Function()? onTap;

  const AppBarWithBackIconWidget({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          InkWell(
            onTap: onTap ??
                () {
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
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(80.h);
}
