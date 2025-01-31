import 'package:flutter/material.dart';
import 'package:techtalk/app/style/index.dart';
import 'package:techtalk/presentation/pages/youtube/main/youtube_main_page.dart';

///
/// [YoutubeMainPage] 상단 카테고리 슬라이드 바에서 사용되는 chip
///
class DarkTransparentChip extends StatelessWidget {
  const DarkTransparentChip({
    super.key,
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 6,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(40, 40, 49, 0.6),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: AppTextStyle.alert1.copyWith(
          color: AppColor.of.white,
        ),
      ),
    );
  }
}
