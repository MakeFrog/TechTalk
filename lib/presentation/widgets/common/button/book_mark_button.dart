import 'package:bounce_tapper/bounce_tapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:techtalk/app/style/app_color.dart';
import 'package:techtalk/core/constants/assets.dart';

class BookMarkButton extends StatelessWidget {
  const BookMarkButton({
    super.key,
    required this.onTap,
    required this.isBookMarked,
    this.size = 56,
    this.iconWidth = 20,
    this.radius = 16,
  });

  final VoidCallback onTap;
  final bool isBookMarked;
  final double radius;
  final double size;
  final double iconWidth;

  @override
  Widget build(BuildContext context) {
    return BounceTapper(
      onTap: onTap,
      child: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          color: AppColor.of.blue1,
          borderRadius: BorderRadius.circular(
            radius,
          ),
        ),
        child: Center(
          child: SvgPicture.asset(
            Assets.iconsBoomark,
            width: iconWidth,
            fit: BoxFit.fitWidth,
            colorFilter: ColorFilter.mode(
              isBookMarked ? AppColor.of.brand3 : AppColor.of.white,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }
}
