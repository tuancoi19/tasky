import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky/common/app_images.dart';

class AppTaskPage extends StatelessWidget {
  final Widget headerWidget;
  final Widget bodyWidget;
  final double bodyHeight;

  const AppTaskPage({
    Key? key,
    required this.headerWidget,
    required this.bodyWidget,
    required this.bodyHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                AppImages.bgDetailBlueTask,
              ),
              alignment: Alignment.topCenter,
            ),
          ),
          child: headerWidget,
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: bodyHeight,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                top: const Radius.circular(30).r,
              ),
            ),
            child: bodyWidget,
          ),
        ),
      ],
    );
  }
}
