part of '../../youtube_content_upload_page.dart';

class _ConfirmContentView extends ConsumerWidget
    with YoutubeContentUploadState, YoutubeContentUploadEvent {
  const _ConfirmContentView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(16),
          Text(
            '입력하신 영상이 맞나요?',
            style: AppTextStyle.headline1,
          ),
          const Gap(12),
          Text(
            '동영상을 제출하면 테크톡 유저 누구나\n내 업로드 영상을 시청할 수 있습니다.',
            style: AppTextStyle.body1.copyWith(
              color: AppColor.of.gray4,
            ),
          ),
          const Spacer(flex: 121),
          targetYoutubeInfoAsync(ref).when(
            data: (video) {
              return YoutubeContentItemView(
                thumbnailImgUrl: video.thumbnails.highResUrl,
                title: video.title,
                channelName: video.channelName,
              );
            },
            error: (_, __) => const EmptyBox(),
            loading: EmptyBox.new,
          ),
          const Spacer(flex: 136),
          SafeArea(
            child: Container(
              margin:
                  EdgeInsets.only(bottom: AppSize.bottomInset == 0 ? 16 : 0),
              width: double.infinity,
              child: HookBuilder(
                builder: (context) {
                  return FilledButton(
                    onPressed: () {
                      onStartAnalyzedBtnTapped(ref);
                    },
                    child: const Text(
                      '다음',
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
