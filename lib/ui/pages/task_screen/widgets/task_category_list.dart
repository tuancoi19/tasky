import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasky/common/app_colors.dart';
import 'package:tasky/common/app_text_styles.dart';
import 'package:tasky/common/app_vectors.dart';
import 'package:tasky/generated/l10n.dart';
import 'package:tasky/models/entities/category/category_entity.dart';
import 'package:tasky/ui/commons/app_dialog.dart';
import 'package:tasky/ui/pages/category/add_category/add_category_page.dart';

class TaskCategoryList extends StatelessWidget {
  final List<CategoryEntity> listData;
  final Function(CategoryEntity) onSelected;
  final CategoryEntity? selectedCategory;
  final Function(CategoryEntity?) onDone;
  final bool allowToEdit;

  const TaskCategoryList({
    super.key,
    required this.listData,
    required this.onSelected,
    required this.selectedCategory,
    required this.onDone,
    required this.allowToEdit,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.current.category,
            style: AppTextStyle.blackS15W500,
          ),
          SizedBox(height: 20.h),
          allowToEdit
              ? Wrap(spacing: 8.0.w, runSpacing: 8.0.h, children: [
                  if (listData.length < 6) buildItem(),
                  ...listData.map(
                    (item) {
                      return buildItem(
                        item: item,
                      );
                    },
                  ).toList()
                ])
              : buildItem(
                  item: selectedCategory,
                ),
        ],
      ),
    );
  }

  Widget buildItem({
    CategoryEntity? item,
  }) {
    return InkWell(
      onTap: () {
        if (item == null) {
          AppDialog.showCustomDialog(
            content: AddCategoryPage(
              arguments: AddCategoryArguments(
                category: selectedCategory,
                onDone: onDone,
              ),
            ),
          );
        } else {
          onSelected(item);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(8.0).r,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10).r,
          border: Border.all(
            color: item != null ? Color(item.color ?? 0) : AppColors.border,
          ),
          color:
              item == selectedCategory ? Color(item?.color ?? 0) : Colors.white,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (item == null) ...[
              SvgPicture.asset(
                AppVectors.icPlus,
                width: 16,
                height: 16,
                colorFilter: const ColorFilter.mode(
                  Colors.grey,
                  BlendMode.srcIn,
                ),
              ),
              SizedBox(width: 8.w),
            ],
            Text(
              item?.title ?? S.current.add_category,
              style: TextStyle(
                color: item != null
                    ? item != selectedCategory
                        ? Color(item.color ?? 0)
                        : Colors.white
                    : AppColors.border,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
