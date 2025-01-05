part of '../youtube_detail_page.dart';

class _InterviewTabBarView extends ConsumerWidget
    with YoutubeDetailState, YoutubeDetailEvent {
  const _InterviewTabBarView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Consumer(
          builder: (context, ref, child) {
            return AsyncSkeletonWidgetBuilder(
              asyncValue: qnasAsync(ref),
              skeletonBuilder: (p0) => const Center(
                child: CircularProgressIndicator(),
              ),
              dataBuilder: (context, data) => Wrap(
                runSpacing: 20,
                children: [
                  if (data.isNotEmpty)
                    ...data
                        .map(
                          (qna) => Column(
                            children: [
                              Text(
                                qna.question,
                              ),
                              if (qna.answer != null)
                                Text(
                                  qna.answer!,
                                ),
                            ],
                          ),
                        )
                        .toList(),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
