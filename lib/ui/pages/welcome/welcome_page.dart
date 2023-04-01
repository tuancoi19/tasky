import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasky/common/app_colors.dart';
import 'package:tasky/common/app_text_styles.dart';
import 'package:tasky/configs/app_configs.dart';
import 'package:tasky/generated/l10n.dart';
import 'package:tasky/router/route_config.dart';
import 'package:tasky/ui/widgets/buttons/app_button.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _buildBodyWidget(),
      ),
    );
  }

  Widget _buildBodyWidget() {
    return Stack(
      children: [
        buildWelcomeText(),
        Positioned(
          left: 0,
          bottom: 48,
          right: 0,
          child: buildNavigateButton(),
        )
      ],
    );
  }

  Widget buildWelcomeText() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: S.current.welcomeTo,
                  style: AppTextStyle.blackO80S25Bold,
                ),
                TextSpan(
                  text: AppConfigs.appName,
                  style: AppTextStyle.primaryS25Bold,
                )
              ],
            ),
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              S.current.appIntroduce,
              style: AppTextStyle.blackO60S16W400,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildNavigateButton() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: AppButton(
            height: 56,
            cornerRadius: 15,
            title: S.current.letsGo,
            textStyle: AppTextStyle.whiteS18Bold,
            backgroundColor: AppColors.primary,
            onPressed: () {
              Get.toNamed(RouteConfig.onboarding);
            },
          ),
        ),
        const SizedBox(height: 28),
        TextButton(
          onPressed: () {},
          child: Text(
            S.current.notNow,
            style: AppTextStyle.blackO30S18Bold,
          ),
        ),
      ],
    );
  }
}
