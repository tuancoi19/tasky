import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky/common/app_colors.dart';

class CategoryColorPicker extends StatelessWidget {
  final Function(Color) onTap;
  final Color? selectedColor;

  const CategoryColorPicker({
    Key? key,
    required this.onTap,
    this.selectedColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children:
          AppColors.categoryColorList.map((e) => buildColorItem(e)).toList(),
    );
  }

  Widget buildColorItem(Color color) {
    return InkWell(
      onTap: () {
        onTap(color);
      },
      child: Container(
        width: 44.h,
        height: 44.h,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
          border: Border.all(
            color:
                color == selectedColor ? AppColors.primary : Colors.transparent,
            width: 2.w,
          ),
        ),
      ),
    );
  }
}
