import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky/common/app_colors.dart';
import 'package:tasky/common/app_text_styles.dart';
import 'package:tasky/generated/l10n.dart';

class NoteTextField extends StatelessWidget {
  final Function(String) onChanged;
  final TextEditingController controller;

  const NoteTextField({
    Key? key,
    required this.onChanged,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.current.note,
          style: AppTextStyle.blackS15W500,
        ),
        SizedBox(height: 20.h),
        Container(
          height: 152.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10).r,
          ),
          child: TextField(
            onChanged: onChanged,
            controller: controller,
            style: AppTextStyle.blackO40S14W400,
            maxLines: 8,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 16).r,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10).r,
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10).r,
                borderSide: const BorderSide(
                  color: AppColors.primary,
                ),
              ),
              disabledBorder: InputBorder.none,
              fillColor: AppColors.backgroundBackButtonColor,
              hintStyle: AppTextStyle.blackO40S14W400,
              hintText: S.current.take_note,
              isDense: true,
              filled: true,
            ),
            cursorColor: AppColors.primary,
          ),
        ),
      ],
    );
  }
}
