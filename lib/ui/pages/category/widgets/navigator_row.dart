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

  const NavigatorRow({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextButton(
          onPressed: () {
            Get.back(closeOverlays: true);
          },
          child: Text(
            S.current.close,
            style: AppTextStyle.primaryO50S14W400,
          ),
        ),
        AppIconButton(
          onPressed: onPressed,
          backgroundColor: AppColors.primary,
          cornerRadius: 10,
          width: 48,
          height: 48,
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
