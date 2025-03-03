import 'package:bounce_tapper/bounce_tapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:techtalk/app/style/index.dart';
import 'package:techtalk/core/constants/assets.dart';

class CardListTileButton extends StatelessWidget {
  const CardListTileButton(
      {super.key, this.onTap, required this.text, this.textColor});

  final VoidCallback? onTap;
  final String text;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return BounceTapper(
      highlightBorderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12),
        color: AppColor.of.white,
        height: 46,
        width: double.infinity,
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: AppTextStyle.title2.copyWith(
                color: textColor ?? AppColor.of.black,
              ),
            ),
            SvgPicture.asset(
              Assets.iconsNewRightArrow,
            ),
          ],
        ),
      ),
    );
  }
}
