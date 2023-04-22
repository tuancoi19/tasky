import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasky/common/app_colors.dart';
import 'package:tasky/common/app_images.dart';
import 'package:tasky/common/app_vectors.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 24).r,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            buildIconButton(
              icon: SvgPicture.asset(
                AppVectors.icMenu,
                width: 24.w,
                height: 24.h,
              ),
            ),
            buildAccountRow(),
          ],
        ),
      ),
    );
  }

  Widget buildIconButton({required Widget icon}) {
    return InkWell(
      onTap: () {},
      child: Container(
        width: 48.w,
        height: 48.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10).r,
          color: AppColors.backgroundBackButtonColor,
        ),
        child: Center(child: icon),
      ),
    );
  }

  Widget buildAccountRow() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        buildIconButton(
          icon: SvgPicture.asset(
            AppVectors.icNotification,
            width: 20.w,
            height: 24.h,
          ),
        ),
        SizedBox(width: 16.w),
        buildIconButton(
          icon: Image.asset(
            AppImages.avatarTest,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(48.h);
}
