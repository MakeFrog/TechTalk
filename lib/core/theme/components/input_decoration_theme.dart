part of '../app_theme.dart';

final _roundedBorderWithoutLine = OutlineInputBorder(
  borderSide: BorderSide.none,
  borderRadius: BorderRadius.circular(16),
);

abstract class _InputDecorationTheme {
  static final InputDecorationTheme light = InputDecorationTheme(
    contentPadding: const EdgeInsets.symmetric(
      vertical: 14,
      horizontal: 16,
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
