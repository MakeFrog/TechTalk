import 'package:bounce_tapper/bounce_tapper.dart';
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
import 'package:techtalk/presentation/widgets/base/controller_holder.dart';

///
/// 단골 질문 인터뷰 카드
///
class CommonInterviewCard extends ConsumerWidget with HomeState, HomeEvent {
  const CommonInterviewCard({super.key});

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
          const Gap(12),
          Padding(
            padding: const EdgeInsets.only(
              left: 16,
            ),
            child: Row(
              children: [
                SvgPicture.asset(
                  Assets.iconsCommonInterviewLogo,
                ),
                const Gap(4),
                Expanded(
                  child: Text(
                    '단골 질문 면접',
                    style: AppTextStyle.headline3,
                  ),
                ),
                BounceTapper(
                  highlightColor: Colors.transparent,
                  onTap: () {
                    routeToTopicSelectPage(
                      context,
                      type: InterviewType.commonSingleTopic,
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: SvgPicture.asset(
                      Assets.iconsRoundedPlus,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // if (user(ref)?.recordedTopics.isEmpty ?? true)

          Builder(
            builder: (context) {
              if (user(ref)?.recordedTopics.isEmpty ?? true) {
                return Padding(
                  padding: const EdgeInsets.only(
                    bottom: 12,
                    left: 48,
                    right: 24,
                    top: 4,
                  ),
                  child: Text(
                    tr(LocaleKeys.home_topicInterviewDesc),
                    style: AppTextStyle.body1.copyWith(
                      color: AppColor.of.gray3,
                    ),
                  ),
                );
              } else {
                return Container(
                  padding: const EdgeInsets.only(top: 14, bottom: 0),
                  child: BounceTapper(
                    highlightBorderRadius: BorderRadius.circular(16),
                    child: Container(
                      padding: const EdgeInsets.only(
                        left: 16,
                        right: 24,
                      ),
                      height: 52,
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            Assets.iconsDice,
                          ),
                          const Gap(8),
                          Text(
                            '실전형 면접',
                            style: AppTextStyle.title2,
                          ),
                          const Spacer(),
                          SvgPicture.asset(
                            Assets.iconsNewRightArrow,
                            colorFilter: ColorFilter.mode(
                              AppColor.of.gray2,
                              BlendMode.srcIn,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
            },
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
        final passedScrollController =
            context.getController<ScrollController>();
        return BounceTapper(
          scrollController: passedScrollController,
          onTap: () {
            routeToChatListPage(
              context,
              type: InterviewType.commonSingleTopic,
              topicId: topic.id,
            );
          },
          child: Container(
            padding: const EdgeInsets.only(
              left: 16,
              right: 24,
            ),
            height: 52,
            decoration: BoxDecoration(
              // color: Colors.red,
              color: AppColor.of.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                SizedBox(
                  height: 28,
                  width: 28,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(imgSize / 2),
                    child: Image.asset(
                      topic.imageUrl!,
                      errorBuilder: (_, __, ___) => const SizedBox(),
                    ),
                  ),
                ),
                const Gap(8),
                Text(
                  topic.text,
                  style: AppTextStyle.title2,
                ),
                const Spacer(),
                SvgPicture.asset(
                  Assets.iconsNewRightArrow,
                  colorFilter: ColorFilter.mode(
                    AppColor.of.gray2,
                    BlendMode.srcIn,
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
