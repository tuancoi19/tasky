import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky/common/app_colors.dart';
import 'package:tasky/common/app_text_styles.dart';
import 'package:tasky/generated/l10n.dart';
import 'package:tasky/ui/widgets/buttons/app_button.dart';

class ErrorViewWidget extends StatelessWidget {
  final double? height;
  final Function() onRefresh;
  final Color? theme;

  const ErrorViewWidget({
    Key? key,
    required this.onRefresh,
    this.height,
    this.theme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 32).r,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              S.current.something_wrong,
              style: AppTextStyle.blackS20W500,
            ),
            SizedBox(height: 24.h),
            AppButton(
              title: S.current.retry,
              cornerRadius: 15.r,
              height: 56.h,
              onPressed: onRefresh,
              textStyle: AppTextStyle.whiteS18Bold,
              backgroundColor: theme ?? AppColors.primary,
            )
          ],
        ),
      ),
    );
  }
}
