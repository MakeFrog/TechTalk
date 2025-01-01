part of '../../youtube_upload_page.dart';

class _UrlInputView extends HookConsumerWidget
    with YoutubeUploadState, YoutubeUploadEvent {
  const _UrlInputView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useAutomaticKeepAlive();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(16),
          Text(
            '학습을 원하는\n영상의 링크를 알려주세요',
            style: AppTextStyle.headline1,
          ),
          const Gap(12),
          Text(
            '영상 요약과 질문을 생성해 드릴게요',
            style: AppTextStyle.body1.copyWith(
              color: AppColor.of.gray4,
            ),
          ),
          const Gap(56),
          Form(
            key: formKey(ref),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: TechtalkTextField(
              controller: textEditingController(ref),
              validator: urlInputValidator,
              hintText: 'https://youtubue/blahblah',
              inputDecoration: InputDecoration(
                errorStyle: AppTextStyle.alert2.copyWith(),
              ),
            ),
          ),
          const Spacer(),
          SafeArea(
            child: Container(
              margin:
                  EdgeInsets.only(bottom: AppSize.bottomInset == 0 ? 16 : 0),
              width: double.infinity,
              child: HookBuilder(
                builder: (context) {
                  final isInputFilled =
                      useListenableSelector(textEditingController(ref), () {
                    return urlInputValidator(textEditingController(ref).text);
                  });

                  return FilledButton(
                    onPressed: isInputFilled == null
                        ? () {
                            onUrlOrIdConfirmBtnTapped(ref);
                          }
                        : null,
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
