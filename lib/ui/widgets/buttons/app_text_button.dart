import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky/common/app_dimens.dart';
import 'package:tasky/ui/widgets/app_circular_progress_indicator.dart';

class AppTextButton extends StatelessWidget {
  final String title;

  final bool isLoading;

  final double? height;
  final double? width;
  final double? borderWidth;
  final double? cornerRadius;

  final Color? backgroundColor;
  final Color? borderColor;

  final TextStyle? textStyle;

  final GestureTapCallback? onPressed;

  final EdgeInsets? padding;

  const AppTextButton({
    Key? key,
    required this.title,
    this.isLoading = false,
    this.height,
    this.width,
    this.borderWidth,
    this.cornerRadius,
    this.backgroundColor,
    this.borderColor,
    this.textStyle,
    this.onPressed,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: (height ?? AppDimens.buttonHeight).h,
        width: width?.w,
        padding: padding ?? const EdgeInsets.symmetric(horizontal: 12).r,
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
        child: _buildChildWidget(),
      ),
    );
  }

  Widget _buildChildWidget() {
    if (isLoading) {
      return const AppCircularProgressIndicator(color: Colors.white);
    } else {
      return Center(
        child: Text(
          title,
          overflow: TextOverflow.ellipsis,
          style: textStyle ??
              TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
        ),
      );
    }
  }
}
