import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/core/theme/extension/app_color.dart';
import 'package:techtalk/core/theme/extension/app_text_style.dart';
import 'package:techtalk/presentation/pages/home/home_event.dart';
import 'package:techtalk/presentation/providers/user/user_interview_topics_provider.dart';

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
                Gap(48),
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
            Gap(12),
            // TODO : 면접을 하나라도 진행하면 텍스트 대신 해당 면접 표시
            Text(
              '하나의 주제를 선택해 집중 공략해 보세요!',
              style: AppTextStyle.body1.copyWith(
                color: AppColor.of.gray3,
              ),
            ),
            const Gap(12),
            const _InterviewTopicColum(),
          ],
        ),
      ),
    );
  }
}

class _InterviewTopicColum extends ConsumerWidget with HomeEvent {
  const _InterviewTopicColum({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userTopicsAsync = ref.watch(userInterviewTopicsProvider);

    return userTopicsAsync.when(
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (error, stackTrace) => Center(
        child: Text('$error'),
      ),
      data: (data) {
        return Column(
          children: [
            ...data.map(
              (e) => SizedBox(
                height: 64,
                child: Row(
                  children: [
                    Image.asset(
                      e.imageUrl!,
                      width: 40,
                      height: 40,
                      errorBuilder: (context, error, stackTrace) =>
                          const SizedBox(
                        width: 40,
                        height: 40,
                      ),
                    ),
                    const Gap(16),
                    Text(
                      e.text,
                      style: AppTextStyle.title1,
                    ),
                    const Spacer(),
                    FilledButton(
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
                      onPressed: () => onTapGoToInterviewRoomPage(e),
                      child: const Text('면접 보기'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
