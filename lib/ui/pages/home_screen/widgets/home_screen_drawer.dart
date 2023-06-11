import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tasky/blocs/app_cubit.dart';
import 'package:tasky/common/app_colors.dart';
import 'package:tasky/common/app_images.dart';
import 'package:tasky/common/app_text_styles.dart';
import 'package:tasky/common/app_vectors.dart';
import 'package:tasky/generated/l10n.dart';
import 'package:tasky/router/route_config.dart';
import 'package:tuple/tuple.dart';

class HomeScreenDrawer extends StatefulWidget {
  final Function() logout;
  final Function(bool) onTap;

  const HomeScreenDrawer({
    Key? key,
    required this.onTap,
    required this.logout,
  }) : super(key: key);

  @override
  State<HomeScreenDrawer> createState() => _HomeScreenDrawerState();
}

class _HomeScreenDrawerState extends State<HomeScreenDrawer> {
  bool needReload = false;

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
      padding: const EdgeInsets.symmetric(vertical: 64).r,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 28).r,
            child: InkWell(
              onTap: () {
                widget.onTap.call(needReload);
              },
              child: SvgPicture.asset(
                AppVectors.icBackCircle,
                width: 36.h,
                height: 36.h,
              ),
            ),
          ),
          SizedBox(height: 64.h),
          Padding(
            padding: const EdgeInsets.only(right: 28).r,
            child: buildColumnInfo(),
          ),
          SizedBox(height: 64.h),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 28).r,
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

  Widget buildColumnInfo() {
    return InkWell(
      onTap: () {
        Get.toNamed(
          RouteConfig.editUserProfile,
        );
      },
      child: SizedBox(
        width: double.infinity,
        child: BlocBuilder<AppCubit, AppState>(
          builder: (context, state) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(7).r,
                  child: state.user?.avatarUrl != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(7).r,
                          child: Image(
                            width: 68.h,
                            height: 68.h,
                            fit: BoxFit.fill,
                            image: CachedNetworkImageProvider(
                              state.user?.avatarUrl ?? '',
                            ),
                          ),
                        )
                      : Image.asset(
                          AppImages.icUser,
                          width: 68.h,
                          height: 68.h,
                          fit: BoxFit.cover,
                        ),
                ),
                SizedBox(height: 20.h),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28).r,
                  child: Column(
                    children: [
                      Text(
                        state.user?.userName ?? '',
                        style: AppTextStyle.whiteS16W600,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      Text(
                        state.user?.email ?? '',
                        style: AppTextStyle.whiteO80S13W400,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
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
              width: 24.h,
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
      Tuple3(S.current.activity, AppVectors.icCalendar, () async {
        final data = await Get.toNamed(RouteConfig.activity);
        if (data ?? false) {
          needReload = data;
        }
      }),
      Tuple3(S.current.app_settings, AppVectors.icSettings, () {}),
      Tuple3(S.current.logout, AppVectors.icLogout, widget.logout),
    ];
  }
}
