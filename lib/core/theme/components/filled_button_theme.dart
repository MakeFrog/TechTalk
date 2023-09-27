part of '../app_theme.dart';

abstract class _FilledButtonTheme {
  static final light = FilledButtonThemeData(
    style: FilledButton.styleFrom(
      backgroundColor: AppColor().brand3,
      foregroundColor: AppColor().white,
      elevation: 0,
      padding: const EdgeInsets.symmetric(
        horizontal: 36,
        vertical: 18,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      textStyle: PretendardTextStyle.baseStyle.copyWith(
        fontSize: 16,
        height: 22 / 16,
        fontWeight: FontWeight.w800,
      ),
    ),
  );
}
