import 'package:flutter/material.dart';
import 'package:tasky/common/app_colors.dart';
import 'package:tasky/common/app_text_styles.dart';

class AppTextFieldWidget extends StatelessWidget {
  final TextEditingController? inputController;
  final ValueChanged<String>? onChanged;
  final TextInputType? textInputType;
  final String? hintText;

  const AppTextFieldWidget({
    Key? key,
    this.inputController,
    this.onChanged,
    this.textInputType,
    this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: TextFormField(
        controller: inputController,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          hintText: hintText,
          hintMaxLines: 1,
          hintStyle: AppTextStyle.blackO40S14W400,
          enabledBorder: InputBorder.none,
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: AppColors.primary,
              ),
              borderRadius: BorderRadius.circular(10)),
        ),
        cursorColor: AppColors.primary,
        keyboardType: textInputType,
        onChanged: onChanged,
        style: AppTextStyle.blackS14W400,
        cursorHeight: 14,
        maxLines: 1,
      ),
    );
  }
}
