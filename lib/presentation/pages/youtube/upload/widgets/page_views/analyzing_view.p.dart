part of '../../youtube_content_upload_page.dart';

class _AnalyzingView extends ConsumerWidget with YoutubeContentUploadState {
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
          analyzedYoutubeAsync(ref).when(
            data: (info) {
              print('아랑이 : ${info.title}');
              info.captions.forEach((e) {
                log('아랑이 : ${e.toMap()}');
              });

              log('종합 : ${info.script}');

              return Text('성공');
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
