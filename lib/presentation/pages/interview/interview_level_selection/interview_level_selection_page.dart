import 'package:bounce_tapper/bounce_tapper.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/style/app_color.dart';
import 'package:techtalk/app/style/app_text_style.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/chat/repositories/enums/interview_level.enum.dart';
import 'package:techtalk/presentation/pages/interview/interview_level_selection/constant/interview_level_selection_route_arg.dart';
import 'package:techtalk/presentation/pages/interview/interview_level_selection/interview_level_selection_event.dart';
import 'package:techtalk/presentation/pages/interview/interview_level_selection/interview_level_selection_state.dart';
import 'package:techtalk/presentation/pages/interview/interview_level_selection/provider/interview_level_selection_route_arg_provider.dart';
import 'package:techtalk/presentation/widgets/base/index.dart';
import 'package:techtalk/presentation/widgets/common/app_bar/back_button_app_bar.dart';

part 'widgets/leading_view.p.dart';
part 'widgets/level_indicator_page_view.p.dart';
part 'widgets/level_selection_btns.p.dart';
part 'widgets/scaffold.p.dart';

///
/// AI 면접 > 면접 질문 난이도 선택 페이지
///
class InterviewLevelSelectionPage extends BasePage
    with InterviewLevelSelectionState, InterviewLevelSelectionEvent {
  const InterviewLevelSelectionPage(this.argument, {super.key});

  final InterviewLevelSelectionRouteArg argument;

  @override
  Override? get argProviderOverrides =>
      interviewLevelSelectionRouteArgProvider.overrideWithValue(argument);

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    return const _Scaffold(
      leadingView: _LeadingView(),
      levelIndicatorPageView: _LevelIndicatorPageView(),
      levelSelectionBts: _LevelSelectionBtns(),
    );
  }

  @override
  FloatingActionButtonLocation? get floatingActionButtonLocation =>
      FloatingActionButtonLocation.centerDocked;

  @override
  Widget? buildFloatingActionButton(WidgetRef ref) {
    return BounceTapper(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        width: double.infinity,
        child: FilledButton(
          onPressed: () {},
          child: const Text(
            '다음',
          ),
        ),
      ),
    );
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, WidgetRef ref) {
    return BackButtonAppBar(
      onBackBtnTapped: () {
        context.pop();
      },
    );
  }
}
