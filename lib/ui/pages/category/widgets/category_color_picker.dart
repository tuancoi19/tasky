import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky/common/app_colors.dart';
import 'package:tasky/global/global_data.dart';

class CategoryColorPicker extends StatelessWidget {
  final Function(int) onTap;
  final int? selectedColor;
  final Color? theme;

  const CategoryColorPicker({
    Key? key,
    required this.onTap,
    this.selectedColor,
    this.theme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 8.w,
      mainAxisSpacing: 8.h,
      crossAxisCount: 5,
      children: getListColorData().map((e) => buildColorItem(e)).toList(),
    );
  }

  Widget buildColorItem(Color color) {
    return InkWell(
      onTap: () {
        onTap(color.value);
      },
      child: Container(
        width: 44.h,
        height: 44.h,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
          border: Border.all(
            color: color.value == selectedColor
                ? theme ?? AppColors.primary
                : Colors.transparent,
            width: 4.w,
          ),
        ),
      ),
    );
  }

  List<Color> getListColorData() {
    List<Color> listColorData = AppColors.categoryColorList;
    if (GlobalData.instance.categoriesList.isNotEmpty) {
      List<Color> listSelectedColor = GlobalData.instance.categoriesList
          .map((e) => Color(e.color))
          .toList();
      for (Color item in listSelectedColor) {
        listColorData.remove(item);
      }
    }
    return listColorData;
  }
}
