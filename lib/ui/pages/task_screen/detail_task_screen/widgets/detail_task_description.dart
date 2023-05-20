import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky/common/app_text_styles.dart';

class DetailTaskDescription extends StatelessWidget {
  final String content;

  const DetailTaskDescription({
    Key? key,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20).r,
      child: Text(
        content,
        style: AppTextStyle.blackO50S13W400,
      ),
    );
  }
}
