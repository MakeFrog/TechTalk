import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/core/core.dart';
import 'package:techtalk/core/theme/extension/app_color.dart';
import 'package:techtalk/core/theme/extension/app_text_style.dart';
import 'package:techtalk/presentation/pages/study/learning/study_learning_event.dart';
import 'package:techtalk/presentation/pages/study/learning/widgets/study_qna.dart';
import 'package:techtalk/presentation/providers/study/current_question_index_provider.dart';
import 'package:techtalk/presentation/providers/study/selected_study_topic_provider.dart';
import 'package:techtalk/presentation/providers/study/study_answer_blur_provider.dart';
import 'package:techtalk/presentation/providers/study/study_questions_provider.dart';
import 'package:techtalk/presentation/widgets/base/base_page.dart';
import 'package:techtalk/presentation/widgets/common/common.dart';

class StudyLearningPage extends BasePage {
  const StudyLearningPage({
    super.key,
  });

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) => const _AppBar();

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) => const _Body();
}

class _AppBar extends StatelessWidget
    with StudyLearningEvent
    implements PreferredSizeWidget {
  const _AppBar({
    super.key,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 0,
      title: Consumer(
        builder: (context, ref, child) => Text(
          ref.watch(selectedStudyTopicProvider).name,
        ),
      ),
      actions: [
        Text(
          '답안 가리기',
          style: AppTextStyle.alert1.copyWith(
            color: AppColor.of.gray3,
          ),
        ),
        const Gap(8),
        Consumer(
          builder: (context, ref, child) => FlatSwitch(
            value: ref.watch(studyAnswerBlurProvider),
            onTap: (_) => onToggleAnswerBlur(ref),
          ),
        ),
        const Gap(16),
      ],
    );
  }
}

class _Body extends HookConsumerWidget with StudyLearningEvent {
  const _Body({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageController = usePageController();
    ref.listen(currentQuestionIndexProvider, (previous, next) {
      pageController.animateToPage(
        next,
        duration: 400.ms,
        curve: Curves.easeOutQuint,
      );
    });
    final topicId = ref.watch(selectedStudyTopicProvider).id;
    final questionsAsync = ref.watch(studyQuestionsProvider(topicId));

    return questionsAsync.when(
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (error, stackTrace) => Center(
        child: Text('$error'),
      ),
      data: (questions) {
        final currentPage = ref.watch(currentQuestionIndexProvider);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(24),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${currentPage + 1}',
                    style: AppTextStyle.body3.copyWith(
                      color: AppColor.of.brand3,
                    ),
                  ),
                  Text(
                    ' / ${questions.length} 문항',
                    style: AppTextStyle.body3.copyWith(
                      color: AppColor.of.gray3,
                    ),
                  ),
                ],
              ),
            ),
            const Gap(5),
            Expanded(
              child: PageView.builder(
                controller: pageController,
                itemCount: questions.length,
                itemBuilder: (context, index) => StudyQna(
                  question: questions[index],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 18,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  UnderLabelIconButton(
                    isActive: currentPage != 0,
                    label: '이전 문항',
                    icon: Assets.iconsArrowLeft,
                    onTap: () => onTapPrevQuestion(ref),
                  ),
                  UnderLabelIconButton(
                    isActive: true,
                    label: '전체 문항',
                    icon: Assets.iconsMenu,
                    onTap: () => onTapEntireQuestion(ref),
                  ),
                  UnderLabelIconButton(
                    isActive: currentPage + 1 != questions.length,
                    label: '다음 문항',
                    icon: Assets.iconsArrowRight,
                    onTap: () => onTapNextQuestion(ref),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
