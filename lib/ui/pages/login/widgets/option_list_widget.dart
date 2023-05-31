import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky/common/app_images.dart';

class OptionListWidget extends StatelessWidget {
  final VoidCallback? onPressedGoogle;
  final VoidCallback? onPressedUser;
  final VoidCallback? onPressedFacebook;

  const OptionListWidget({
    Key? key,
    this.onPressedGoogle,
    this.onPressedUser,
    this.onPressedFacebook,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildOptionItemButton(AppImages.icGoogle, onPressedGoogle ?? () {}),
        SizedBox(width: 32.w),
        buildOptionItemButton(AppImages.icUser, () {}),
        SizedBox(width: 32.w),
        buildOptionItemButton(AppImages.icFacebook, () {}),
      ],
    );
  }

  Widget buildOptionItemButton(String image, void Function() onTap) {
    return InkWell(
      onTap: onTap,
      child: Image.asset(
        image,
        width: 50.w,
        height: 50.h,
      ),
    );
  }
}
