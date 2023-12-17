import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/core/services/size_service.dart';
import 'package:techtalk/core/theme/extension/app_text_style.dart';
import 'package:techtalk/presentation/pages/interview/question_count_select/question_count_select_event.dart';
import 'package:techtalk/presentation/providers/interview/selected_interview_question_count_provider.dart';
import 'package:techtalk/presentation/providers/interview/selected_interview_topic_provider.dart';
import 'package:techtalk/presentation/widgets/base/base_page.dart';
import 'package:techtalk/presentation/widgets/common/app_bar/back_button_app_bar.dart';

class QuestionCountSelectPage extends BasePage with QuestionCountSelectEvent {
  const QuestionCountSelectPage({Key? key}) : super(key: key);

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    ref.watch(selectedInterviewTopicProvider);

    final List<int> options = List.generate(18, (index) => index + 3); // 3 ~ 20
    final questionCount = ref.watch(selectedInterviewQuestionCountProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Gap(20),
          Text(
            '면접 질문 개수를\n선택해주세요',
            style: AppTextStyle.headline1,
          ),
          Expanded(
            child: Center(
              child: SizedBox(
                height: AppSize.to.screenHeight * 0.6,
                child: CupertinoPicker.builder(
                  scrollController: FixedExtentScrollController(
                    initialItem: questionCount - 3,
                  ),
                  useMagnifier: true,
                  magnification: 1.22,
                  squeeze: 1.2,
                  itemExtent: 35,
                  childCount: options.length,
                  onSelectedItemChanged: (value) => ref
                      .read(selectedInterviewQuestionCountProvider.notifier)
                      .onCountPickerChanged(value + 3),
                  itemBuilder: (context, index) => Text(
                    options[index].toString(),
                    style: const TextStyle(
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const _StartInterviewBtn(),
        ],
      ),
    );
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, WidgetRef ref) =>
      const BackButtonAppBar();
}

class _StartInterviewBtn extends ConsumerWidget with QuestionCountSelectEvent {
  const _StartInterviewBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FilledButton(
      onPressed: () => routeToChatPage(ref),
      child: const Center(
        child: Text('시작하기'),
      ),
    );
  }
}
