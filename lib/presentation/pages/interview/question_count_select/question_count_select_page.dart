import 'package:bounce_tapper/bounce_tapper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/localization/locale_keys.g.dart';
import 'package:techtalk/app/style/index.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/presentation/pages/interview/question_count_select/providers/selected_question_count_provider.dart';
import 'package:techtalk/presentation/pages/interview/question_count_select/question_count_select_event.dart';
import 'package:techtalk/presentation/pages/interview/question_count_select/question_count_select_state.dart';
import 'package:techtalk/presentation/widgets/base/base_page.dart';
import 'package:techtalk/presentation/widgets/common/app_bar/back_button_app_bar.dart';

class QuestionCountSelectPage extends BasePage
    with QuestionCountSelectState, QuestionCountSelectEvent {
  const QuestionCountSelectPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    final List<int> countOptions = List.generate(
        9, (index) => index + SelectedQuestionCount.defaultPlusCount); // 4 ~ 12

    return _Scaffold(
      introText: Text(
        tr(LocaleKeys.interview_chooseNumberOfQuestions),
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
  bool get wrapWithSafeArea => false;

  @override
  Widget? buildFloatingActionButton(WidgetRef ref) {
    return Container(
      margin: EdgeInsets.only(bottom: AppSize.bottomInset == 0 ? 16 : 0),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      height: 56,
      child: BounceTapper(
        onTap: () {
          routeToChatPage(
            ref,
            type: arg(ref).type,
            topics: arg(ref).topics,
          );
        },
        child: FilledButton(
          onPressed: () {},
          child: Center(
            child: Text(tr(LocaleKeys.common_start)),
          ),
        ),
      ),
    );
  }

  @override
  bool get setBottomSafeArea => false;

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
                height: AppSize.screenHeight * 0.6,
                child: questionCountPicker,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
