import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasky/common/app_colors.dart';
import 'package:tasky/common/app_vectors.dart';
import 'package:tasky/ui/widgets/buttons/app_icon_button.dart';

class HomeAddButton extends StatelessWidget {
  final Function() onTap;

  const HomeAddButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Stack(
        children: [
          Positioned(
            bottom: 4.h,
            left: 4.w,
            right: 4.w,
            child: Container(
              width: 28.w,
              height: 32.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10).r,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.4),
                    blurRadius: 4.r,
                    offset: const Offset(0, 0), // Shadow position
                  ),
                ],
              ),
            ),
          ),
          AppIconButton(
            width: 32.h,
            height: 32.h,
            icon: SvgPicture.asset(
              AppVectors.icPlus,
              width: 16.h,
              height: 16.h,
            ),
            cornerRadius: 10,
            backgroundColor: AppColors.primary,
          ),
        ],
      ),
    );
  }
}
