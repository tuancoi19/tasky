import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky/common/app_colors.dart';
import 'package:tasky/common/app_images.dart';
import 'package:tasky/common/app_text_styles.dart';
import 'package:tasky/generated/l10n.dart';

class CategoryItem extends StatelessWidget {
  final int index;

  const CategoryItem({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: 24.h,
          left: 24.w,
          right: 24.w,
          child: Container(
            width: 100.w,
            height: 136.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10).r,
              boxShadow: [
                BoxShadow(
                  color: generatedColor(index),
                  blurRadius: 25.r,
                  offset: const Offset(0, 0), // Shadow position
                ),
              ],
            ),
          ),
        ),
        Container(
          width: 152.w,
          height: 192.h,
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
              SizedBox(height: 4.h),
              Text(
                '0 ${S.current.tasks}',
                style: AppTextStyle.whiteO50S10W500,
              ),
              SizedBox(height: 4.h),
              Text(
                'Some Unknown Tasks',
                style: AppTextStyle.whiteS15W500,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              )
            ],
          ),
        ),
      ],
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
    return AppColors.taskColorList[index % AppColors.taskColorList.length]
        .withOpacity(0.5);
  }
}
