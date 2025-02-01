part of '../youtube_detail_page.dart';

class _InterviewTabView extends HookConsumerWidget
    with YoutubeDetailState, YoutubeDetailEvent {
  const _InterviewTabView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useAutomaticKeepAlive();

    return ExtendedVisibilityDetector(
      uniqueKey: Key(ContentsDetailTabType.questions.displayStr),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16) +
            const EdgeInsets.only(bottom: 162),
        children: [
          const Gap(24),
          Row(
            children: [
              const SectionTitle(
                title: '면접 질문',
                iconPath: Assets.iconsCheckNote,
              ),
              const Spacer(),
              AllButton(
                label: '전체선택',
                onTap: () {
                  onAllSelectBtnTapped(ref);
                },
              ),
            ],
          ),
          const Gap(8),
          Consumer(
            builder: (context, ref, child) {
              return AsyncSkeletonWidgetBuilder(
                asyncValue: qnasAsync(ref),
                skeletonBuilder: (_) {
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 4,
                    separatorBuilder: (_, __) => const Gap(12),
                    itemBuilder: (_, __) => SelectableQnaBox.loading(),
                  );
                },
                dataBuilder: (context, qnas) {
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (_, __) => const Gap(12),
                    itemCount: qnas.length,
                    itemBuilder: (context, index) {
                      final item = qnas.toList()[index];
                      return SelectableQnaBox(
                        index: index,
                        question: item.question,
                        isSelected: item.isSelected,
                        onTap: () {
                          onQnaBoxTapped(ref, qna: item);
                        },
                      );
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
