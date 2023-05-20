import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasky/common/app_colors.dart';
import 'package:tasky/common/app_text_styles.dart';
import 'package:tasky/common/app_vectors.dart';
import 'package:tasky/configs/app_configs.dart';

class DetailTaskDocumentsListView extends StatelessWidget {
  const DetailTaskDocumentsListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24).r,
      itemBuilder: (context, index) {
        return buildDetailTaskDocumentsTextFileItem(
          name:
              'fwefw ef wefwef wefwe wgwgweg wgwegwg wegwgwegwg wgwrwerwerwer',
          type: AppConfigs.listTextFileType.first,
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(height: 8.h);
      },
      itemCount: 2,
    );
  }

  Widget buildDetailTaskDocumentsTextFileItem(
      {required String name, required String type}) {
    return SizedBox(
      height: 48.h,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 48.h,
            width: 48.h,
            decoration: BoxDecoration(
              color: AppColors.iconBackgroundColor,
              borderRadius: BorderRadius.circular(10).r,
            ),
            child: Center(
              child: SvgPicture.asset(
                AppVectors.icTextFile,
                width: 24.h,
                height: 24.h,
              ),
            ),
          ),
          SizedBox(width: 20.w),
          Flexible(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: AppTextStyle.blackO90S15W500,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '$type file',
                  style: AppTextStyle.blackO50S13W400,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          SizedBox(width: 24.w),
          InkWell(
            onTap: () {},
            child: SvgPicture.asset(
              AppVectors.icMoreHorizontal,
              width: 24.h,
              height: 24.h,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDetailTaskDocumentsImageFileItem(
      {required String name, required String type}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppColors.iconBackgroundColor,
            borderRadius: BorderRadius.circular(10).r,
          ),
          child: Center(
            child: SvgPicture.asset(
              AppVectors.icImageFile,
              width: 24.h,
              height: 24.h,
            ),
          ),
        ),
        SizedBox(width: 20.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: AppTextStyle.blackO90S15W500,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              '$type file',
              style: AppTextStyle.blackO50S13W400,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        SizedBox(width: 24.w),
        InkWell(
          onTap: () {},
          child: SvgPicture.asset(
            AppVectors.icMoreHorizontal,
            width: 24.h,
            height: 24.h,
          ),
        ),
      ],
    );
  }
}
