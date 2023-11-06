part of '../app_theme.dart';

final _roundedBorderWithoutLine = OutlineInputBorder(
  borderSide: BorderSide.none,
  borderRadius: BorderRadius.circular(16.r),
);

abstract class _InputDecorationTheme {
  static final InputDecorationTheme light = InputDecorationTheme(
    contentPadding: EdgeInsets.symmetric(
      vertical: 14.h,
      horizontal: 16.w,
    ),
    filled: true,
    fillColor: AppColor().background1,
    border: _roundedBorderWithoutLine,
    errorBorder: _roundedBorderWithoutLine,
    focusedBorder: _roundedBorderWithoutLine,
    focusedErrorBorder: _roundedBorderWithoutLine,
    hintStyle: AppTextStyle.body1.copyWith(
      color: AppColor().gray3,
    ),
  );
}
