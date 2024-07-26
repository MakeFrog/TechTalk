import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/localization/locale_keys.g.dart';
import 'package:techtalk/presentation/pages/study/topic_selection/providers/study_topic_selection_state.dart';
import 'package:techtalk/presentation/pages/study/topic_selection/study_topic_selection_event.dart';
import 'package:techtalk/presentation/widgets/base/base_page.dart';
import 'package:techtalk/presentation/widgets/common/app_bar/foldable_app_bar.dart';
import 'package:techtalk/presentation/widgets/section/study_topic_card.dart';

class StudyTopicSelectionPage extends BasePage
    with StudyTopicSelectionState, StudyTopicSelectionEvent {
  const StudyTopicSelectionPage({super.key});

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    useAutomaticKeepAlive();

    return GridView.builder(
      controller: scrollController(ref),
      physics: const ScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 8) +
          const EdgeInsets.symmetric(horizontal: 16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 11,
        mainAxisSpacing: 12,
      ),
      itemCount: topics(ref).length,
      itemBuilder: (context, index) {
        final topic = topics(ref)[index];

        return StudyTopicCard(
          topic: topic,
          onTap: () => onTapCard(
            ref,
            topic: topic,
          ),
        );
      },
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
