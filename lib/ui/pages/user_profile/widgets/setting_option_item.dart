import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasky/common/app_text_styles.dart';
import 'package:tasky/common/app_vectors.dart';

class SettingOptionItem extends StatelessWidget {
  final String title;
  final String leadingIcon;
  final Color leadingColor;
  final Color leadingBackgroundColor;
  final Widget? trailing;
  final bool isLogout;
  final Function() onTap;

  const SettingOptionItem({
    Key? key,
    required this.title,
    required this.leadingIcon,
    required this.leadingColor,
    required this.leadingBackgroundColor,
    this.trailing,
    this.isLogout = false,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(left: 36, right: 32).r,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 48.h,
                  height: 48.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10).r,
                    color: leadingBackgroundColor,
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      leadingIcon,
                      width: 24.w,
                      height: 24.h,
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        leadingColor,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 24.w),
                Text(
                  title,
                  style: AppTextStyle.blackS14W500,
                ),
              ],
            ),
            if (!isLogout)
              trailing ??
                  SvgPicture.asset(
                    AppVectors.icEnter,
                    width: 20.h,
                    height: 20.h,
                    fit: BoxFit.cover,
                  ),
          ],
        ),
      ),
    );
  }
}
