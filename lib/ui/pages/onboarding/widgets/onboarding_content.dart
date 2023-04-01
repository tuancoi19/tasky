import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tasky/common/app_colors.dart';
import 'package:tasky/common/app_text_styles.dart';
import 'package:tasky/generated/l10n.dart';
import 'package:tasky/ui/widgets/buttons/app_button.dart';

class OnboardingContent extends StatelessWidget {
  final PageController controller;
  final Function() onPressed;
  final Function(int) onDotsClicked;

  const OnboardingContent({
    Key? key,
    required this.controller,
    required this.onPressed, required this.onDotsClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.45,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
        color: Colors.white,
      ),
      child: PageView(
        controller: controller,
        physics: const NeverScrollableScrollPhysics(),
        children: listPage,
      ),
    );
  }

  List<Widget> get listPage {
    return [
      buildModalBottomSheet(
        title: S.current.manageYourActivity,
        description: S.current.manageYourActivityDescription,
        buttonTitle: S.current.next,
        onPressed: () {
          onPressed.call();
        },
      ),
      buildModalBottomSheet(
        title: S.current.saveTheTime,
        description: S.current.saveTheTimeDescription,
        buttonTitle: S.current.getStarted,
        onPressed: () {},
      ),
    ];
  }

  Widget buildModalBottomSheet({
    required String title,
    required String description,
    required String buttonTitle,
    required Function() onPressed,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        buildTitleAndDescription(
          title: title,
          description: description,
        ),
        buildButtonAndIndicator(
          title: buttonTitle,
          onPressed: onPressed,
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

  Widget buildButtonAndIndicator({
    required String title,
    required Function() onPressed,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AppButton(
          backgroundColor: AppColors.primary,
          height: 56,
          cornerRadius: 15,
          title: title,
          textStyle: AppTextStyle.whiteS18Bold,
          onPressed: () {
            onPressed.call();
          },
        ),
        const SizedBox(height: 36),
        SmoothPageIndicator(
          controller: controller,
          count: 2,
          onDotClicked: onDotsClicked,
          effect: ExpandingDotsEffect(
            activeDotColor: AppColors.primary,
            dotColor: AppColors.dotColor,
            dotHeight: 8,
            dotWidth: 8,
          ),
        ),
      ],
    );
  }
}
