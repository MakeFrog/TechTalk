import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:techtalk/app/style/app_color.dart';
import 'package:techtalk/app/style/app_text_style.dart';

///
/// ChatPage > QnaTabView > 문답 상세 항목을 나타내는 뷰
///
class QnaDetailBox extends StatelessWidget {
  const QnaDetailBox({
    super.key,
    this.bgColor = const Color(0xFFF7F8FC), // [AppColor.of.brand5]
    this.suffixedIconPath,
    required this.title,
    required this.descriptions,
  });

  final Color bgColor;
  final String title;
  final List<String> descriptions;
  final String? suffixedIconPath; // title 영역 우측에 배치되는 아이콘

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 8),
      width: double.infinity,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 제목 텍스트
          Row(
            children: [
              Text(
                title,
                style: AppTextStyle.body1,
              ),
              const Gap(2),
              if (suffixedIconPath != null) SvgPicture.asset(suffixedIconPath!),
            ],
          ),
          const Gap(6),
          // 내용
          ListView.separated(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: descriptions.length,
            separatorBuilder: (_, __) => Divider(
              thickness: 0.7,
              color: AppColor.of.gray1,
              height: 24,
            ),
            itemBuilder: (context, index) {
              final item = descriptions[index];
              return Text(
                item,
                style: AppTextStyle.body3,
              );
            },
          ),
        ],
      ),
    );
  }
}
