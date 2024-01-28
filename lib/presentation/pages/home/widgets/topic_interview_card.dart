import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/core/theme/extension/app_color.dart';
import 'package:techtalk/core/theme/extension/app_text_style.dart';
import 'package:techtalk/features/topic/topic.dart';
import 'package:techtalk/presentation/pages/home/home_event.dart';
import 'package:techtalk/presentation/providers/user/user_topics_provider.dart';

class TopicInterviewCard extends StatelessWidget with HomeEvent {
  const TopicInterviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: MaterialButton(
        color: AppColor.of.white,
        elevation: 0,
        padding: const EdgeInsets.all(24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        minWidth: 0,
        onPressed: onTapNewTopicInterview,
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
                const Gap(48),
                GestureDetector(
                  onTap: onTapNewTopicInterview,
                  child: FaIcon(
                    FontAwesomeIcons.circlePlus,
                    color: AppColor.of.brand2,
                    size: 24,
                  ),
                ),
              ],
            ),
            const Gap(12),
            // TODO : 면접을 하나라도 진행하면 텍스트 대신 해당 면접 표시
            Text(
              '하나의 주제를 선택해 집중 공략해 보세요!',
              style: AppTextStyle.body1.copyWith(
                color: AppColor.of.gray3,
              ),
            ),
            const Gap(12),
            _buildTopics(),
          ],
        ),
      ),
    );
  }

  Widget _buildTopics() {
    return Consumer(
      builder: (context, ref, child) {
        final userTopics = ref.watch(userTopicsProvider);
        return Column(
          children: [
            ...userTopics.where((element) => element.isAvailable).map(
                  _buildTopic,
                ),
          ],
        );
      },
    );
  }

  Widget _buildTopic(TopicEntity topic) {
    return SizedBox(
      height: 64,
      child: Row(
        children: [
          Image.asset(
            topic.imageUrl!,
            width: 40,
            height: 40,
            errorBuilder: (_, __, ___) => const SizedBox(
              width: 40,
              height: 40,
            ),
          ),
          const Gap(16),
          Text(
            topic.text,
            style: AppTextStyle.title1,
          ),
          const Spacer(),
          Consumer(
            builder: (context, ref, child) {
              return FilledButton(
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor: AppColor.of.background1,
                  foregroundColor: AppColor.of.gray4,
                ),
                onPressed: () => onTapGoToInterviewRoomListPage(
                  ref,
                  topic: topic,
                ),
                child: const Text('면접 보기'),
              );
            },
          ),
        ],
      ),
    );
  }
}
