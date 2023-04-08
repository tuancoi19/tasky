import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky/common/app_colors.dart';
import 'package:tasky/common/app_text_styles.dart';
import 'package:tasky/ui/widgets/buttons/app_button.dart';

class OnboardingContent extends StatelessWidget {
  final String title;
  final String description;
  final String buttonTitle;
  final Function() onPressed;

  const OnboardingContent({
    Key? key,
    required this.onPressed,
    required this.title,
    required this.description,
    required this.buttonTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 48).r,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: const Radius.circular(30).r,
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 50.r,
            color: AppColors.boxShadowColor,
            blurStyle: BlurStyle.outer,
          ),
        ],
      ),
      child: buildModalBottomSheet(),
    );
  }

  Widget buildModalBottomSheet() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        buildTitleAndDescription(
          title: title,
          description: description,
        ),
        SizedBox(height: 64.h),
        AppButton(
          backgroundColor: AppColors.primary,
          height: 56.h,
          cornerRadius: 15.r,
          title: buttonTitle,
          textStyle: AppTextStyle.whiteS18Bold,
          onPressed: () {
            onPressed.call();
          },
        ),
      ],
    );
  }

  Widget buildTitleAndDescription({
    required String title,
    required String description,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: AppTextStyle.blackO80S22Bold,
        ),
        SizedBox(height: 20.h),
        Text(
          description,
          style: AppTextStyle.blackO25S14w500,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
