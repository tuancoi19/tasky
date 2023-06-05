import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky/models/entities/category/category_entity.dart';
import 'package:tasky/ui/pages/home_screen/widgets/category_item.dart';

class CategoryListView extends StatelessWidget {
  final List<CategoryEntity> categoryList;

  const CategoryListView({
    Key? key,
    required this.categoryList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return CategoryItem(
          index: index,
          data: categoryList[index],
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(width: 16.w);
      },
      itemCount: categoryList.length,
      padding: const EdgeInsets.only(left: 24, top: 12, right: 24).r,
      physics: const ClampingScrollPhysics(),
      scrollDirection: Axis.horizontal,
    );
  }
}
