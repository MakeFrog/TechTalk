import 'dart:ui';

import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/style/index.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/chat/repositories/entities/selectable_qna_entity.dart';
import 'package:techtalk/features/topic/repositories/entities/common_qna_entity.dart';
import 'package:techtalk/presentation/pages/study/learning/learning_detail_event.dart';
import 'package:techtalk/presentation/pages/study/learning/providers/study_answer_blur_provider.dart';
import 'package:techtalk/presentation/pages/study/learning/providers/study_qna_controller.dart';
import 'package:techtalk/presentation/pages/study/learning/widgets/learning_detail_state.dart';
import 'package:techtalk/presentation/widgets/common/button/book_mark_button.dart';
import 'package:techtalk/presentation/widgets/common/divider/list_view_divider.dart';

class StudyQnaView extends ConsumerWidget
    with LearningDetailState, LearningDetailEvent {
  const StudyQnaView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ExpandablePageView.builder(
      controller: controller(ref),
      onPageChanged: (value) => onQuestionPageChanged(ref),
      itemCount: qnas(ref).length,
      itemBuilder: (context, index) => _StudyQna(
        selectableQna: qnas(ref)[index],
      ),
    );
  }
}

class _StudyQna extends HookConsumerWidget with LearningDetailEvent {
  const _StudyQna({
    super.key,
    required this.selectableQna,
  });

  final SelectableQnaEntity<CommonQnaEntity> selectableQna;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useAutomaticKeepAlive();
    return Container(
      padding: const EdgeInsets.only(bottom: 182),
      constraints: BoxConstraints(minHeight: AppSize.screenHeight - 260),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLeadingMarkedView(ref),
          const Gap(12),
          _buildQuestion(),
          const Gap(24),
          _buildAnswers(),
        ],
      ),
    );
  }

  Widget _buildLeadingMarkedView(WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: BookMarkButton(
        onTap: () => onToggleQnaItemBookmark(ref, selectableQna),
        isBookMarked: selectableQna.isSelected,
        iconWidth: 11.65,
        size: 30,
        radius: 8,
      ),
    );
  }

  Widget _buildQuestion() {
    return Padding(
      padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ) +
          const EdgeInsets.only(right: 24),
      child: Text(
        selectableQna.qna.question,
        style: AppTextStyle.headline3,
        textAlign: TextAlign.left,
      ),
    );
  }

  Widget _buildAnswers() {
    final answers = selectableQna.qna.answers;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
          color: AppColor.of.brand5, borderRadius: BorderRadius.circular(16)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: ListView.separated(
          shrinkWrap: true,
          padding: const EdgeInsets.all(16),
          physics: const NeverScrollableScrollPhysics(),
          itemCount: selectableQna.qna.answers.length,
          separatorBuilder: (_, __) => const ListViewDivider(),
          itemBuilder: (context, index) {
            final answer = answers[index];
            return Consumer(
              builder: (context, ref, child) {
                final isBlur = ref.watch(studyAnswerBlurProvider);
                return AnimatedOpacity(
                  opacity: isBlur ? 0.2 : 1,
                  duration: const Duration(milliseconds: 60),
                  child: ImageFiltered(
                    enabled: isBlur,
                    imageFilter: ImageFilter.blur(
                      sigmaX: 8,
                      sigmaY: 8,
                    ),
                    child: Text(
                      answer,
                      style: AppTextStyle.body2.copyWith(
                        color: isBlur ? AppColor.of.gray1 : AppColor.of.black,
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
