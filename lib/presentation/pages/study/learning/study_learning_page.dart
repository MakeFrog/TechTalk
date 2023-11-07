import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/core/theme/extension/app_color.dart';
import 'package:techtalk/core/theme/extension/app_text_style.dart';
import 'package:techtalk/presentation/pages/study/learning/providers/question_answer_blur_provider.dart';
import 'package:techtalk/presentation/pages/study/learning/providers/selected_study_topic_provider.dart';
import 'package:techtalk/presentation/pages/study/learning/providers/study_question_list_provider.dart';
import 'package:techtalk/presentation/pages/study/learning/study_learning_event.dart';
import 'package:techtalk/presentation/pages/study/learning/widgets/study_controller_bar.dart';
import 'package:techtalk/presentation/pages/study/learning/widgets/study_progress_indicator.dart';
import 'package:techtalk/presentation/pages/study/learning/widgets/study_qna_view.dart';
import 'package:techtalk/presentation/widgets/common/common.dart';
import 'package:techtalk/presentation/widgets/common/input/flat_switch.dart';

class StudyLearningPage extends StatelessWidget {
  const StudyLearningPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: _AppBar(),
      body: _Body(),
    );
  }
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
        builder: (_, ref, __) {
          final topicName = ref.watch(selectedStudyTopicProvider).name;

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
        const WidthBox(8),
        Consumer(
          builder: (context, ref, child) {
            final isBlurAnswer = ref.watch(questionAnswerBlurProvider);

            return FlatSwitch(
              value: isBlurAnswer,
              onTap: (_) => onToggleAnswerBlur(ref),
            );
          },
        ),
        const WidthBox(16),
      ],
    );
  }
}

class _Body extends HookConsumerWidget {
  const _Body({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final studyQuestionListAsync = ref.watch(studyQuestionListProvider);

    return SafeArea(
      child: studyQuestionListAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stackTrace) => Center(
          child: Text('$error'),
        ),
        data: (data) {
          return const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeightBox(24),
              StudyProgressIndicator(),
              HeightBox(5),
              StudyQnaView(),
              StudyControllerBar(),
            ],
          );
        },
      ),
    );
  }
}
