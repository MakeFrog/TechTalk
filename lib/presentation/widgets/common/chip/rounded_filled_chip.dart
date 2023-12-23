import 'package:flutter/material.dart';
import 'package:techtalk/core/theme/extension/app_color.dart';
import 'package:techtalk/core/theme/extension/app_text_style.dart';

///
/// 텍스트 카드뷰
/// 텍스트 크기에 맞게 카드뷰의 크기가 설정됨
///

class RoundedFilledChip extends StatelessWidget {
  const RoundedFilledChip({Key? key, required this.text, this.margin})
      : super(key: key);

  final String text;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      margin: margin ?? EdgeInsets.zero,
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: AppColor.of.gray1,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: AppTextStyle.body1.copyWith(
          color: AppColor.of.gray5,
        ),
      ),
    );
  }
}
