import 'package:flutter/material.dart';
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
      height: MediaQuery.of(context).size.height * 0.3,
      padding: const EdgeInsets.only(left: 24, right: 24, top: 48),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 50,
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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        buildTitleAndDescription(
          title: title,
          description: description,
        ),
        AppButton(
          backgroundColor: AppColors.primary,
          height: 56,
          cornerRadius: 15,
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
        const SizedBox(height: 20),
        Text(
          description,
          style: AppTextStyle.blackO25S14w500,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
