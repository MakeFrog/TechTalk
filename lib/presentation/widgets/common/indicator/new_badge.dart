import 'package:flutter/material.dart';
import 'package:techtalk/app/style/app_text_style.dart';
import 'package:techtalk/app/style/index.dart';

class NewBadge extends StatelessWidget {
  const NewBadge({super.key, this.margin});

  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 21,
      margin: margin,
      padding: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: const Color(
          0xFFFFF5BE,
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        'NEW',
        style: AppTextStyle.alert1.copyWith(
          fontWeight: FontWeight.w700,
          color: const Color(0xFFFFA100),
        ),
      ),
    );
  }
}
