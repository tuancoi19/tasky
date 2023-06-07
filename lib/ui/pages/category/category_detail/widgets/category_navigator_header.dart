import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasky/common/app_vectors.dart';
import 'package:tasky/generated/l10n.dart';
import 'package:tasky/models/entities/category/category_entity.dart';
import 'package:tasky/ui/commons/app_dialog.dart';
import 'package:tasky/ui/pages/category/add_category/add_category_page.dart';

class CategoryNavigatorHeader extends StatelessWidget {
  final Function() onDelete;
  final Function(CategoryEntity?) onEdit;
  final bool isLoading;
  final CategoryEntity category;
  final Function() onBack;

  const CategoryNavigatorHeader({
    Key? key,
    required this.onDelete,
    required this.onEdit,
    required this.isLoading,
    required this.category,
    required this.onBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: onBack,
          child: SvgPicture.asset(
            AppVectors.icArrowLeft,
            width: 20.w,
            height: 16.h,
            colorFilter: const ColorFilter.mode(
              Colors.white,
              BlendMode.srcIn,
            ),
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () async => await AppDialog.showConfirmDialog(
                onConfirm: onDelete,
                title: S.current.delete_category,
                message: S.current.delete_category_message,
                isLoading: isLoading,
                color: Color(category.color ?? 0),
              ),
              child: SvgPicture.asset(
                AppVectors.icDelete,
                width: 24.h,
                height: 24.h,
                colorFilter: const ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                ),
              ),
            ),
            SizedBox(width: 32.w),
            InkWell(
              onTap: () async {
                await AppDialog.showCustomDialog(
                  content: AddCategoryPage(
                    arguments: AddCategoryArguments(
                      category: category,
                      onDone: (value) {
                        onEdit.call(value);
                      },
                    ),
                  ),
                );
              },
              child: SvgPicture.asset(
                AppVectors.icEdit,
                width: 24.h,
                height: 24.h,
                colorFilter: const ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
