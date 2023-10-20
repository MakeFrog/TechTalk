import 'package:flutter/material.dart';

abstract class PretendardTextStyle {
  static TextStyle baseStyle(double size, double height) => TextStyle(
        fontFamily: 'pretendard',
        leadingDistribution: TextLeadingDistribution.even,
        letterSpacing: -0.02,
        fontSize: size,
        height: height / size,
      );

  static TextStyle mediumBaseStyle(double size, double height) =>
      baseStyle(size, height).copyWith(
        fontWeight: FontWeight.w500,
      );

  static TextStyle semiBoldBaseStyle(double size, double height) =>
      baseStyle(size, height).copyWith(
        fontWeight: FontWeight.w600,
      );

  static TextStyle boldBaseStyle(double size, double height) =>
      baseStyle(size, height).copyWith(
        fontWeight: FontWeight.w800,
      );

  static final TextStyle highlight = boldBaseStyle(32, 36);
  static final TextStyle headline1 = boldBaseStyle(24, 33);
  static final TextStyle headline2 = boldBaseStyle(20, 27);
  static final TextStyle headline3 = semiBoldBaseStyle(18, 24);
  static final TextStyle title1 = boldBaseStyle(16, 22);
  static final TextStyle title2 = semiBoldBaseStyle(16, 22);
  static final TextStyle title3 = boldBaseStyle(14, 20);
  static final TextStyle body1 = semiBoldBaseStyle(14, 20);
  static final TextStyle body2 = mediumBaseStyle(14, 20);
  static final TextStyle body3 = mediumBaseStyle(13, 18);
  static final TextStyle alert1 = semiBoldBaseStyle(12, 17);
  static final TextStyle alert2 = baseStyle(12, 17);
}
