import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky/common/app_colors.dart';
import 'package:tasky/common/app_text_styles.dart';
import 'package:tasky/generated/l10n.dart';
import 'package:tasky/ui/pages/user_profile/widgets/general_options_list.dart';

class SettingOptionsList extends StatefulWidget {
  const SettingOptionsList({Key? key}) : super(key: key);

  @override
  State<SettingOptionsList> createState() => _SettingOptionsListState();
}

class _SettingOptionsListState extends State<SettingOptionsList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 28, bottom: 48).r,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: const Radius.circular(30).r,
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 50.r,
            color: AppColors.boxShadowColor.withOpacity(0.27),
            blurStyle: BlurStyle.outer,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 36).r,
            child: Text(
              S.current.general,
              style: AppTextStyle.blackO50S14W500,
            ),
          ),
          SizedBox(height: 24.h),
          const GeneralOptionsList(),
        ],
      ),
    );
  }
}
