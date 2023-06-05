import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky/common/app_colors.dart';
import 'package:tasky/common/app_text_styles.dart';
import 'package:tasky/generated/l10n.dart';
import 'package:tasky/ui/widgets/buttons/app_button.dart';

class EmptyListWidget extends StatelessWidget {
  final Function() onRefresh;
  final double? height;

  const EmptyListWidget({
    Key? key,
    required this.onRefresh,
    this.height,
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
              S.current.empty_data,
              style: AppTextStyle.blackS20W500,
            ),
            SizedBox(height: 12.h),
            AppButton(
              title: S.current.add,
              cornerRadius: 15.r,
              height: 56.h,
              textStyle: AppTextStyle.whiteS18Bold,
              backgroundColor: AppColors.primary,
              onPressed: onRefresh,
            )
          ],
        ),
      ),
    );
  }
}
