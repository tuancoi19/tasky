import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tasky/common/app_text_styles.dart';
import 'package:tasky/ui/commons/app_date_time_picker.dart';

class AddTaskDatePicker extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) whenComplete;
  final String? hintText;
  final DateFormat _dateFormat = DateFormat('dd MMM, yyyy');

  AddTaskDatePicker({
    Key? key,
    required this.controller,
    required this.whenComplete,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      readOnly: true,
      onTap: () async {
        final result = await AppDateTimePicker.selectDate(
          context,
          initialDate: hintText != null
              ? _dateFormat.parse(
                  hintText!,
                )
              : null,
        );
        if (result != null) {
          whenComplete(_dateFormat.format(result));
        }
      },
      decoration: InputDecoration(
          hintText: hintText ?? _dateFormat.format(DateTime.now()),
          hintStyle: AppTextStyle.whiteO60S14W500,
          border: InputBorder.none),
    );
  }
}
