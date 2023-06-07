import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky/common/app_colors.dart';
import 'package:tasky/common/app_images.dart';

class AppDetailPage extends StatelessWidget {
  final Widget headerWidget;
  final Widget bodyWidget;
  final double? bodyHeight;
  final Color? headerColor;
  final String? backgroundHeader;

  const AppDetailPage({
    Key? key,
    required this.headerWidget,
    required this.bodyWidget,
    this.bodyHeight,
    this.headerColor, this.backgroundHeader,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: headerColor ?? AppColors.primary,
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                backgroundHeader ?? AppImages.firstTaskOverlay,
              ),
              alignment: Alignment.topCenter,
            ),
          ),
          child: headerWidget,
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: bodyHeight ?? 564.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                top: const Radius.circular(30).r,
              ),
            ),
            child: bodyWidget,
          ),
        ),
      ],
    );
  }
}
