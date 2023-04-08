import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasky/common/app_colors.dart';
import 'package:tasky/common/app_text_styles.dart';
import 'package:tasky/common/app_vectors.dart';

class AppTextFieldWidget extends StatelessWidget {
  final TextEditingController? inputController;
  final ValueChanged<String>? onChanged;
  final TextInputType textInputType;
  final String hintText;
  final double borderRadius;
  final double height;

  const AppTextFieldWidget({
    Key? key,
    this.inputController,
    this.onChanged,
    this.textInputType = TextInputType.text,
    this.hintText = '',
    this.borderRadius = 0,
    this.height = 56,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius).r,
        color: Colors.white,
      ),
      child: Center(
        child: TextFormField(
          controller: inputController,
          decoration: InputDecoration(
            suffixIcon: buildShowPasswordButton(),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 16).r,
            hintText: hintText,
            hintMaxLines: 1,
            hintStyle: AppTextStyle.blackO40S14W400,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
          ),
          cursorColor: AppColors.primary,
          keyboardType: textInputType,
          onChanged: onChanged,
          style: AppTextStyle.blackS14W400,
          cursorHeight: 14.h,
          maxLines: 1,
        ),
      ),
    );
  }

  Widget buildShowPasswordButton() {
    if (textInputType == TextInputType.visiblePassword) {
      return InkWell(
        child: Padding(
          padding: const EdgeInsets.only(right: 20).r,
          child: SvgPicture.asset(
            AppVectors.icShowPassword,
            width: 24.w,
            height: 24.h,
            colorFilter: ColorFilter.mode(
              AppColors.textBlack.withOpacity(0.4),
              BlendMode.srcIn,
            ),
          ),
        ),
      );
    } else {
      return const SizedBox();
    }
  }
}
