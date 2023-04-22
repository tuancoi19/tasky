import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky/common/app_colors.dart';
import 'package:tasky/common/app_images.dart';
import 'package:tasky/common/app_text_styles.dart';
import 'package:tasky/generated/l10n.dart';

class HomeListView extends StatelessWidget {
  const HomeListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 192.h,
      child: ListView.separated(
        itemBuilder: (context, index) {
          return buildTaskItem(index: index);
        },
        separatorBuilder: (context, index) {
          return SizedBox(width: 16.w);
        },
        itemCount: 3,
        padding: const EdgeInsets.symmetric(horizontal: 24).r,
        physics: const ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  Widget buildTaskItem({required int index}) {
    return Container(
      width: 152.w,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16).r,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10).r,
        image: DecorationImage(
          image: AssetImage(
            generatedImage(index),
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32.w,
            height: 32.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5).r,
              color: Colors.white.withOpacity(0.2),
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            '0 ${S.current.tasks}',
            style: AppTextStyle.whiteO50S10W500,
          ),
          SizedBox(height: 4.h),
          Text(
            'Some Unknown Tasks',
            style: AppTextStyle.whiteS15W500,
          )
        ],
      ),
    );
  }

  String generatedImage(int index) {
    const listImage = [
      AppImages.bgBlueTask,
      AppImages.bgRedTask,
      AppImages.bgGreenTask,
    ];
    return listImage[index % listImage.length];
  }

  Color generatedColor(int index) {
    final listShadowColor = [
      AppColors.blueTaskShadow,
      AppColors.redTaskShadow,
      AppColors.greenTaskShadow,
    ];
    return listShadowColor[index % listShadowColor.length];
  }
}
