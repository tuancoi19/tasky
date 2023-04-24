import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasky/common/app_colors.dart';
import 'package:tasky/common/app_vectors.dart';
import 'package:tasky/configs/app_configs.dart';
import 'package:tasky/ui/widgets/buttons/app_icon_button.dart';

class MainScreenBottomNavigatorBar extends StatefulWidget {
  final int currentIndex;
  final void Function(int) onPageChange;

  const MainScreenBottomNavigatorBar({
    Key? key,
    required this.currentIndex,
    required this.onPageChange,
  }) : super(key: key);

  @override
  State<MainScreenBottomNavigatorBar> createState() =>
      _MainScreenBottomNavigatorBarState();
}

class _MainScreenBottomNavigatorBarState
    extends State<MainScreenBottomNavigatorBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.h,
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 12).r,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 4),
            blurRadius: 50.r,
            color: AppColors.textBlack.withOpacity(0.05),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: buildIcon(widget.currentIndex),
      ),
    );
  }

  List<Widget> buildIcon(int currentIndex) {
    final List<Widget> list = List<Widget>.generate(
      AppConfigs.bottomNavigatorBarIconList.length,
      (index) {
        bool isChoose = currentIndex == index;
        return InkWell(
          onTap: () {
            widget.onPageChange(index);
          },
          child: AnimatedOpacity(
            opacity: isChoose ? 1.0 : 0.35,
            duration: const Duration(milliseconds: 300),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  AppConfigs.bottomNavigatorBarIconList[index],
                  width: 24.w,
                  height: 24.h,
                ),
                SizedBox(height: 4.h),
              ],
            ),
          ),
        );
      },
    );
    list.add(
      InkWell(
        onTap: () {
          //TODO: Navigate to new page
        },
        child: SizedBox(
          height: double.infinity,
          child: Stack(
            children: [
              Positioned(
                bottom: 4.h,
                left: 4.w,
                right: 4.w,
                child: Container(
                  width: 40.w,
                  height: 48.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10).r,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.4),
                        blurRadius: 4.r,
                        offset: const Offset(0, 0), // Shadow position
                      ),
                    ],
                  ),
                ),
              ),
              AppIconButton(
                width: 48.h,
                height: 48.h,
                icon: SvgPicture.asset(
                  AppVectors.icPlus,
                  width: 24.h,
                  height: 24.h,
                ),
                cornerRadius: 10,
                backgroundColor: AppColors.primary,
              ),
            ],
          ),
        ),
      ),
    );
    return list;
  }
}
