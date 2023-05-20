import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky/common/app_colors.dart';
import 'package:tasky/common/app_text_styles.dart';

class AppSchedule extends StatelessWidget {
  final double? width;
  final double? height;
  final EdgeInsets? padding;

  const AppSchedule({
    Key? key,
    this.width,
    this.height,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double time = 0.5;

    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? double.infinity,
      child: SingleChildScrollView(
        padding: padding ??
            const EdgeInsets.symmetric(horizontal: 24, vertical: 32).r,
        child: Stack(
          children: [
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return _buildRowHour(hour: index);
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: 56.h);
              },
              itemCount: 24,
            ),
            Positioned(
              top: (56.h + 16.h) * 2 + 8.h,
              right: 0,
              left: 68.w,
              child: Container(
                height: (56.h + 16.h) * time,
                padding: const EdgeInsets.symmetric(horizontal: 20).r,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10).r,
                  color: AppColors.taskColorList.first.withOpacity(0.25),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      color: AppColors.taskColorList.first,
                      width: 4.w,
                      height: double.infinity,
                      margin: const EdgeInsets.symmetric(vertical: 12).r,
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: time >= 0.5
                          ? Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Loren Ipsum',
                                  style: AppTextStyle.blackO80S14W500,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  'Loren Ipsum',
                                  style: AppTextStyle.blackO30S14W500,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Loren Ipsum',
                                  style: AppTextStyle.blackO80S14W500,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  'Loren Ipsum',
                                  style: AppTextStyle.blackO30S14W500,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRowHour({required int hour}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 68.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                '${hour.toString().padLeft(2, '0')}:00',
                style: AppTextStyle.blackO60S14Bold,
              ),
            ],
          ),
        ),
        Flexible(
          child: Divider(
            thickness: 1,
            color: AppColors.textBlack.withOpacity(0.05),
            height: 16.h,
          ),
        ),
      ],
    );
  }
}
