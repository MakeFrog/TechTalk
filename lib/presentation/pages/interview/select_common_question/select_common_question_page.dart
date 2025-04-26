import 'package:bounce_tapper/bounce_tapper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/localization/locale_keys.g.dart';
import 'package:techtalk/features/topic/repositories/entities/topic_entity.dart';
import 'package:techtalk/presentation/pages/interview/select_common_question/constant/select_common_question_route_arg.dart';
import 'package:techtalk/presentation/pages/interview/select_common_question/provider/select_common_question_route_arg_provider.dart';

import 'package:techtalk/presentation/pages/interview/select_common_question/select_common_question_event.dart';
import 'package:techtalk/presentation/pages/interview/select_common_question/select_common_question_state.dart';
import 'package:techtalk/presentation/widgets/base/base_page.dart';
import 'package:techtalk/presentation/widgets/common/app_bar/back_button_app_bar.dart';
import 'package:techtalk/presentation/widgets/common/box/empty_box.dart';
import 'package:techtalk/presentation/pages/youtube/detail/widgets/selectable_qna_box.dart';
import 'package:techtalk/presentation/widgets/common/button/rounded_outlined_button.dart';
import 'package:techtalk/presentation/widgets/common/chip/selectable_chip.dart';
import 'package:techtalk/presentation/widgets/common/state/keep_alive_view.dart';

part 'widgets/tech_set_header.dart';
part 'widgets/tech_set_page.dart';

///
/// 공통 질문 선택 페이지
/// CREATED BY AI
///
class SelectCommonQuestionPage extends BasePage
    with SelectCommonQuestionState, SelectCommonQuestionEvent {
  SelectCommonQuestionPage({
    super.key,
    required this.arg,
  });

  final SelectCommonQuestionRouteArg arg;

  @override
  Override? get argProviderOverrides =>
      selectCommonQuestionRouteArgProvider.overrideWithValue(arg);

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    final pageController = usePageController(
      initialPage: arg.topics.indexOf(selectedTopic(ref)),
    );

    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        if (arg.topics.length == 1) return [];

        return [
          SliverAppBar(
            floating: innerBoxIsScrolled,
            elevation: 0.0,
            toolbarHeight: 44,
            automaticallyImplyLeading: false,
            titleSpacing: 0,
            title: _TechSetHeader(arg: arg, pageController: pageController),
          ),
        ];
      },
      body: PageView.builder(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        itemCount: arg.topics.length,
        onPageChanged: (index) {
          onTechSetSelected(ref, targetTopic: arg.topics[index]);
        },
        itemBuilder: (context, index) {
          return _TechSetPage(
            topic: arg.topics[index],
          );
        },
      ),
    );
  }

  @override
  FloatingActionButtonLocation? get floatingActionButtonLocation =>
      FloatingActionButtonLocation.centerDocked;

  @override
  Widget? buildFloatingActionButton(WidgetRef ref) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: BounceTapper(
        enable: selectedQnas(ref).isNotEmpty,
        onTap: () {
          onStartInterviewBtnTapped(ref);
        },
        child: SizedBox(
          width: double.infinity,
          child: FilledButton(
            onPressed: selectedQnas(ref).isNotEmpty ? () {} : null,
            child: Text(
              tr(
                LocaleKeys.interview_selectCommonQuestion_startInterview,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, WidgetRef ref) {
    return BackButtonAppBar(
      title: tr(LocaleKeys.interview_selectCommonQuestion_title),
      actions: [
        RoundedOutlinedButton(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          label: tr(LocaleKeys.interview_selectCommonQuestion_selectBookmarked),
          enabled: !isAllBookmarkedQnasSelected(ref, topic: selectedTopic(ref)),
          onTap: () => selectAllBookMarkedQnas(ref),
        ),
      ],
    );
  }

  @override
  bool get wrapWithSafeArea => true;
}
