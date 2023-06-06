import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tasky/common/app_vectors.dart';

class TaskNavigatorHeader extends StatelessWidget {
  final bool isEdit;
  final Function() onChangeIsEdit;
  final Function() onDelete;
  final bool isShowOptions;

  const TaskNavigatorHeader({
    Key? key,
    required this.isEdit,
    required this.onChangeIsEdit,
    required this.onDelete, required this.isShowOptions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        isEdit
            ? InkWell(
                onTap: onChangeIsEdit,
                child: SvgPicture.asset(
                  AppVectors.icClose,
                  width: 24.h,
                  height: 24.h,
                  colorFilter: const ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                  ),
                ),
              )
            : InkWell(
                onTap: () {
                  Get.back();
                },
                child: SvgPicture.asset(
                  AppVectors.icArrowLeft,
                  width: 20.w,
                  height: 16.h,
                  colorFilter: const ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                  ),
                ),
              ),
        if (isShowOptions)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: onDelete,
                child: SvgPicture.asset(
                  AppVectors.icDelete,
                  width: 24.h,
                  height: 24.h,
                  colorFilter: const ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              SizedBox(width: 32.w),
              InkWell(
                onTap: onChangeIsEdit,
                child: SvgPicture.asset(
                  AppVectors.icEdit,
                  width: 24.h,
                  height: 24.h,
                  colorFilter: const ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ],
          )
      ],
    );
  }
}
