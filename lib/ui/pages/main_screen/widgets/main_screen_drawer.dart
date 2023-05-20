import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasky/blocs/app_cubit.dart';
import 'package:tasky/common/app_colors.dart';
import 'package:tasky/common/app_images.dart';
import 'package:tasky/common/app_text_styles.dart';
import 'package:tasky/common/app_vectors.dart';
import 'package:tasky/generated/l10n.dart';
import 'package:tuple/tuple.dart';

class MainScreenDrawer extends StatelessWidget {
  final AppCubit appCubit;
  final Function() onTap;

  const MainScreenDrawer({
    Key? key,
    required this.onTap,
    required this.appCubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.drawerBackgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 64).r,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: onTap,
            child: SvgPicture.asset(
              AppVectors.icBackCircle,
              width: 36.w,
              height: 36.h,
            ),
          ),
          SizedBox(height: 64.h),
          buildRowInfo(),
          SizedBox(height: 64.h),
          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: listOptions().length,
              itemBuilder: (context, index) {
                return buildOptionsItem(index);
              },
              separatorBuilder: (context, index) => SizedBox(height: 36.h),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildRowInfo() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(7).r,
          child: Image.asset(
            AppImages.avatarTest,
            fit: BoxFit.cover,
            width: 68.h,
            height: 68.h,
          ),
        ),
        SizedBox(width: 20.w),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Loren Ipsum',
              style: AppTextStyle.whiteS16W600,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            Text(
              'Loren Ipsum',
              style: AppTextStyle.whiteO80S13W400,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ],
        )
      ],
    );
  }

  Widget buildOptionsItem(int index) {
    return InkWell(
      onTap: listOptions().elementAt(index).item3,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Opacity(
            opacity: 0.8,
            child: SvgPicture.asset(
              listOptions().elementAt(index).item2,
              width: 24.w,
              height: 24.h,
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
            ),
          ),
          SizedBox(width: 24.w),
          Text(
            listOptions().elementAt(index).item1,
            style: AppTextStyle.whiteO80S14W500,
          ),
        ],
      ),
    );
  }

  List<Tuple3<String, String, Function()>> listOptions() {
    return [
      Tuple3(S.current.manage_account, AppVectors.icUser, () {}),
      Tuple3(S.current.search_tasks, AppVectors.icSearch, () {}),
      Tuple3(S.current.activity, AppVectors.icActivity, () {}),
      Tuple3(S.current.app_settings, AppVectors.icSettings, () {}),
      Tuple3(S.current.logout, AppVectors.icLogout, () {
        appCubit.signOut();
      }),
    ];
  }
}
