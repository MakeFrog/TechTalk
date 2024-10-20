import 'package:bounce_tapper/bounce_tapper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/localization/locale_keys.g.dart';
import 'package:techtalk/app/style/index.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/presentation/pages/wrong_answer_note/providers/wrong_answer_note_scroll_controller.dart';
import 'package:techtalk/presentation/pages/wrong_answer_note/wrong_answer_note_event.dart';
import 'package:techtalk/presentation/pages/wrong_answer_note/wrong_answer_note_state.dart';
import 'package:techtalk/presentation/widgets/base/base_page.dart';
import 'package:techtalk/presentation/widgets/common/indicator/exception_indicator.dart';

part 'local_widgets/wrong_answer_empty_list_placeholder.dart';
part 'local_widgets/wrong_answer_floating_action_btn.dart';
part 'local_widgets/wrong_answer_header.dart';

class WrongAnswerNotePage extends BasePage
    with WrongAnswerNoteState, WrongAnswerNoteEvent {
  const WrongAnswerNotePage({super.key});

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    return wrongAnswersAsync(ref).when(
      data: (wrongAnswers) {
        if (wrongAnswers.isEmpty) {
          return const _EmptyListPlaceholder();
        }

        return ListView.separated(
          controller: scrollController(ref),
          padding: const EdgeInsets.only(bottom: 120),
          itemCount: wrongAnswers.length,
          separatorBuilder: (context, index) => Divider(
            height: 0.5,
            thickness: 0.5,
            color: AppColor.of.gray2,
          ),
          itemBuilder: (_, index) {
            final item = wrongAnswers[index];
            return InkWell(
              onTap: () => routeToDetail(ref, page: index),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 24,
                ),
                child: Text(
                  item.qna.question,
                  style: AppTextStyle.body1,
                ),
              ),
            );
          },
        );
      },
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (error, stackTrace) => Center(
        child: ExceptionIndicator(
          title: tr(LocaleKeys.errors_errorOccurred),
          subTitle: tr(LocaleKeys.undefined_failedToLoadWrongAnswerNotes),
        ),
      ),
    );
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, WidgetRef ref) {
    return const _WrongAnswerHeader();
  }

  @override
  Widget? buildFloatingActionButton(WidgetRef ref) {
    return const _FloatingBtn();
  }
}
