import 'package:bounce_tapper/bounce_tapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/style/index.dart';
import 'package:techtalk/features/tech_set/repositories/entities/tech_set_entity.dart';
import 'package:techtalk/presentation/pages/interview/proficiency_interview_topic_selection/constant/proficiency_interview_topic_selection_route_arg.dart';
import 'package:techtalk/presentation/pages/interview/proficiency_interview_topic_selection/proficiency_interview_topic_selection_event.dart';
import 'package:techtalk/presentation/pages/interview/proficiency_interview_topic_selection/proficiency_interview_topic_selection_state.dart';
import 'package:techtalk/presentation/pages/interview/proficiency_interview_topic_selection/provider/proficiency_interview_topic_selection_route_arg_provide.dart';
import 'package:techtalk/presentation/widgets/base/controller_holder.dart';
import 'package:techtalk/presentation/widgets/base/index.dart';
import 'package:techtalk/presentation/widgets/common/chip/tech_set_filled_chip.dart';
import 'package:techtalk/presentation/widgets/common/common.dart';
import 'package:techtalk/presentation/widgets/common/list_view/tech_set_list_view.dart';

part 'widgets/leading_view.p.dart';
part 'widgets/recommended_tech_set_view.p.dart';
part 'widgets/scaffold.p.dart';
part 'widgets/search_bar.p.dart';
part 'widgets/selected_tech_set_list_view.p.dart';

class ProficiencyInterviewTopicSelectionPage extends BasePage
    with
        ProficiencyInterviewTopicSelectionState,
        ProficiencyInterviewTopicSelectionEvent {
  const ProficiencyInterviewTopicSelectionPage(this.argument, {super.key});

  final ProficiencyInterviewTopicSelectionRouteArgument argument;

  @override
  Override? get argProviderOverrides =>
      proficiencyInterviewTopicSelectionRouteArgProvider
          .overrideWithValue(argument);

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    final scrollController = useScrollController();
    return ControllerHolder<ScrollController>(
      controller: scrollController,
      child: const _Scaffold(
        leadingView: _LeadingView(),
        searchBar: _SearchBar(),
        selectedTechSets: _SelectedTechSetListView(),
        recommendedTechSets: _RecommendedTechSetsView(),
        bottomFixedBtn: SizedBox(),
      ),
    );
  }

  @override
  FloatingActionButtonLocation? get floatingActionButtonLocation =>
      FloatingActionButtonLocation.centerDocked;

  @override
  Widget? buildFloatingActionButton(WidgetRef ref) {
    final hasSelection = selectedTechSets(ref).isNotEmpty;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: BounceTapper(
        enable: hasSelection,
        onTap: () async {
          await onConfirmBtnTapped(ref);
        },
        child: SizedBox(
          width: double.infinity,
          child: FilledButton(
            onPressed: hasSelection ? () {} : null,
            child: const Text('다음'),
          ),
        ),
      ),
    );
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, WidgetRef ref) {
    return const BackButtonAppBar();
  }

  @override
  bool get wrapWithSafeArea => false;
}
