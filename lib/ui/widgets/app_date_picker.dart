import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:tasky/common/app_colors.dart';
import 'package:tasky/common/app_text_styles.dart';
import 'package:tasky/configs/app_configs.dart';
import 'package:tasky/generated/l10n.dart';

class AppDatePicker extends StatelessWidget {
  final TextEditingController controller;
  final String? title;
  final Function(String?) onChange;

  const AppDatePicker({
    Key? key,
    required this.controller,
    this.title,
    required this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title ?? S.current.date,
          style: AppTextStyle.blackS15W500,
        ),
        SizedBox(height: 20.h),
        SizedBox(
          height: 56.h,
          child: DateTimePicker(
            type: DateTimePickerType.date,
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(
              const Duration(days: 365),
            ),
            locale: AppConfigs.defaultLocal,
            onChanged: onChange,
            controller: controller,
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
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10).r,
                borderSide: const BorderSide(
                  color: AppColors.textFieldErrorBorder,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10).r,
                borderSide: const BorderSide(
                  color: AppColors.textFieldErrorBorder,
                ),
              ),
              fillColor: AppColors.backgroundBackButtonColor,
              hintStyle: AppTextStyle.blackO40S14W400,
              hintText: DateFormat(AppConfigs.dateDisplayFormat)
                  .format(DateTime.now()),
              isDense: true,
              filled: true,
            ),

            //TODO
            // validator: (val) {
            //   setState(() => {});
            //   return null;
            // },
            onSaved: (val) => onChange(val),
          ),
        ),
      ],
    );
  }
}
