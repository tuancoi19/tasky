import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky/common/app_colors.dart';
import 'package:tasky/common/app_text_styles.dart';
import 'package:tasky/utils/utils.dart';

class AppUsernameOrEmailInput extends StatelessWidget {
  final String? labelText;
  final TextStyle? labelStyle;
  final String? highlightText;
  final Widget? suffixIcon;
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

  const AppUsernameOrEmailInput({
    Key? key,
    this.labelText,
    this.labelStyle,
    this.highlightText,
    this.suffixIcon,
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
        Focus(
          onFocusChange: (hasFocus) {
            if (!hasFocus && autoTrim) {
              textEditingController.text = textEditingController.text.trim();
            }
          },
          child: Container(
            height: 56.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius.r),
            ),
            child: TextFormField(
              onFieldSubmitted: onSubmitted,
              onChanged: onChanged,
              validator: validator ??
                  (text) {
                    return Utils.emptyValidator(text ?? '');
                  },
              autovalidateMode: autoValidateMode,
              controller: textEditingController,
              focusNode: passwordFocusNode,
              style: textStyle ?? AppTextStyle.blackO40S14W400,
              maxLines: 1,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16).r,
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
              ),
              cursorColor: AppColors.primary,
            ),
          ),
        ),
      ],
    );
  }
}
