import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky/common/app_colors.dart';
import 'package:tasky/common/app_vectors.dart';
import 'package:tasky/generated/l10n.dart';
import 'package:tasky/ui/pages/user_profile/user_profile_cubit.dart';
import 'package:tasky/ui/pages/user_profile/widgets/setting_option_item.dart';

class GeneralOptionsList extends StatelessWidget {
  const GeneralOptionsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SettingOptionItem(
          title: S.current.manage_account,
          leadingIcon: AppVectors.icUser,
          leadingColor: AppColors.manageAccountIconColor,
          leadingBackgroundColor: AppColors.manageAccountBackgroundColor,
          onTap: () {},
        ),
        SizedBox(height: 16.h),
        SettingOptionItem(
          title: S.current.notification,
          leadingIcon: AppVectors.icNotification,
          leadingColor: AppColors.notificationIconColor,
          leadingBackgroundColor: AppColors.notificationBackgroundColor,
          trailing: buildSegment(),
          onTap: () {},
        ),
        SizedBox(height: 16.h),
        SettingOptionItem(
          title: S.current.become_an_vip_user,
          leadingIcon: AppVectors.icVip,
          leadingColor: AppColors.becomeVipIconColor,
          leadingBackgroundColor: AppColors.becomeVipBackgroundColor,
          onTap: () {},
        ),
        SizedBox(height: 16.h),
        SettingOptionItem(
          title: S.current.logout,
          leadingIcon: AppVectors.icLogout,
          leadingColor: AppColors.logoutIconColor,
          leadingBackgroundColor: AppColors.logoutBackgroundColor,
          isLogout: true,
          onTap: () {},
        ),
      ],
    );
  }

  Widget buildSegment() {
    return BlocBuilder<UserProfileCubit, UserProfileState>(
      builder: (context, state) {
        return SizedBox(
          width: 44.w,
          height: 24.h,
          child: CupertinoSwitch(
            value: state.isNotify,
            onChanged: (value) {
              BlocProvider.of<UserProfileCubit>(context)
                  .changeIsNotify(isNotify: value);
            },
            activeColor: AppColors.primary,
          ),
        );
      },
    );
  }
}
