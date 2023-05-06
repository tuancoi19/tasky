import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky/common/app_colors.dart';
import 'package:tasky/common/app_vectors.dart';
import 'package:tasky/generated/l10n.dart';
import 'package:tasky/ui/pages/user_profile/widgets/setting_option_item.dart';

class PrivacyOptionsList extends StatelessWidget {
  const PrivacyOptionsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SettingOptionItem(
          title: S.current.help_center,
          leadingIcon: AppVectors.icHelpCenter,
          leadingColor: AppColors.helpCenterIconColor,
          leadingBackgroundColor: AppColors.helpCenterBackgroundColor,
          onTap: () {},
        ),
        SizedBox(height: 12.h),
        SettingOptionItem(
          title: S.current.about_us,
          leadingIcon: AppVectors.icAboutUs,
          leadingColor: AppColors.aboutUsIconColor,
          leadingBackgroundColor: AppColors.aboutUsBackgroundColor,
          onTap: () {},
        ),
      ],
    );
  }
}
