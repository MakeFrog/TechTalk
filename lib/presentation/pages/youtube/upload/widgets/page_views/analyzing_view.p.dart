part of '../../youtube_upload_page.dart';

class _AnalyzingView extends ConsumerWidget
    with YoutubeUploadState, YoutubeUploadEvent {
  const _AnalyzingView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(16),
          Text(
            '영상을 분석 중이에요\n잠시만 기다려 주세요',
            style: AppTextStyle.headline1,
          ),
          const Gap(100),
          targetYoutubeInfoAsync(ref).when(
            data: (info) {
              return Center(child: Text('분석중(성공)'));
            },
            error: (e, __) => Text('에러'),
            loading: () => Center(
              child: Text(
                '분석중',
              ),
            ),
          )
        ],
      ),
    );
  }
}
