import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky/common/app_dimens.dart';

import '../app_circular_progress_indicator.dart';

class AppIconButton extends StatelessWidget {
  final Widget icon;

  final bool isLoading;

  final double? height;
  final double? width;
  final double? borderWidth;
  final double? cornerRadius;

  final Color? backgroundColor;
  final Color? borderColor;

  final TextStyle? textStyle;

  final GestureTapCallback? onPressed;

  const AppIconButton({
    Key? key,
    required this.icon,
    this.isLoading = false,
    this.height,
    this.width,
    this.borderWidth,
    this.cornerRadius,
    this.backgroundColor,
    this.borderColor,
    this.textStyle,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: height ?? AppDimens.buttonHeight,
        width: width ?? double.infinity,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(
            cornerRadius ?? AppDimens.buttonCornerRadius,
          ).r,
          border: Border.all(
            color: borderColor ?? Colors.transparent,
            width: (borderWidth ?? 0).w,
          ),
        ),
        child: Center(
          child: _buildChildWidget(),
        ),
      ),
    );
  }

  Widget _buildChildWidget() {
    if (isLoading) {
      return const AppCircularProgressIndicator(color: Colors.white);
    } else {
      return icon;
    }
  }
}
