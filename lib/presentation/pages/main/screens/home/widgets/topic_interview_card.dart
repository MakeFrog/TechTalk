import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:techtalk/core/theme/extension/app_color.dart';
import 'package:techtalk/core/theme/extension/app_text_style.dart';
import 'package:techtalk/presentation/pages/main/screens/home/home_event.dart';
import 'package:techtalk/presentation/widgets/common/common.dart';

class TopicInterviewCard extends StatelessWidget with HomeEvent {
  const TopicInterviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  '주제별 면접',
                  style: AppTextStyle.headline2,
                ),
              ),
              const WidthBox(48),
              GestureDetector(
                onTap: () => onTapNewTopicInterview(context),
                child: FaIcon(
                  FontAwesomeIcons.circlePlus,
                  color: AppColor.of.brand2,
                ),
              ),
            ],
          ),
          const HeightBox(12),
          // TODO : 면접을 하나라도 진행하면 텍스트 대신 해당 면접 표시
          Text(
            '하나의 주제를 선택해 집중 공략해 보세요!',
            style: AppTextStyle.body1.copyWith(
              color: AppColor.of.gray3,
            ),
          ),
        ],
      ),
    );
  }
}
