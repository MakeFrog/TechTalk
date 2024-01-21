import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/core/constants/interview_type.enum.dart';
import 'package:techtalk/core/services/size_service.dart';
import 'package:techtalk/core/theme/extension/app_text_style.dart';
import 'package:techtalk/features/topic/topic.dart';
import 'package:techtalk/presentation/pages/interview/question_count_select/providers/selected_question_count_provider.dart';
import 'package:techtalk/presentation/pages/interview/question_count_select/question_count_select_event.dart';
import 'package:techtalk/presentation/pages/interview/question_count_select/question_count_select_state.dart';
import 'package:techtalk/presentation/widgets/base/base_page.dart';
import 'package:techtalk/presentation/widgets/common/app_bar/back_button_app_bar.dart';

class QuestionCountSelectPage extends BasePage
    with QuestionCountSelectState, QuestionCountSelectEvent {
  const QuestionCountSelectPage({
    Key? key,
    required this.type,
    required this.topics,
  }) : super(key: key);

  final InterviewType type;
  final List<TopicEntity> topics;

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    final List<int> countOptions = List.generate(
        9, (index) => index + SelectedQuestionCount.defaultPlusCount); // 4 ~ 12

    return _Scaffold(
      introText: Text(
        '면접 질문 개수를\n선택해주세요',
        style: AppTextStyle.headline1,
      ),
      questionCountPicker: CupertinoPicker.builder(
        scrollController: FixedExtentScrollController(
          initialItem: selectedQuestionCount(ref),
        ),
        useMagnifier: true,
        magnification: 1.22,
        squeeze: 1.2,
        itemExtent: 35,
        childCount: countOptions.length,
        onSelectedItemChanged: (option) =>
            onCountOptionChanged(ref, countOption: option),
        itemBuilder: (context, index) => Text(
          countOptions[index].toString(),
          style: const TextStyle(
            fontSize: 24,
          ),
        ),
      ),
    );
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, WidgetRef ref) =>
      const BackButtonAppBar();

  @override
  Widget? buildFloatingActionButton(WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      height: 56,
      child: FilledButton(
        onPressed: () => routeToChatPage(
          ref,
          type: type,
          topics: topics,
        ),
        child: const Center(
          child: Text('시작하기'),
        ),
      ),
    );
  }

  @override
  FloatingActionButtonLocation? get floatingActionButtonLocation =>
      FloatingActionButtonLocation.centerDocked;
}

class _Scaffold extends StatelessWidget {
  const _Scaffold(
      {super.key, required this.introText, required this.questionCountPicker});

  final Widget introText;
  final Widget questionCountPicker;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Gap(20),
          introText,
          Expanded(
            child: Center(
              child: SizedBox(
                height: AppSize.to.screenHeight * 0.6,
                child: questionCountPicker,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
