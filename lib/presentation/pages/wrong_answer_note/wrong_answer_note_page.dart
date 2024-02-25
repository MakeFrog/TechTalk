import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/core/constants/assets.dart';
import 'package:techtalk/core/constants/interview_type.enum.dart';
import 'package:techtalk/core/theme/extension/app_color.dart';
import 'package:techtalk/core/theme/extension/app_text_style.dart';
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
              onTap: () => routeToDetail(index),
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
      error: (error, stackTrace) => const Center(
        child: ExceptionIndicator(
          title: '오류가 발생했어요.',
          subTitle: '오답노트 목록을 불러오는데 실패했습니다',
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
