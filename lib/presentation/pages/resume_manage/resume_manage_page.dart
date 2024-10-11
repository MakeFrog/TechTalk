import 'package:bounce_tapper/bounce_tapper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/localization/locale_keys.g.dart';
import 'package:techtalk/app/style/index.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/presentation/pages/interview/topic_select/interview_topic_select_event.dart';
import 'package:techtalk/presentation/pages/interview/topic_select/interview_topic_select_state.dart';
import 'package:techtalk/presentation/widgets/base/base_page.dart';
import 'package:techtalk/presentation/widgets/common/app_bar/animated_app_bar.dart';

class ResumeManagePage extends BasePage with InterviewTopicSelectState {
  const ResumeManagePage({
    super.key,
  });

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView(
        controller: scrollController(ref),
        shrinkWrap: true,
        children: <Widget>[
          const Gap(20),
          Text(
            '이력서 관리 페이지',
            style: AppTextStyle.headline1,
          ),
          const Gap(24),
          //_TopicListView(),
          const Gap(52),
        ],
      ),
    );
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, WidgetRef ref) {
    return AnimatedAppBar(
      title: tr(LocaleKeys.undefined_interviewTopic),
      scrollController: scrollController(ref),
      opacityPosition: 86,
    );
  }

  @override
  Widget? buildFloatingActionButton(WidgetRef ref) {
    return const _NextButton();
  }

  @override
  FloatingActionButtonLocation? get floatingActionButtonLocation =>
      FloatingActionButtonLocation.centerDocked;
}

class _NextButton extends ConsumerWidget
    with InterviewTopicSelectState, InterviewTopicSelectEvent {
  const _NextButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: EdgeInsets.only(bottom: AppSize.bottomInset == 0 ? 16 : 0),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      height: 56,
      child: BounceTapper(
        onTap: () {},
        child: FilledButton(
          onPressed: () {},
          child: const Center(
            child: Text('이력서 등록하기'),
          ),
        ),
      ),
    );
  }
}
