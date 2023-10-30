import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/core/theme/extension/app_color.dart';
import 'package:techtalk/core/theme/extension/app_text_style.dart';
import 'package:techtalk/features/interview/interview.dart';
import 'package:techtalk/presentation/pages/main/tab_views/study/providers/topic_list_provider.dart';
import 'package:techtalk/presentation/pages/study/providers/selected_study_topic_provider.dart';
import 'package:techtalk/presentation/pages/study/study_event.dart';
import 'package:techtalk/presentation/pages/study/widgets/study_controller_bar.dart';
import 'package:techtalk/presentation/pages/study/widgets/study_progress_indicator.dart';
import 'package:techtalk/presentation/pages/study/widgets/study_qna_view.dart';
import 'package:techtalk/presentation/widgets/common/common.dart';

class StudyPage extends HookConsumerWidget with StudyEvent {
  const StudyPage({
    super.key,
    required this.topicName,
  });

  final String topicName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final topicList = ref.watch(topicListProvider).requireValue.values;
    InterviewTopicEntity? topic;
    for (final topics in topicList) {
      final findTopic = topics.firstWhereOrNull(
        (element) => element.name == topicName,
      );

      if (findTopic != null) {
        topic = findTopic;
        break;
      }
    }

    if (topic == null) {
      return const Scaffold(
        body: Center(
          child: Text('주제 선택 오류'),
        ),
      );
    }

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(selectedStudyTopicProvider.notifier).topic = topic!;
    });

    final isBlurAnswer = useState(false);

    return Scaffold(
      appBar: _AppBar(
        isBlurAnswer: isBlurAnswer,
      ),
      body: _Body(
        isBlurAnswer: isBlurAnswer.value,
      ),
    );
  }
}

class _AppBar extends HookConsumerWidget
    with StudyEvent
    implements PreferredSizeWidget {
  const _AppBar({
    super.key,
    required this.isBlurAnswer,
  });

  final ValueNotifier<bool> isBlurAnswer;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final topic = ref.watch(selectedStudyTopicProvider);

    return AppBar(
      titleSpacing: 0,
      title: Text(
        topic.name,
        style: AppTextStyle.headline2,
      ),
      actions: [
        Text(
          '답안 가리기',
          style: AppTextStyle.alert1.copyWith(
            color: AppColor.of.gray3,
          ),
        ),
        WidthBox(8.w),
        FlatSwitch(
          value: isBlurAnswer.value,
          onTap: (value) => onToggleBlurAnswer(
            value,
            isBlurAnswer,
          ),
        ),
        WidthBox(16.w),
      ],
    );
  }
}

class _Body extends HookWidget {
  const _Body({
    super.key,
    required this.isBlurAnswer,
  });

  final bool isBlurAnswer;

  @override
  Widget build(BuildContext context) {
    final questionPageController = usePageController();
    final currentQuestionIndex = useState(0);

    const itemCount = 10;

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeightBox(24.h),
          StudyProgressIndicator(
            current: currentQuestionIndex.value + 1,
            maxCount: itemCount,
          ),
          HeightBox(5.h),
          StudyQnaView(
            controller: questionPageController,
            itemCount: itemCount,
            isBlur: isBlurAnswer,
            onChangeQuestion: (value) {
              currentQuestionIndex.value = value;
            },
          ),
          StudyControllerBar(
            controller: questionPageController,
            currentQnaIndex: currentQuestionIndex.value,
            itemCount: itemCount,
          ),
        ],
      ),
    );
  }
}
