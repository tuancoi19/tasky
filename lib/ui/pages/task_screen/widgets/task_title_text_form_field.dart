import 'package:flutter/material.dart';
import 'package:tasky/common/app_text_styles.dart';
import 'package:tasky/generated/l10n.dart';

class TaskTitleTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;

  const TaskTitleTextFormField({
    Key? key,
    required this.controller,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: 3,
      maxLength: 50,
      style: AppTextStyle.whiteS23W500,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: S.current.type_your_title,
        hintStyle: AppTextStyle.whiteO90S23W500,
        filled: true,
        fillColor: Colors.transparent,
        border: InputBorder.none,
        counterText: '',
      ),
      cursorColor: Colors.white,
    );
  }
}
