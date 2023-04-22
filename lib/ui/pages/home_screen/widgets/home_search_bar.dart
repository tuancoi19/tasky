import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasky/common/app_colors.dart';
import 'package:tasky/common/app_text_styles.dart';
import 'package:tasky/common/app_vectors.dart';
import 'package:tasky/generated/l10n.dart';

class HomeSearchBar extends StatefulWidget {
  const HomeSearchBar({Key? key}) : super(key: key);

  @override
  State<HomeSearchBar> createState() => _HomeSearchBarState();
}

class _HomeSearchBarState extends State<HomeSearchBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10).r,
        color: AppColors.backgroundBackButtonColor,
      ),
      child: TextField(
        maxLines: 1,
        style: AppTextStyle.blackO40S13W400,
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 16).r,
          hintText: S.current.search_your_task,
          hintStyle: AppTextStyle.blackO40S13W400,
          prefixIconColor: AppColors.textBlack.withOpacity(0.4),
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24).r,
            child: SvgPicture.asset(
              AppVectors.icSearch,
              width: 20.w,
              height: 20.h,
            ),
          ),
        ),
      ),
    );
  }
}
