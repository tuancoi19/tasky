import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasky/common/app_text_styles.dart';
import 'package:tasky/common/app_vectors.dart';
import 'package:tasky/generated/l10n.dart';

class AppVipBadge extends StatelessWidget {
  const AppVipBadge({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          AppVectors.icVip,
          width: 20.w,
          height: 12.h,
          fit: BoxFit.cover,
        ),
        SizedBox(width: 8.w),
        Text(
          S.current.vip_user,
          style: AppTextStyle.primaryS14W400,
        ),
      ],
    );
  }
}
