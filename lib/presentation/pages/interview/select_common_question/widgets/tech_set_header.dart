part of '../select_common_question_page.dart';

class _TechSetHeader extends ConsumerWidget with SelectCommonQuestionState {
  const _TechSetHeader({
    required this.arg,
    required this.pageController,
  });

  final SelectCommonQuestionRouteArg arg;
  final PageController pageController;

  static const height = 44.0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTopic =
        ref.watch(selectedInterviewTopicProvider(arg.topics.first));

    return Container(
      height: height,
      alignment: Alignment.bottomLeft,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Gap(16),
            ...arg.topics.asMap().entries.map((entry) {
              final index = entry.key;
              final topic = entry.value;

              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: SelectableChip(
                  isSelected: selectedTopic.id == topic.id,
                  onTap: () {
                    pageController.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  label: topic.text,
                ),
              );
            }).toList(),
            const Gap(24),
          ],
        ),
      ),
    );
  }
}
