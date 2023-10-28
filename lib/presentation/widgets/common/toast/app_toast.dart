import 'package:flutter/material.dart';
import 'package:techtalk/core/theme/extension/app_color.dart';
import 'package:techtalk/core/theme/extension/app_text_style.dart';

final TextStyle _baseTextStyle = AppTextStyle.pretendardStyle(
  12,
  18,
);

class CustomToast extends StatelessWidget {
  const CustomToast({
    super.key,
    required this.message,
    this.backgroundColor,
    this.borderRadius,
    this.textStyle,
  });

  final String message;
  final Color? backgroundColor;
  final double? borderRadius;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 300),
      margin: const EdgeInsets.symmetric(horizontal: 28),
      padding: const EdgeInsets.symmetric(vertical: 13),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius ?? 5),
      ),
      alignment: Alignment.center,
      child: Text(
        message,
        style: textStyle ?? _baseTextStyle,
      ),
    );
  }
}

class NormalToast extends CustomToast {
  NormalToast({
    super.key,
    required super.message,
  }) : super(
          backgroundColor: AppColor.of.gray3,
          textStyle: _baseTextStyle.copyWith(
            color: Colors.white,
          ),
        );
}
