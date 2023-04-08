import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnboardingBackground extends StatelessWidget {
  final String vector;

  const OnboardingBackground({
    super.key,
    required this.vector,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      color: Colors.white,
      child: SvgPicture.asset(
        vector,
        height: 480.h,
        fit: BoxFit.fitHeight,
      ),
    );
  }
}
