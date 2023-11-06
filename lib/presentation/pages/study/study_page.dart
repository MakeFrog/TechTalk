import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/core/theme/extension/app_color.dart';
import 'package:techtalk/core/theme/extension/app_text_style.dart';
import 'package:techtalk/presentation/pages/study/providers/question_answer_blur_provider.dart';
import 'package:techtalk/presentation/pages/study/providers/selected_study_topic_provider.dart';
import 'package:techtalk/presentation/pages/study/providers/study_question_list_provider.dart';
import 'package:techtalk/presentation/pages/study/study_event.dart';
import 'package:techtalk/presentation/pages/study/widgets/study_controller_bar.dart';
import 'package:techtalk/presentation/pages/study/widgets/study_progress_indicator.dart';
import 'package:techtalk/presentation/pages/study/widgets/study_qna_view.dart';
import 'package:techtalk/presentation/widgets/common/common.dart';
import 'package:techtalk/presentation/widgets/common/input/flat_switch.dart';

class StudyPage extends HookConsumerWidget {
  const StudyPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isInitTopic = ref.watch(selectedStudyTopicProvider) != null;

    if (!isInitTopic) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return const Scaffold(
      appBar: _AppBar(),
      body: _Body(),
    );
  }
}

class _AppBar extends StatelessWidget
    with StudyEvent
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
        builder: (context, ref, child) {
          final topicName = ref.watch(
            selectedStudyTopicProvider.select(
              (value) => value!.name,
            ),
          );

          return Text(
            topicName,
            style: AppTextStyle.headline2,
          );
        },
      ),
      actions: [
        Text(
          '답안 가리기',
          style: AppTextStyle.alert1.copyWith(
            color: AppColor.of.gray3,
          ),
        ),
        WidthBox(8.w),
        Consumer(
          builder: (context, ref, child) {
            final isBlurAnswer = ref.watch(questionAnswerBlurProvider);

            return FlatSwitch(
              value: isBlurAnswer,
              onTap: (_) => onToggleAnswerBlur(ref),
            );
          },
        ),
        WidthBox(16.w),
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
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeightBox(24.h),
              const StudyProgressIndicator(),
              HeightBox(5.h),
              const StudyQnaView(),
              const StudyControllerBar(),
            ],
          );
        },
      ),
    );
  }
}
