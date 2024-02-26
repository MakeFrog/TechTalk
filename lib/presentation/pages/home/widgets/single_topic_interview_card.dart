import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/core/constants/assets.dart';
import 'package:techtalk/core/constants/interview_type.enum.dart';
import 'package:techtalk/core/theme/extension/app_color.dart';
import 'package:techtalk/core/theme/extension/app_text_style.dart';
import 'package:techtalk/features/topic/topic.dart';
import 'package:techtalk/presentation/pages/home/home_event.dart';
import 'package:techtalk/presentation/pages/home/widgets/home_state.dart';

class SingleTopicInterviewCard extends ConsumerWidget
    with HomeState, HomeEvent {
  const SingleTopicInterviewCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Material(
      clipBehavior: Clip.antiAlias,
      color: AppColor.of.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: () {
          routeToTopicSelectPage(context, type: InterviewType.singleTopic);
        },
        child: Container(
          padding: const EdgeInsets.fromLTRB(24, 12, 0, 12),
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
                  SvgPicture.asset(Assets.iconsRoundBlueCircle),
                ],
              ),
              if (user(ref)?.recordedTopics.isEmpty ?? true)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Text(
                    '하나의 주제를 선택해 집중 공략해 보세요!',
                    style: AppTextStyle.body1.copyWith(
                      color: AppColor.of.gray3,
                    ),
                  ),
                ),
              _buildTopics(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopics() {
    return Consumer(
      builder: (context, ref, child) {
        return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: targetedTopics(ref).length,
          itemBuilder: (context, index) {
            final topic = targetedTopics(ref)[index];
            return _buildTopic(topic);
          },
        );
      },
    );
  }

  Widget _buildTopic(TopicEntity topic) {
    const double imgSize = 40;
    return Container(
      margin: const EdgeInsets.only(right: 24),
      height: 64,
      child: Row(
        children: [
          SizedBox(
            height: 40,
            width: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(imgSize / 2),
              child: Image.asset(
                topic.imageUrl!,
                errorBuilder: (_, __, ___) => const SizedBox(),
              ),
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
                onPressed: () {
                  routeToChatListPage(context,
                      type: InterviewType.singleTopic, topicId: topic.id);
                },
                child: Text(
                  '면접 보기',
                  style: AppTextStyle.body1,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
