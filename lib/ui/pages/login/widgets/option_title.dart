import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky/common/app_text_styles.dart';
import 'package:tasky/generated/l10n.dart';

class OptionTitle extends StatelessWidget {
  const OptionTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Expanded(
          child: Divider(
            thickness: 1,
          ),
        ),
        SizedBox(width: 16.w),
        Text(
          S.current.or_login_with,
          style: AppTextStyle.blackO60S16W400,
        ),
        SizedBox(width: 16.w),
        const Expanded(
          child: Divider(
            thickness: 1,
          ),
        ),
      ],
    );
  }
}
