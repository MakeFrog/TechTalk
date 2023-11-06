part of '../app_theme.dart';

abstract class _FilledButtonTheme {
  static final light = FilledButtonThemeData(
    style: FilledButton.styleFrom(
      backgroundColor: AppColor().brand3,
      disabledBackgroundColor: AppColor().brand1,
      foregroundColor: AppColor().white,
      disabledForegroundColor: AppColor().white,
      elevation: 0,
      padding: EdgeInsets.symmetric(
        horizontal: 36.w,
        vertical: 18.h,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      textStyle: AppTextStyle.title1,
    ),
  );
}
