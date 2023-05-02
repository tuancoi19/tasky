import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasky/common/app_colors.dart';
import 'package:tasky/common/app_images.dart';
import 'package:tasky/common/app_vectors.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Function() onTap;

  const HomeAppBar({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16).r,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            buildIconButton(
                icon: SvgPicture.asset(
                  AppVectors.icMenu,
                  width: 24.h,
                  height: 24.h,
                ),
                onTap: onTap),
            buildAccountRow(),
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
          onTap: () {},
        ),
        SizedBox(width: 16.w),
        buildIconButton(
          icon: Image.asset(
            AppImages.avatarTest,
            width: 48.h,
            height: 48.h,
            fit: BoxFit.cover,
          ),
          onTap: () {},
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(80.h);
}
