import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/localization/locale_keys.g.dart';
import 'package:techtalk/app/style/index.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/topic/topic.dart';
import 'package:techtalk/presentation/pages/home/home_event.dart';
import 'package:techtalk/presentation/pages/home/widgets/home_state.dart';
import 'package:techtalk/presentation/widgets/common/gesture/animated_scale_tap.dart';

class SingleTopicInterviewCard extends ConsumerWidget
    with HomeState, HomeEvent {
  const SingleTopicInterviewCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColor.of.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 24),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    tr(LocaleKeys.home_topicInterview),
                    style: AppTextStyle.headline2,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    routeToTopicSelectPage(
                      context,
                      type: InterviewType.singleTopic,
                    );
                  },
                  child: SvgPicture.asset(Assets.iconsRoundBlueCircle),
                ),
              ],
            ),
          ),
          if (user(ref)?.recordedTopics.isEmpty ?? true)
            Padding(
              padding: const EdgeInsets.only(bottom: 12, left: 24),
              child: Text(
                tr(LocaleKeys.home_topicInterviewDesc),
                style: AppTextStyle.body1.copyWith(
                  color: AppColor.of.gray3,
                ),
              ),
            ),
          _buildTopics(),
        ],
      ),
    );
  }

  Widget _buildTopics() {
    return Consumer(
      builder: (context, ref, child) {
        return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsets.zero,
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
    return Consumer(
      builder: (context, ref, _) {
        return AnimatedScaleTap(
          onTap: () {
            routeToChatListPage(
              context,
              type: InterviewType.singleTopic,
              topicId: topic.id,
            );
          },
          borderRadius: BorderRadius.circular(16),
          child: Container(
            color: AppColor.of.white,
            padding: const EdgeInsets.only(right: 24, left: 24),
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
                FilledButton(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
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
                  onPressed: () {},
                  child: Text(
                    tr(LocaleKeys.home_takeInterview),
                    style: AppTextStyle.body1,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
