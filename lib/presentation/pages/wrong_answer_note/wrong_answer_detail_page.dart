import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/localization/locale_keys.g.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/app/style/index.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/topic/topic.dart';
import 'package:techtalk/presentation/pages/wrong_answer_note/providers/wrong_answer_blur_provider.dart';
import 'package:techtalk/presentation/pages/wrong_answer_note/wrong_answer_note_event.dart';
import 'package:techtalk/presentation/pages/wrong_answer_note/wrong_answer_note_state.dart';
import 'package:techtalk/presentation/widgets/base/base_page.dart';
import 'package:techtalk/presentation/widgets/common/common.dart';

part 'local_widgets/review_note_detail_app_bar.dart';
part 'local_widgets/review_note_detail_bottom_controller_bar.dart';
part 'local_widgets/review_note_qna_list_tile.dart';

class WrongAnswerDetailPage extends BasePage
    with WrongAnswerNoteState, WrongAnswerNoteEvent {
  const WrongAnswerDetailPage({
    super.key,
  });

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: PageView.builder(
        controller: pageController(ref),
        itemCount: wrongAnswersAsync(ref).requireValue.length,
        itemBuilder: (context, index) {
          return _QnaListTile(
            wrongAnswersAsync(ref).requireValue[index],
          );
        },
      ),
    );
  }

  @override
  PreferredSizeWidget buildAppBar(BuildContext context, WidgetRef ref) =>
      const _AppBar();

  @override
  FloatingActionButtonLocation? get floatingActionButtonLocation =>
      FloatingActionButtonLocation.centerDocked;

  @override
  Widget? buildFloatingActionButton(WidgetRef ref) {
    return const _BottomControllerBar();
  }
}
