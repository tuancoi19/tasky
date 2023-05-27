import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tasky/common/app_text_styles.dart';
import 'package:tasky/generated/l10n.dart';
import 'package:tasky/utils/utils.dart';

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
      maxLines: 2,
      maxLength: 50,
      validator: (value) {
        return Utils.emptyValidator(
          value ?? '',
          message: S.current.enter_your_task_title,
        );
      },
      textInputAction: TextInputAction.done,
      style: AppTextStyle.whiteS23W500,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: S.current.type_your_title,
        hintStyle: AppTextStyle.whiteO90S23W500,
        filled: true,
        errorStyle: const TextStyle(color: Colors.white),
        enabledBorder: InputBorder.none,
        fillColor: Colors.transparent,
        border: InputBorder.none,
        counterText: '',
      ),
      inputFormatters: [
        FilteringTextInputFormatter.deny(
          RegExp('[\n]'), // Loại bỏ ký tự xuống dòng
        ),
      ],
      cursorColor: Colors.white,
    );
  }
}
