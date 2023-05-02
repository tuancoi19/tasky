import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';

class AppTextStyle {
  ///Black
  static const black = TextStyle(color: AppColors.textBlack);

  //s12
  static final blackS12 = black.copyWith(fontSize: 12.sp);
  static final blackS12Bold = blackS12.copyWith(fontWeight: FontWeight.bold);
  static final blackS12ExtraBold =
      blackS12.copyWith(fontWeight: FontWeight.w800);

  //s14
  static final blackS14 = black.copyWith(fontSize: 14.sp);
  static final blackS14W400 = blackS14.copyWith(fontWeight: FontWeight.w400);
  static final blackS14Bold = blackS14.copyWith(fontWeight: FontWeight.bold);
  static final blackS14ExtraBold =
      blackS14.copyWith(fontWeight: FontWeight.w800);

  //s15
  static final blackS15 = black.copyWith(fontSize: 15.sp);
  static final blackS15W500 = blackS15.copyWith(fontWeight: FontWeight.w500);

  //s16
  static final blackS16 = black.copyWith(fontSize: 16.sp);
  static final blackS16Bold = blackS16.copyWith(fontWeight: FontWeight.bold);
  static final blackS16ExtraBold =
      blackS16.copyWith(fontWeight: FontWeight.w800);

  //s16
  static final blackS1 = black.copyWith(fontSize: 17.sp);
  static final blackS17W600 = blackS16.copyWith(fontWeight: FontWeight.w600);

  //s18
  static final blackS18 = black.copyWith(fontSize: 18.sp);
  static final blackS18Bold = blackS18.copyWith(fontWeight: FontWeight.bold);
  static final blackS18ExtraBold =
      blackS18.copyWith(fontWeight: FontWeight.w800);

  static final blackS20 = black.copyWith(fontSize: 20.sp);
  static final blackS20Bold = blackS20.copyWith(fontWeight: FontWeight.bold);

  static final blackS25 = black.copyWith(fontSize: 25.sp);
  static final blackS25Bold = blackS25.copyWith(fontWeight: FontWeight.bold);

  ///Black 80%
  static final blackO80 = TextStyle(
    color: AppColors.textBlack.withOpacity(0.8),
  );

  //s25
  static final blackO80S25 = blackO80.copyWith(fontSize: 25.sp);
  static final blackO80S25Bold =
      blackO80S25.copyWith(fontWeight: FontWeight.bold);

  //s22
  static final blackO80S22 = blackO80.copyWith(fontSize: 22.sp);
  static final blackO80S22Bold =
      blackO80S22.copyWith(fontWeight: FontWeight.bold);

  //s14
  static final blackO80S14 = blackO80.copyWith(fontSize: 14.sp);
  static final blackO80S14W400 =
      blackO80S14.copyWith(fontWeight: FontWeight.w400);

  ///Black 60%
  static final blackO60 = TextStyle(
    color: AppColors.textBlack.withOpacity(0.6),
  );
  static final blackO60S16 = blackO60.copyWith(fontSize: 16.sp);
  static final blackO60S16W400 =
      blackO60S16.copyWith(fontWeight: FontWeight.w400);

  ///Black 50%
  static final blackO50 = TextStyle(
    color: AppColors.textBlack.withOpacity(0.5),
  );
  static final blackO50S20 = blackO50.copyWith(fontSize: 20.sp);
  static final blackO50S20W600 =
      blackO50S20.copyWith(fontWeight: FontWeight.w600);

  ///Black 40%
  static final blackO40 = TextStyle(
    color: AppColors.textBlack.withOpacity(0.4),
  );
  static final blackO40S14 = blackO40.copyWith(fontSize: 14.sp);
  static final blackO40S14W400 =
      blackO40S14.copyWith(fontWeight: FontWeight.w400);

  ///Black 30%
  static final blackO30 = TextStyle(
    color: AppColors.textBlack.withOpacity(0.3),
  );
  static final blackO30S18 = blackO30.copyWith(fontSize: 18.sp);
  static final blackO30S18Bold =
      blackO30S18.copyWith(fontWeight: FontWeight.bold);

  ///Black 25%
  static final blackO25 = TextStyle(
    color: AppColors.textBlack.withOpacity(0.25),
  );

  //s14
  static final blackO25S14 = blackO25.copyWith(fontSize: 14.sp);
  static final blackO25S14w500 =
      blackO30S18.copyWith(fontWeight: FontWeight.w500);

  ///White
  static const white = TextStyle(color: Colors.white);

  //s12
  static final whiteS12 = white.copyWith(fontSize: 12.sp);
  static final whiteS12Bold = whiteS12.copyWith(fontWeight: FontWeight.bold);
  static final whiteS12ExtraBold =
      whiteS12.copyWith(fontWeight: FontWeight.w800);

  //s14
  static final whiteS14 = white.copyWith(fontSize: 14.sp);
  static final whiteS14Bold = whiteS14.copyWith(fontWeight: FontWeight.bold);
  static final whiteS14ExtraBold =
      whiteS14.copyWith(fontWeight: FontWeight.w800);

