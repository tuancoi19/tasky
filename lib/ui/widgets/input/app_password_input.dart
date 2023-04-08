import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasky/common/app_colors.dart';
import 'package:tasky/common/app_text_styles.dart';
import 'package:tasky/common/app_vectors.dart';
import 'package:tasky/utils/utils.dart';

class ObscureTextController extends ValueNotifier<bool> {
  ObscureTextController({bool obscureText = true}) : super(obscureText);

  bool get date => value;

  set date(bool obscureText) {
    value = obscureText;
  }
}

class AppPasswordInput extends StatelessWidget {
  final String? labelText;
  final TextStyle? labelStyle;
  final String? highlightText;
  final Widget? suffixIcon;
  final ObscureTextController? obscureTextController;
  final TextEditingController textEditingController;
  final TextStyle? textStyle;
  final String hintText;
  final String? errorText;
  final TextStyle? hintStyle;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final FormFieldValidator<String>? validator;
  final TextInputType textInputType;
  final FocusNode? passwordFocusNode;
  final Color? textFieldEnabledBorder;
  final Color? textFieldFocusedBorder;
  final Color? textFieldDisabledBorder;
  final Color? textFieldFocusedErrorBorder;
  final bool? isHighlightText;
  final AutovalidateMode? autoValidateMode;
  final bool autoTrim;
  final double borderRadius;

  const AppPasswordInput({
    Key? key,
    this.labelText,
    this.labelStyle,
    this.highlightText,
    this.suffixIcon,
    this.obscureTextController,
    required this.textEditingController,
    this.textStyle,
    this.hintText = "",
    this.errorText,
    this.hintStyle,
    this.onChanged,
    this.onSubmitted,
    this.validator,
    this.textInputType = TextInputType.text,
    this.passwordFocusNode,
    this.textFieldEnabledBorder,
    this.textFieldDisabledBorder,
    this.textFieldFocusedBorder,
    this.textFieldFocusedErrorBorder,
    this.isHighlightText = false,
    this.autoValidateMode,
    this.autoTrim = false,
    this.borderRadius = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(children: [
            TextSpan(
              text: labelText ?? '',
              style: labelStyle ?? AppTextStyle.blackS15W500,
            ),
            TextSpan(
              text: (isHighlightText ?? false) ? highlightText : "",
              style: AppTextStyle.redTextS14,
            )
          ]),
        ),
        SizedBox(height: 20.h),
        Stack(
          children: [
            ValueListenableBuilder(
              valueListenable: obscureTextController!,
              builder: (context, bool obscureText, child) {
                return Focus(
                  onFocusChange: (hasFocus) {
                    if (!hasFocus && autoTrim) {
                      textEditingController.text =
                          textEditingController.text.trim();
                    }
                  },
                  child: TextFormField(
                    onFieldSubmitted: onSubmitted,
                    onChanged: onChanged,
                    validator: validator ??
                        (text) {
                          if (Utils.isPassword(text ?? '')) {
                            return null;
                          }
                          return errorText ?? 'Password invalid';
                        },
                    autovalidateMode: autoValidateMode,
                    controller: textEditingController,
                    focusNode: passwordFocusNode,
                    style: textStyle ?? AppTextStyle.blackO40S14W400,
                    maxLines: 1,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ).r,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(borderRadius.r),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(borderRadius.r),
                        borderSide: BorderSide(
                          color: textFieldFocusedBorder ?? AppColors.primary,
                        ),
                      ),
                      disabledBorder: InputBorder.none,
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(borderRadius.r),
                        borderSide: BorderSide(
                          color: textFieldFocusedErrorBorder ??
                              AppColors.textFieldErrorBorder,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(borderRadius.r),
                        borderSide: BorderSide(
                          color: textFieldDisabledBorder ??
                              AppColors.textFieldErrorBorder,
                        ),
                      ),
                      fillColor: Colors.white,
                      hintStyle: hintStyle ?? AppTextStyle.blackO40S14W400,
                      hintText: hintText,
                      isDense: true,
                      filled: true,
                      errorMaxLines: 5,
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(right: 20).r,
                        child: ValueListenableBuilder(
                          valueListenable: obscureTextController!,
                          builder: (context, bool obscureText, child) {
                            return _buildSuffixIcon(obscureText);
                          },
                        ),
                      ),
                    ),
                    cursorColor: AppColors.primary,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: obscureText,
                  ),
                );
              },
            ),
            // Positioned(
            //   child: ValueListenableBuilder(
            //     valueListenable: obscureTextController!,
            //     child: Container(),
            //     builder: (context, bool obscureText, child) {
            //       return _buildSuffixIcon(obscureText);
            //     },
            //   ),
            // )
          ],
        ),
        ValueListenableBuilder(
          valueListenable: textEditingController,
          builder: (context, TextEditingValue controller, child) {
            final isValid = _validatePassword(controller.text);
            return Column(
              children: [
                SizedBox(height: 4.h),
                Text(
                  isValid,
                  style: AppTextStyle.blackS12.copyWith(color: Colors.yellow),
                ),
                SizedBox(height: 8.h),
              ],
            );
          },
        )
      ],
    );
  }

  Widget _buildSuffixIcon(bool obscureText) {
    return InkWell(
      onTap: () {
        Future.delayed(Duration.zero, () {
          passwordFocusNode?.unfocus();
        });
        obscureTextController?.value = !obscureText;
      },
      child: SvgPicture.asset(
        obscureText ? AppVectors.icHidePassword : AppVectors.icShowPassword,
        colorFilter: ColorFilter.mode(
          AppColors.textBlack.withOpacity(0.4),
          BlendMode.srcIn,
        ),
        width: 24.w,
        height: 24.h,
      ),
    );
  }

  String _validatePassword(String text) {
    return "";
  }
}
