import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/core/core.dart';
import 'package:techtalk/core/theme/extension/app_color.dart';
import 'package:techtalk/core/theme/extension/app_text_style.dart';
import 'package:techtalk/features/topic/entities/topic_qna_entity.dart';
import 'package:techtalk/features/wrong_answer_note/wrong_answer_note.dart';
import 'package:techtalk/presentation/pages/wrong_answer_note/providers/selected_wrong_answer_topic_provider.dart';
import 'package:techtalk/presentation/pages/wrong_answer_note/providers/wrong_answer_blur_provider.dart';
import 'package:techtalk/presentation/pages/wrong_answer_note/providers/wrong_answer_questions_provider.dart';
import 'package:techtalk/presentation/pages/wrong_answer_note/review_note_detail_event.dart';
import 'package:techtalk/presentation/widgets/base/base_page.dart';
import 'package:techtalk/presentation/widgets/common/common.dart';

class ReviewNoteDetailPage extends BasePage {
  const ReviewNoteDetailPage({
    super.key,
    required this.page,
  });

  final int page;

  @override
  Color get screenBackgroundColor => AppColor.of.white;

  @override
  PreferredSizeWidget buildAppBar(BuildContext context, WidgetRef ref) =>
      const _AppBar();

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) => _Body(
        page: page,
      );
}

class _AppBar extends StatelessWidget
    with ReviewNoteDetailEvent
    implements PreferredSizeWidget {
  const _AppBar({
    super.key,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      titleSpacing: 0,
      title: Consumer(
        builder: (_, ref, __) {
          final topicName = ref.watch(selectedWrongAnswerTopicProvider).text;

          return Text(topicName);
        },
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
          builder: (context, ref, child) {
            final isBlurAnswer = ref.watch(wrongAnswerBlurProvider);

            return FlatSwitch(
              value: isBlurAnswer,
              onTap: (_) => onToggleAnswerBlur(ref),
            );
          },
        ),
        const Gap(16),
      ],
    );
  }
}

class _Body extends HookConsumerWidget with ReviewNoteDetailEvent {
  const _Body({
    super.key,
    this.page = 0,
  });

  final int page;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageController = usePageController(initialPage: page);
    final selectedTopic = ref.watch(selectedWrongAnswerTopicProvider);
    final questions =
        ref.watch(wrongAnswerQuestionsProvider(selectedTopic.id)).requireValue;

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(24),
          Expanded(
            child: PageView.builder(
              controller: pageController,
              itemCount: questions.length,
              itemBuilder: (context, index) {
                return _StudyQna(
                  qna: WrongAnswerQnAEntity(
                    id: 'id',
                    chatRoomId: 'chatRoomId',
                    question: TopicQnaEntity(
                      id: '',
                      question: questions[index].question,
                      answers: [
                        'test',
                      ],
                    ),
                    answers: [],
                  ),
                );
              },
            ),
          ),
          HookBuilder(
            builder: (context) {
              final currentPage = useListenableSelector(pageController, () {
                try {
                  return pageController.page!.round();
                } catch (e) {
                  return page;
                }
              });

              return Padding(
                padding: EdgeInsets.symmetric(
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
                      onTap: () => pageController.previousPage(
                        duration: 400.ms,
                        curve: Curves.easeOutQuint,
                      ),
                    ),
                    Spacer(),
                    UnderLabelIconButton(
                      isActive: currentPage + 1 != questions.length,
                      label: '다음 문항',
                      icon: Assets.iconsArrowRight,
                      onTap: () => pageController.nextPage(
                        duration: 400.ms,
                        curve: Curves.easeOutQuint,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _StudyQna extends HookWidget {
  const _StudyQna({
    super.key,
    required this.qna,
  });

  final WrongAnswerQnAEntity qna;

  @override
  Widget build(BuildContext context) {
    useAutomaticKeepAlive();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildQuestion(),
        const Gap(8),
        _buildAnswers(),
      ],
    );
  }

  Widget _buildQuestion() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: Text(
        qna.question.question,
        style: AppTextStyle.title1,
      ),
    );
  }

  Widget _buildAnswers() {
    final answers = qna.question.answers;
    return Expanded(
      child: ListView.builder(
        physics: const ScrollPhysics(),
        itemCount: answers.length,
        itemBuilder: (context, index) {
          final answer = answers[index];

          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: AppColor.of.gray2,
                ),
              ),
            ),
            child: Consumer(
              builder: (context, ref, child) {
                final isBlur = ref.watch(wrongAnswerBlurProvider);

                return ImageFiltered(
                  imageFilter: ImageFilter.blur(
                    sigmaX: isBlur ? 4 : 0,
                    sigmaY: isBlur ? 4 : 0,
                  ),
                  child: Text(
                    answer,
                    style: AppTextStyle.body2,
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
