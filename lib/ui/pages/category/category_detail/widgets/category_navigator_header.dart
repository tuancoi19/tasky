import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tasky/common/app_vectors.dart';
import 'package:tasky/generated/l10n.dart';
import 'package:tasky/ui/commons/app_dialog.dart';

class CategoryNavigatorHeader extends StatelessWidget {
  final Function() onDelete;
  final Function() onEdit;
  final bool isLoading;
  final Color theme;

  const CategoryNavigatorHeader({
    Key? key,
    required this.onDelete,
    required this.onEdit,
    required this.isLoading,
    required this.theme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
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
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () async => await AppDialog.showConfirmDialog(
                  onConfirm: onDelete,
                  title: S.current.delete_task,
                  message: S.current.delete_message,
                  isLoading: isLoading,
                  color: theme),
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
              onTap: onEdit,
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
