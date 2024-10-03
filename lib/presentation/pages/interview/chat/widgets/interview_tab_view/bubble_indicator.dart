import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:techtalk/app/style/app_color.dart';
import 'package:techtalk/app/style/app_text_style.dart';
import 'package:techtalk/core/constants/assets.dart';

///
/// 말풍선 인디케이터
/// [talePosition]을 값을 통해 채팅 말풍선 꼭지의 포지션을 조정할 수 있음
///

class BubbleIndicator extends StatelessWidget {
  const BubbleIndicator(
      {super.key,
      required this.text,
      this.talePosition,
      });

  final String text;
  final BubbleTalePosition? talePosition;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: AppColor.of.gray6),
          child: Text(
            text,
            style: AppTextStyle.alert1.copyWith(
              color: AppColor.of.white,
            ),
          ),
        ),
        Positioned(
          left: talePosition == BubbleTalePosition.left ? 18 : null,
          right: talePosition == BubbleTalePosition.right ? 18 : null,
          bottom: -6,
          child: SvgPicture.asset(
            Assets.iconsChatBubbleTale,
          ),
        ),
      ],
    );
  }
}

enum BubbleTalePosition {
  left,
  right,
  center;
}
