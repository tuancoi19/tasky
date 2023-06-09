import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tasky/common/app_colors.dart';
import 'package:tasky/common/app_text_styles.dart';
import 'package:tasky/common/app_vectors.dart';
import 'package:tasky/generated/l10n.dart';

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  final TextEditingController controller;
  final Function(String) onChanged;
  final FocusNode focusNode;

  const SearchAppBar({
    Key? key,
    required this.controller,
    required this.onChanged,
    required this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16).r,
        child: Row(
          children: [
            Hero(
              tag: 'button',
              child: Material(
                borderRadius: BorderRadius.circular(10).r,
                child: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    width: 48.h,
                    height: 48.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10).r,
                      color: AppColors.backgroundBackButtonColor,
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        AppVectors.icArrowLeft,
                        width: 20.w,
                        height: 16.h,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Hero(
                tag: 'searchBar',
                child: Material(
                  borderRadius: BorderRadius.circular(10).r,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10).r,
                      color: AppColors.backgroundBackButtonColor,
                    ),
                    child: TextField(
                      focusNode: focusNode,
                      controller: controller,
                      onChanged: onChanged,
                      maxLines: 1,
                      style: AppTextStyle.blackO40S13W400,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 16).r,
                        hintText: S.current.search_your_task,
                        hintStyle: AppTextStyle.blackO40S13W400,
                        prefixIconColor: AppColors.textBlack.withOpacity(0.4),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 24)
                              .r,
                          child: Opacity(
                            opacity: 0.4,
                            child: SvgPicture.asset(
                              AppVectors.icSearch,
                              width: 20.w,
                              height: 20.h,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(80.h);
}
