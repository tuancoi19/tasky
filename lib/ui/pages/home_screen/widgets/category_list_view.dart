import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky/ui/pages/home_screen/widgets/category_item.dart';

class CategoryListView extends StatelessWidget {
  const CategoryListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 236.h,
      child: ListView.separated(
        itemBuilder: (context, index) {
          return CategoryItem(index: index);
        },
        separatorBuilder: (context, index) {
          return SizedBox(width: 16.w);
        },
        itemCount: 3,
        padding: const EdgeInsets.only(left: 24, top: 12, right: 24).r,
        physics: const ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