  //s16
  static final whiteS16 = white.copyWith(fontSize: 16.sp);
  static final whiteS16Bold = whiteS16.copyWith(fontWeight: FontWeight.bold);
  static final whiteS16ExtraBold =
      whiteS16.copyWith(fontWeight: FontWeight.w800);

  //s18
  static final whiteS18 = white.copyWith(fontSize: 18.sp);
  static final whiteS18Bold = whiteS18.copyWith(fontWeight: FontWeight.bold);
  static final whiteS18ExtraBold =
      whiteS18.copyWith(fontWeight: FontWeight.w800);

  ///Gray
  static const grey = TextStyle(color: Colors.grey);

  //s12
  static final greyS12 = grey.copyWith(fontSize: 12.sp);
  static final greyS12Bold = greyS12.copyWith(fontWeight: FontWeight.bold);
  static final greyS12ExtraBold = greyS12.copyWith(fontWeight: FontWeight.w800);

  //s14
  static final greyS14 = grey.copyWith(fontSize: 14.sp);
  static final greyS14Bold = greyS14.copyWith(fontWeight: FontWeight.bold);
  static final greyS14ExtraBold = greyS14.copyWith(fontWeight: FontWeight.w800);

  //s16
  static final greyS16 = grey.copyWith(fontSize: 16.sp);
  static final greyS16Bold = greyS16.copyWith(fontWeight: FontWeight.bold);
  static final greyS16ExtraBold = greyS16.copyWith(fontWeight: FontWeight.w800);

  //s18
  static final greyS18 = grey.copyWith(fontSize: 18.sp);
  static final greyS18Bold = greyS18.copyWith(fontWeight: FontWeight.bold);
  static final greyS18ExtraBold = greyS18.copyWith(fontWeight: FontWeight.w800);

  ///Tint
  static const tint = TextStyle(color: AppColors.secondary);

  //s12
  static final tintS12 = tint.copyWith(fontSize: 12.sp);
  static final tintS12Bold = tintS12.copyWith(fontWeight: FontWeight.bold);
  static final tintS12ExtraBold = tintS12.copyWith(fontWeight: FontWeight.w800);

  //s14
  static final tintS14 = tint.copyWith(fontSize: 14.sp);
  static final tintS14Bold = tintS14.copyWith(fontWeight: FontWeight.bold);
  static final tintS14ExtraBold = tintS14.copyWith(fontWeight: FontWeight.w800);

  //s16
  static final tintS16 = tint.copyWith(fontSize: 16.sp);
  static final tintS16Bold = tintS16.copyWith(fontWeight: FontWeight.bold);
  static final tintS16ExtraBold = tintS16.copyWith(fontWeight: FontWeight.w800);

  //s18
  static final tintS18 = tint.copyWith(fontSize: 18.sp);
  static final tintS18Bold = tintS18.copyWith(fontWeight: FontWeight.bold);
  static final tintS18ExtraBold = tintS18.copyWith(fontWeight: FontWeight.w800);

  ///Primary
  static const primary = TextStyle(color: AppColors.primary);

  //s14
  static final primaryS14 = primary.copyWith(fontSize: 14.sp);
  static final primaryS14W400 =
      primaryS14.copyWith(fontWeight: FontWeight.w400);

  //s25
  static final primaryS25 = primary.copyWith(fontSize: 25.sp);
  static final primaryS25Bold =
      primaryS25.copyWith(fontWeight: FontWeight.bold);

  //s26
  static final primaryS26 = primary.copyWith(fontSize: 26.sp);
  static final primaryS26Bold =
      primaryS26.copyWith(fontWeight: FontWeight.bold);

  ///Primary 50%
  static final primaryO50 = TextStyle(
    color: AppColors.primary.withOpacity(0.5),
  );

  static final primaryO50S14 = primaryO50.copyWith(fontSize: 14.sp);
  static final primaryO50S14W400 =
      primaryO50S14.copyWith(fontWeight: FontWeight.w400);

  /// red
  static const redText = TextStyle(color: Colors.red);

  //S16
  static final redTextS14 = redText.copyWith(fontSize: 14.sp);

  ///Secondary black 80%
  static final secondaryBlackO80 = TextStyle(
    color: AppColors.secondaryTextBlackColor.withOpacity(0.8),
  );
  static final secondaryBlackO80S21 = secondaryBlackO80.copyWith(fontSize: 21);
  static final secondaryBlackO80S21W600 = secondaryBlackO80S21.copyWith(
    fontWeight: FontWeight.w600,
  );

  ///Text Gray 40%
  static final grayO40 = TextStyle(
    color: AppColors.textGray.withOpacity(0.4),
  );
  static final grayO40S15 = grayO40.copyWith(fontSize: 15.sp);
  static final grayO40S15W400 =
      grayO40S15.copyWith(fontWeight: FontWeight.w400);
}
