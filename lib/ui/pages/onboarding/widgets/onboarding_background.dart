import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasky/common/app_colors.dart';
import 'package:tasky/common/app_vectors.dart';

class OnboardingBackground extends StatelessWidget {
  final PageController controller;

  const OnboardingBackground({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.boxShadowColor.withOpacity(0.27),
      child: PageView(
        controller: controller,
        physics: const NeverScrollableScrollPhysics(),
        children: listPage,
      ),
    );
  }

  Widget buildOnboardingBackground(
    String vector,
  ) {
    return Align(
      alignment: Alignment.topCenter,
      child: SvgPicture.asset(
        vector,
      ),
    );
  }

  List<Widget> get listPage {
    return [
      buildOnboardingBackground(
        AppVectors.icManageYourActivity,
      ),
      buildOnboardingBackground(
        AppVectors.icSaveTheTime,
      ),
    ];
  }
}
