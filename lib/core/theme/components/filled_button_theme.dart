part of '../app_theme.dart';

abstract class _FilledButtonTheme {
  static final light = FilledButtonThemeData(
    style: FilledButton.styleFrom(
      backgroundColor: AppColor().brand3,
      disabledBackgroundColor: AppColor().brand1,
      foregroundColor: AppColor().white,
      disabledForegroundColor: AppColor().white,
      elevation: 0,
      padding: const EdgeInsets.symmetric(
        horizontal: 36,
        vertical: 18,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      textStyle: AppTextStyle.title1,
    ),
  );
}
