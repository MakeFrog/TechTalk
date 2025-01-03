part of '../../youtube_upload_page.dart';

class _AnalyzingContentView extends ConsumerWidget
    with YoutubeUploadState, YoutubeUploadEvent {
  const _AnalyzingContentView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: analyzedYoutubeFetcherAsync(ref).when(
            data: (_) => Text(
              '분석 진행중(완료)',
            ),
            error: (e, __) => Text(
              '오류',
            ),
            loading: () => Text(
              '분석 진행중',
            ),
          ),
        ),
      ],
    );
  }
}
