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
  static final blackS14W500 = blackS14.copyWith(fontWeight: FontWeight.w500);
  static final blackS14Bold = blackS14.copyWith(fontWeight: FontWeight.bold);
  static final blackS14ExtraBold =
      blackS14.copyWith(fontWeight: FontWeight.w800);

  //s15
  static final blackS15 = black.copyWith(fontSize: 15.sp);
  static final blackS15W500 = blackS15.copyWith(fontWeight: FontWeight.w500);

  //s16
  static final blackS16 = black.copyWith(fontSize: 16.sp);
  static final blackS16W400 = blackS16.copyWith(fontWeight: FontWeight.w400);
  static final blackS16Bold = blackS16.copyWith(fontWeight: FontWeight.bold);
  static final blackS16ExtraBold =
      blackS16.copyWith(fontWeight: FontWeight.w800);

  //s17
  static final blackS17 = black.copyWith(fontSize: 17.sp);
  static final blackS17W600 = blackS17.copyWith(fontWeight: FontWeight.w600);

  //s16
  static final blackS1 = black.copyWith(fontSize: 17.sp);

  //s18
  static final blackS18 = black.copyWith(fontSize: 18.sp);
  static final blackS18Bold = blackS18.copyWith(fontWeight: FontWeight.bold);
  static final blackS18ExtraBold =
      blackS18.copyWith(fontWeight: FontWeight.w800);

  static final blackS20 = black.copyWith(fontSize: 20.sp);
  static final blackS20Bold = blackS20.copyWith(fontWeight: FontWeight.bold);
  static final blackS20W500 = blackS20.copyWith(fontWeight: FontWeight.w500);

  static final blackS25 = black.copyWith(fontSize: 25.sp);
  static final blackS25Bold = blackS25.copyWith(fontWeight: FontWeight.bold);

  ///Black 90%
  static final blackO90 = TextStyle(
    color: AppColors.textBlack.withOpacity(0.9),
  );

  //s15
  static final blackO90S15 = blackO90.copyWith(fontSize: 15.sp);
  static final blackO90S15W500 =
      blackO90S15.copyWith(fontWeight: FontWeight.w500);

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
  static final blackO80S14W500 =
      blackO80S14.copyWith(fontWeight: FontWeight.w500);

  ///Black 60%
  static final blackO60 = TextStyle(
    color: AppColors.textBlack.withOpacity(0.6),
  );
  static final blackO60S16 = blackO60.copyWith(fontSize: 16.sp);
  static final blackO60S16W400 =
      blackO60S16.copyWith(fontWeight: FontWeight.w400);

  static final blackO60S14 = blackO60.copyWith(fontSize: 14.sp);
  static final blackO60S14W500 =
      blackO60S14.copyWith(fontWeight: FontWeight.w500);
  static final blackO60S14Bold =
      blackO60S14.copyWith(fontWeight: FontWeight.bold);

  ///Black 50%
  static final blackO50 = TextStyle(
    color: AppColors.textBlack.withOpacity(0.5),
  );
  static final blackO50S20 = blackO50.copyWith(fontSize: 20.sp);
  static final blackO50S20W600 =
      blackO50S20.copyWith(fontWeight: FontWeight.w600);

  static final blackO50S15 = blackO50.copyWith(fontSize: 15.sp);
  static final blackO50S15W500 =
      blackO50S15.copyWith(fontWeight: FontWeight.w500);

  static final blackO50S14 = blackO50.copyWith(fontSize: 14.sp);
  static final blackO50S14W500 =
      blackO50S14.copyWith(fontWeight: FontWeight.w500);

  static final blackO50S13 = blackO50.copyWith(fontSize: 13.sp);
  static final blackO50S13W400 =
      blackO50S13.copyWith(fontWeight: FontWeight.w400);

  ///Black 40%
  static final blackO40 = TextStyle(
    color: AppColors.textBlack.withOpacity(0.4),
  );
  static final blackO40S14 = blackO40.copyWith(fontSize: 14.sp);
  static final blackO40S14W400 =
      blackO40S14.copyWith(fontWeight: FontWeight.w400);

  static final blackO40S13 = blackO40.copyWith(fontSize: 13.sp);
  static final blackO40S13W400 =
      blackO40S13.copyWith(fontWeight: FontWeight.w400);

  ///Black 30%
  static final blackO30 = TextStyle(
    color: AppColors.textBlack.withOpacity(0.3),
  );
  static final blackO30S18 = blackO30.copyWith(fontSize: 18.sp);
  static final blackO30S18Bold =
      blackO30S18.copyWith(fontWeight: FontWeight.bold);

  static final blackO30S14 = blackO30.copyWith(fontSize: 14.sp);
  static final blackO30S14W500 =
      blackO30S14.copyWith(fontWeight: FontWeight.w500);

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

  static final whiteS15 = white.copyWith(fontSize: 15.sp);
  static final whiteS15W500 = whiteS14.copyWith(fontWeight: FontWeight.w500);

  //s16
  static final whiteS16 = white.copyWith(fontSize: 16.sp);
  static final whiteS16W600 = whiteS16.copyWith(fontWeight: FontWeight.w600);
  static final whiteS16Bold = whiteS16.copyWith(fontWeight: FontWeight.bold);
  static final whiteS16ExtraBold =
      whiteS16.copyWith(fontWeight: FontWeight.w800);

  //s18
  static final whiteS18 = white.copyWith(fontSize: 18.sp);
  static final whiteS18Bold = whiteS18.copyWith(fontWeight: FontWeight.bold);
  static final whiteS18ExtraBold =
      whiteS18.copyWith(fontWeight: FontWeight.w800);

  //s23
  static final whiteS23 = white.copyWith(fontSize: 23.sp);
  static final whiteS23W500 = whiteS23.copyWith(fontWeight: FontWeight.w500);

  //s26
  static final whiteS26 = white.copyWith(fontSize: 26.sp);
  static final whiteS26Bold = whiteS26.copyWith(fontWeight: FontWeight.bold);

  ///White O90
  static final whiteO90 = TextStyle(color: Colors.white.withOpacity(0.9));

  //s23
  static final whiteO90S23 = whiteO90.copyWith(fontSize: 23.sp);
  static final whiteO90S23W500 =
      whiteO90S23.copyWith(fontWeight: FontWeight.w500);

  ///White O80
  static final whiteO80 = TextStyle(color: Colors.white.withOpacity(0.8));

  //s13
  static final whiteO80S13 = whiteO80.copyWith(fontSize: 13.sp);
  static final whiteO80S13W400 =
      whiteO80S13.copyWith(fontWeight: FontWeight.w400);

  //s14
  static final whiteO80S14 = whiteO80.copyWith(fontSize: 14.sp);
  static final whiteO80S14W500 =
      whiteO80S14.copyWith(fontWeight: FontWeight.w500);

  ///White O60
  static final whiteO60 = TextStyle(color: Colors.white.withOpacity(0.6));

  //s13
  static final whiteO60S13 = whiteO60.copyWith(fontSize: 13.sp);
  static final whiteO60S13Bold =
      whiteO60S13.copyWith(fontWeight: FontWeight.bold);

  //s14
  static final whiteO60S14 = whiteO60.copyWith(fontSize: 14.sp);
  static final whiteO60S14W500 =
      whiteO60S14.copyWith(fontWeight: FontWeight.w500);

  ///White O50
  static final whiteO50 = TextStyle(color: Colors.white.withOpacity(0.5));

  static final whiteO50S10 = whiteO50.copyWith(fontSize: 10.sp);
  static final whiteO50S10W500 =
      whiteO50S10.copyWith(fontWeight: FontWeight.w500);

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

  //s18
  static final primaryS16 = primary.copyWith(fontSize: 16.sp);
  static final primaryS16W400 =
      primaryS16.copyWith(fontWeight: FontWeight.w400);

  //s18
  static final primaryS18 = primary.copyWith(fontSize: 18.sp);
  static final primaryS18Bold =
      primaryS18.copyWith(fontWeight: FontWeight.bold);

  //s25
  static final primaryS25 = primary.copyWith(fontSize: 25.sp);
  static final primaryS25Bold =
      primaryS25.copyWith(fontWeight: FontWeight.bold);

  //s26
  static final primaryS26 = primary.copyWith(fontSize: 26.sp);
  static final primaryS26Bold =
      primaryS26.copyWith(fontWeight: FontWeight.bold);

  //s15
  static final primaryS15 = primary.copyWith(fontSize: 15.sp);
  static final primaryS15W500 =
      primaryS15.copyWith(fontWeight: FontWeight.w500);

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
  static final secondaryBlackO80S21 =
      secondaryBlackO80.copyWith(fontSize: 21.sp);
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
