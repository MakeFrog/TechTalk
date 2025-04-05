part of '../select_common_question_page.dart';

class _TechSetPage extends ConsumerWidget
    with SelectCommonQuestionState, SelectCommonQuestionEvent {
  const _TechSetPage({
    required this.topic,
  });

  final TopicEntity topic;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return KeepAliveView(
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 240),
        child: selectableQnas(ref, topic: topic).when(
          data: (qnas) {
            if (qnas.isEmpty) {
              return const EmptyBox();
            }

            return ListView.separated(
              key: ValueKey(qnas.length),
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16) +
                  const EdgeInsets.only(
                    top: 16,
                    bottom: 120,
                  ),
              itemCount: qnas.length,
              separatorBuilder: (_, __) => const Gap(12),
              itemBuilder: (context, index) {
                final item = qnas[index];
                return SelectableQnaBox(
                  key: ValueKey(item.qna.id),
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
          error: (_, __) => const EmptyBox(),
          loading: () => const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
