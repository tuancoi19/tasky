import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasky/common/app_text_styles.dart';
import 'package:tasky/common/app_vectors.dart';
import 'package:tasky/generated/l10n.dart';

class CategoryItem {
  final Color color;
  final String title;

  CategoryItem({required this.color, required this.title});
}

class AddTaskCategoryList extends StatelessWidget {
  const AddTaskCategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.current.category,
          style: AppTextStyle.blackS15W500,
        ),
        SizedBox(height: 20.h),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: items.map((item) {
            return buildItem(color: item.color, title: item.title);
          }).toList()
            ..insert(
              0,
              buildItem(isAdd: true),
            ),
        ),
      ],
    );
  }

  Widget buildItem({
    bool isAdd = false,
    Color? color,
    String? title,
  }) {
    return DottedBorder(
      color: isAdd ? Colors.grey : color!,
      borderType: BorderType.RRect,
      radius: const Radius.circular(12),
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          isAdd
              ? SvgPicture.asset(
                  AppVectors.icPlus,
                  width: 16,
                  height: 16,
                  colorFilter: const ColorFilter.mode(
                    Colors.grey,
                    BlendMode.srcIn,
                  ),
                )
              : CircleAvatar(backgroundColor: color, radius: 8),
          SizedBox(width: 8.w),
          Text(
            title ?? 'Add Category',
            style: TextStyle(
              color: color,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

List<CategoryItem> items = [
  CategoryItem(color: Colors.orange, title: '12412'),
  CategoryItem(color: Colors.cyan, title: '23535'),
  CategoryItem(color: Colors.red, title: '567658'),
  CategoryItem(color: Colors.orange, title: '12412'),
  CategoryItem(color: Colors.cyan, title: '23535'),
  CategoryItem(color: Colors.red, title: '567658'),
  CategoryItem(color: Colors.orange, title: '12412'),
  CategoryItem(color: Colors.cyan, title: '23535'),
  CategoryItem(color: Colors.red, title: '567658'),
];
