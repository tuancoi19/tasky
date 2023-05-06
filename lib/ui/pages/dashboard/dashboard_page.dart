import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky/common/app_colors.dart';
import 'package:tasky/common/app_text_styles.dart';
import 'package:tasky/configs/app_configs.dart';
import 'package:tasky/generated/l10n.dart';
import 'package:tasky/ui/widgets/buttons/app_button.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 188.h,
        flexibleSpace: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppConfigs.appName,
              style: AppTextStyle.primaryS26Bold,
            ),
          ],
        ),
      ),
      body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: [
              Text(
                'Home',
                style: AppTextStyle.primaryS26Bold,
              ),
              AppButton(
                height: 56.h,
                title: S.current.log_in,
                cornerRadius: 15.r,
                textStyle: AppTextStyle.whiteS18Bold,
                backgroundColor: AppColors.primary,
                onPressed: () {
                  {}
                },
              ),
            ],
          )),
    );
  }
}
