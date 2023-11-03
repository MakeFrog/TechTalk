import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class AppTextStyle {
  static TextStyle pretendardStyle(double size, double? height) => TextStyle(
        fontFamily: 'pretendard',
        leadingDistribution: TextLeadingDistribution.even,
        letterSpacing: -0.02,
        fontSize: size,
        height: height == null ? null : height / size,
      );

  static TextStyle pretendardMediumStyle(double size, double? height) =>
      pretendardStyle(size, height).copyWith(
        fontWeight: FontWeight.w500,
      );

  static TextStyle pretendardSemiBoldStyle(double size, double? height) =>
      pretendardStyle(size, height).copyWith(
        fontWeight: FontWeight.w600,
      );

  static TextStyle pretendardBoldStyle(double size, double? height) =>
      pretendardStyle(size, height).copyWith(
        fontWeight: FontWeight.w800,
      );

  static final TextStyle highlight = pretendardBoldStyle(32.sp, 36.sp);
  static final TextStyle headline1 = pretendardBoldStyle(24.sp, 33.sp);
  static final TextStyle headline2 = pretendardBoldStyle(20.sp, 27.sp);
  static final TextStyle headline3 = pretendardSemiBoldStyle(18.sp, 24.sp);
  static final TextStyle title1 = pretendardBoldStyle(16.sp, 22.sp);
  static final TextStyle title2 = pretendardSemiBoldStyle(16.sp, 22.sp);
  static final TextStyle title3 = pretendardBoldStyle(14.sp, 20.sp);
  static final TextStyle body1 = pretendardSemiBoldStyle(14.sp, 20.sp);
  static final TextStyle body2 = pretendardMediumStyle(14.sp, 20.sp);
  static final TextStyle body3 = pretendardMediumStyle(13.sp, 18.sp);
  static final TextStyle alert1 = pretendardSemiBoldStyle(12.sp, 17.sp);
  static final TextStyle alert2 = pretendardStyle(12.sp, 17.sp);
}
