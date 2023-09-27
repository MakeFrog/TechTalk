import 'package:flutter/material.dart';

abstract class PretendardTextStyle {
  static const TextStyle baseStyle = TextStyle(
    fontFamily: 'pretendard',
    leadingDistribution: TextLeadingDistribution.even,
    letterSpacing: -0.02,
  );

  static final TextStyle highlight = baseStyle.copyWith(
    fontSize: 32,
    fontWeight: FontWeight.w800,
    height: 36 / 32,
  );
  static final TextStyle headline1 = baseStyle.copyWith(
    fontSize: 32,
    fontWeight: FontWeight.w800,
    height: 36 / 32,
  );
  static final TextStyle headline2 = baseStyle.copyWith(
    fontSize: 32,
    fontWeight: FontWeight.w800,
    height: 36 / 32,
  );
  static final TextStyle headline3 = baseStyle.copyWith(
    fontSize: 32,
    fontWeight: FontWeight.w800,
    height: 36 / 32,
  );
  static final TextStyle title1 = baseStyle.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w800,
    height: 22 / 16,
  );
  static final TextStyle title2 = baseStyle.copyWith(
    fontSize: 32,
    fontWeight: FontWeight.w800,
    height: 36 / 32,
  );
  static final TextStyle title3 = baseStyle.copyWith(
    fontSize: 32,
    fontWeight: FontWeight.w800,
    height: 36 / 32,
  );
  static final TextStyle body1 = baseStyle.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 20 / 14,
  );
  static final TextStyle body2 = baseStyle.copyWith(
    fontSize: 32,
    fontWeight: FontWeight.w800,
    height: 36 / 32,
  );
  static final TextStyle body3 = baseStyle.copyWith(
    fontSize: 32,
    fontWeight: FontWeight.w800,
    height: 36 / 32,
  );
  static final TextStyle alert1 = baseStyle.copyWith(
    fontSize: 32,
    fontWeight: FontWeight.w800,
    height: 36 / 32,
  );
  static final TextStyle alert2 = baseStyle.copyWith(
    fontSize: 32,
    fontWeight: FontWeight.w800,
    height: 36 / 32,
  );
}
