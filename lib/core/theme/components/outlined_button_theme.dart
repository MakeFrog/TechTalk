part of '../app_theme.dart';

abstract class _OutlinedButtonTheme {
  static final light = OutlinedButtonThemeData(
    style: FilledButton.styleFrom(
      backgroundColor: AppColor().white,
      disabledBackgroundColor: AppColor().white,
      foregroundColor: AppColor().brand3,
      disabledForegroundColor: AppColor().blue1,
      elevation: 0,
      side: BorderSide(color: AppColor().gray2),
      padding: const EdgeInsets.symmetric(
        horizontal: 36,
        vertical: 18,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      textStyle: AppTextStyle.title1.copyWith(
        color: AppColor().brand3,
      ),
    ),
  );
}
