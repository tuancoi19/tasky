import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky/common/app_text_styles.dart';
import 'package:tasky/generated/l10n.dart';

class HelloText extends StatelessWidget {
  final String title;
  const HelloText({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: S.current.hello,
                style: AppTextStyle.blackS15W500,
              ),
              TextSpan(
                text: title,
                style: AppTextStyle.primaryS15W500,
              ),
            ],
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          S.current.complete_your_tasks_today,
          style: AppTextStyle.blackS20W500,
        ),
      ],
    );
  }
}
