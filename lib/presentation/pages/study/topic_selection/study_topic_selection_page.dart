import 'package:bounce_tapper/bounce_tapper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/localization/locale_keys.g.dart';
import 'package:techtalk/app/style/app_color.dart';
import 'package:techtalk/app/style/app_text_style.dart';
import 'package:techtalk/core/constants/assets.dart';
import 'package:techtalk/presentation/pages/study/topic_selection/providers/study_topic_selection_state.dart';
import 'package:techtalk/presentation/pages/study/topic_selection/study_topic_selection_event.dart';
import 'package:techtalk/presentation/widgets/base/base_page.dart';
import 'package:techtalk/presentation/widgets/common/app_bar/foldable_app_bar.dart';
import 'package:techtalk/presentation/widgets/section/study_topic_card.dart';

part 'widgets/scaffold.p.dart';

part 'widgets/wrong_answer_card.p.dart';

part 'widgets/study_topic_grid_view.p.dart';

class StudyTopicSelectionPage extends BasePage
    with StudyTopicSelectionState, StudyTopicSelectionEvent {
  const StudyTopicSelectionPage({super.key});

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    useAutomaticKeepAlive();

    return const _Scaffold(
      wrongAnswerNoteCard: _WrongAnswerNoteCard(),
      studyTopicGridView: _StudyTopicGridView(),
    );
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, WidgetRef ref) {
    return FoldableAppBar(
      title: tr(LocaleKeys.gnb_learning),
      scrollController: scrollController(ref),
      animatedPosition: 20,
    );
  }
}
