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
  const BubbleIndicator({
    super.key,
    required this.text,
    this.textSpans = const [],
    this.bgColor = const Color(0xFF282831),
    this.talePosition = BubbleTalePosition.bottomCenter,
  });

  final String text;
  final Color bgColor;
  final List<TextSpan> textSpans;
  final BubbleTalePosition talePosition;

  factory BubbleIndicator.withSpans(
          {required List<TextSpan> textSpans,
          BubbleTalePosition talePosition = BubbleTalePosition.bottomCenter}) =>
      BubbleIndicator(
        text: '',
        textSpans: textSpans,
        talePosition: talePosition,
      );

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
            color: bgColor,
          ),
          child: textSpans.isNotEmpty
              ? RichText(
                  text: TextSpan(
                    children: [
                      ...textSpans,
                    ],
                    style: AppTextStyle.alert1.copyWith(
                      color: AppColor.of.white,
                    ),
                  ),
                )
              : Text(
                  text,
                  style: AppTextStyle.alert1.copyWith(
                    color: AppColor.of.white,
                  ),
                ),
        ),
        Positioned(
          top: !talePosition.isBottomPosition ? -5.8 : null,
          left: talePosition.isLeft ? 12 : null,
          right: talePosition.isRight ? 12 : null,
          bottom: talePosition.isBottomPosition ? -5.8 : null,
          child: RotatedBox(
            quarterTurns: talePosition.isBottomPosition ? 0 : 2,
            child: SvgPicture.asset(
              Assets.iconsChatBubbleTale,
              colorFilter: ColorFilter.mode(
                bgColor,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

enum BubbleTalePosition {
  bottomLeft,
  bottomRight,
  bottomCenter,
  topRight,
  topLeft,
  topCenter;

  bool get isBottomPosition =>
      this == BubbleTalePosition.bottomCenter ||
      this == BubbleTalePosition.bottomLeft ||
      this == BubbleTalePosition.bottomRight;

  bool get isRight =>
      this == BubbleTalePosition.bottomRight ||
      this == BubbleTalePosition.topRight;

  bool get isLeft =>
      this == BubbleTalePosition.bottomLeft ||
      this == BubbleTalePosition.topLeft;
}
