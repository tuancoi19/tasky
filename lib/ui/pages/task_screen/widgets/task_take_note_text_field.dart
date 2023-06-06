import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky/common/app_colors.dart';
import 'package:tasky/common/app_text_styles.dart';
import 'package:tasky/generated/l10n.dart';
import 'package:tasky/utils/utils.dart';

class TaskTakeNoteTextField extends StatelessWidget {
  final Function(String) onChanged;
  final TextEditingController controller;
  final Color color;
  final bool readOnly;

  const TaskTakeNoteTextField({
    Key? key,
    required this.onChanged,
    required this.controller,
    required this.color,
    required this.readOnly,
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
          child: TextFormField(
            readOnly: readOnly,
            onChanged: onChanged,
            controller: controller,
            style: AppTextStyle.blackO40S14W400,
            maxLines: 8,
            maxLength: 1000,
            validator: (text) {
              return Utils.emptyValidator(
                text ?? '',
                message: S.current.enter_your_task_note,
              );
            },
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 16).r,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10).r,
                borderSide: BorderSide.none,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10).r,
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10).r,
                borderSide: readOnly
                    ? BorderSide.none
                    : BorderSide(
                        color: color,
                      ),
              ),
              disabledBorder: InputBorder.none,
              fillColor: AppColors.backgroundBackButtonColor,
              hintStyle: AppTextStyle.blackO40S14W400,
              hintText: S.current.take_note,
              isDense: true,
              filled: true,
            ),
            cursorColor: color,
          ),
        ),
      ],
    );
  }
}
