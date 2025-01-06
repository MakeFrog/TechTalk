part of '../youtube_detail_page.dart';

class _InterviewTabView extends HookConsumerWidget
    with YoutubeDetailState, YoutubeDetailEvent {
  const _InterviewTabView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useAutomaticKeepAlive();
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
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
                              Text(
                                qna.answer,
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
