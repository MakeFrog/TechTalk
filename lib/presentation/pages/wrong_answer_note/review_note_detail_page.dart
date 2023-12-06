import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/core/core.dart';
import 'package:techtalk/core/theme/extension/app_color.dart';
import 'package:techtalk/core/theme/extension/app_text_style.dart';
import 'package:techtalk/features/chat/repositories/entities/interview_qna_entity.dart';
import 'package:techtalk/presentation/pages/wrong_answer_note/providers/detail_page_controller_provider.dart';
import 'package:techtalk/presentation/pages/wrong_answer_note/providers/question_answer_blur_provider.dart';
import 'package:techtalk/presentation/pages/wrong_answer_note/providers/review_question_list_provider.dart';
import 'package:techtalk/presentation/pages/wrong_answer_note/providers/selected_review_note_topic_provider.dart';
import 'package:techtalk/presentation/pages/wrong_answer_note/review_note_detail_event.dart';
import 'package:techtalk/presentation/widgets/common/common.dart';

class ReviewNoteDetailPage extends StatelessWidget {
  const ReviewNoteDetailPage({
    super.key,
    required this.page,
  });

  final int page;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const _AppBar(),
      body: _Body(
        page: page,
      ),
    );
  }
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
          final topicName =
              ref.watch(selectedReviewNoteTopicProvider).requireValue.text;

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
            final isBlurAnswer = ref.watch(questionAnswerBlurProvider);

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

class _Body extends ConsumerWidget with ReviewNoteDetailEvent {
  const _Body({
    super.key,
    this.page = 0,
  });

  final int page;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageController = ref.watch(detailPageControllerProvider);
    final questions = ref.watch(reviewQuestionListProvider).requireValue;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(detailPageControllerProvider.notifier).initPage = page;
    });

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(24),
          Expanded(
            child: PageView.builder(
              controller: pageController,
              itemCount: questions.length,
              itemBuilder: (context, index) => _StudyQna(
                question: questions[index],
              ),
            ),
          ),
          HookBuilder(
            builder: (context) {
              final currentPage = useListenableSelector(pageController, () {
                try {
                  return pageController.page!.round();
                } catch (e) {
                  return 0;
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
                    _ControllerButton(
                      isActive: currentPage != 0,
                      label: '이전 문항',
                      icon: Assets.iconsArrowLeft,
                      onTap: () => onTapPrevQuestion(ref),
                    ),
                    Spacer(),
                    _ControllerButton(
                      isActive: currentPage + 1 != questions.length,
                      label: '다음 문항',
                      icon: Assets.iconsArrowRight,
                      onTap: () => onTapNextQuestion(ref),
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

class _StudyQna extends StatelessWidget {
  const _StudyQna({
    super.key,
    required this.question,
  });

  final InterviewQnAEntity question;

  @override
  Widget build(BuildContext context) {
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
        question.question,
        style: AppTextStyle.title1,
      ),
    );
  }

  Widget _buildAnswers() {
    final answers = question.idealAnswer!;
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
                final isBlur = ref.watch(questionAnswerBlurProvider);

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

class _ControllerButton extends StatelessWidget {
  const _ControllerButton({
    super.key,
    required this.onTap,
    required this.isActive,
    required this.icon,
    required this.label,
  });

  final VoidCallback onTap;
  final bool isActive;
  final String icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: isActive ? onTap : null,
      child: Column(
        children: [
          SvgPicture.asset(
            icon,
            width: 24,
            height: 24,
            colorFilter: isActive
                ? null
                : ColorFilter.mode(
                    AppColor.of.gray2,
                    BlendMode.srcATop,
                  ),
          ),
          Gap(12),
          Text(
            label,
            style: AppTextStyle.alert1.copyWith(
              color: isActive ? AppColor.of.gray4 : AppColor.of.gray2,
            ),
          ),
        ],
      ),
    );
  }
}
