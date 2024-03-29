import 'package:flutter/material.dart';
import 'package:techtalk/app/style/index.dart';

class CardListTileButton extends StatelessWidget {
  const CardListTileButton(
      {super.key, this.onTap, required this.text, this.textColor});

  final VoidCallback? onTap;
  final String text;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: AppColor.of.white,
        height: 44,
        width: double.infinity,
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: AppTextStyle.body2.copyWith(
            color: textColor ?? AppColor.of.black,
          ),
        ),
      ),
    );
  }
}
