import 'package:bounce_tapper/bounce_tapper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/localization/locale_keys.g.dart';
import 'package:techtalk/presentation/pages/interview/created_question_list/constant/created_question_list_route_arg.dart';
import 'package:techtalk/presentation/pages/interview/created_question_list/created_question_list_event.dart';
import 'package:techtalk/presentation/pages/interview/created_question_list/created_question_list_state.dart';
import 'package:techtalk/presentation/pages/interview/created_question_list/provider/created_question_list_rout_arg_provider.dart';
import 'package:techtalk/presentation/pages/youtube/detail/widgets/selectable_qna_box.dart';
import 'package:techtalk/presentation/widgets/base/index.dart';
import 'package:techtalk/presentation/widgets/common/app_bar/back_button_app_bar.dart';
import 'package:techtalk/presentation/widgets/common/box/empty_box.dart';

///
/// 생성된 면접 질문 페이지
///
class CreatedQuestionListPage extends BasePage
    with CreatedQuestionListState, CreatedQuestionListEvent {
  const CreatedQuestionListPage(this.arg, {super.key});

  final CreatedQuestionListRouteArg arg;

  @override
  Override? get argProviderOverrides =>
      createdQuestionListRouteArgProvider.overrideWithValue(arg);

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    return createdQuestionAsync(ref).when(
      data: (qnas) {
        return ListView.separated(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 126),
          itemCount: qnas.length,
          separatorBuilder: (_, __) => const Gap(12),
          itemBuilder: (context, index) {
            final item = qnas.toList()[index];
            return SelectableQnaBox(
              index: index,
              question: item.qna.question,
              isSelected: item.isSelected,
              onTap: () {
                onQnaBoxTapped(ref, qna: item);
              },
            );
          },
        );
      },
      error: (e, _) {
        return const EmptyBox();
      },
      loading: () => const EmptyBox(),
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
        enable: hasSelectedQuestions(ref),
        onTap: () {
          onStartInterviewBtnTapped(ref);
        },
        child: SizedBox(
          width: double.infinity,
          child: FilledButton(
            onPressed: hasSelectedQuestions(ref) ? () {} : null,
            child: Text(
              tr(LocaleKeys.interview_questionCreation_startInterview),
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wrapWithSafeArea => true;

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, WidgetRef ref) =>
      BackButtonAppBar(title: tr(LocaleKeys.interview_questionCreation_title));
}
