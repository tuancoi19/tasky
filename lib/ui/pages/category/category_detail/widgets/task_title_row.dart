import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasky/common/app_colors.dart';
import 'package:tasky/common/app_text_styles.dart';
import 'package:tasky/common/app_vectors.dart';
import 'package:tasky/generated/l10n.dart';

class TaskTitleRow extends StatelessWidget {
  const TaskTitleRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          S.current.tasks,
          style: AppTextStyle.blackS15W500,
        ),
        InkWell(
          onTap: () {},
          child: Container(
            width: 48.h,
            height: 48.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10).r,
              color: AppColors.backgroundBackButtonColor,
            ),
            child: Center(
              child: SvgPicture.asset(
                AppVectors.icFilter,
                width: 24.h,
                height: 24.h,
              ),
            ),
          ),
        )
      ],
    );
  }
}
