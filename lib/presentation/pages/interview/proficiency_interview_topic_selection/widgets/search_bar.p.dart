part of '../proficiency_interview_topic_selection_page.dart';

class _SearchBar extends ConsumerWidget
    with
        ProficiencyInterviewTopicSelectionState,
        ProficiencyInterviewTopicSelectionEvent {
  const _SearchBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: BounceTapper(
        onTap: () {
          onSearchBarTapped(ref);
        },
        highlightBorderRadius: BorderRadius.circular(16),
        child: TechtalkTextField(
          enabled: false,
          showPrefixIcon: true,
          inputDecoration: InputDecoration(
            hintText: tr(LocaleKeys.interview_proficiency_search_hint),
          ),
        ),
      ),
    );
  }
}
