import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tasky/common/app_colors.dart';
import 'package:tasky/common/app_text_styles.dart';
import 'package:tasky/common/app_vectors.dart';
import 'package:tasky/generated/l10n.dart';
import 'package:tasky/ui/widgets/buttons/app_icon_button.dart';

class NavigatorRow extends StatelessWidget {
  final Function() onPressed;
  final Color? theme;

  const NavigatorRow({
    super.key,
    required this.onPressed,
    this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text(
            S.current.close,
            style: AppTextStyle.primaryO50S14W400.copyWith(
              color: theme,
            ),
          ),
        ),
        AppIconButton(
          onPressed: onPressed,
          backgroundColor: theme ?? AppColors.primary,
          cornerRadius: 10.r,
          width: 48.h,
          height: 48.h,
          icon: SvgPicture.asset(
            AppVectors.icArrowRight,
            width: 24.w,
            height: 24.h,
            colorFilter: const ColorFilter.mode(
              Colors.white,
              BlendMode.srcIn,
            ),
          ),
        ),
      ],
    );
  }
}
