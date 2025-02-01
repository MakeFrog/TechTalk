import 'package:bounce_tapper/bounce_tapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/style/index.dart';
import 'package:techtalk/presentation/pages/youtube/upload/submitted_youtube_confirm/provider/submitted_youtube_confirm_arg_provider.dart';
import 'package:techtalk/presentation/pages/youtube/upload/submitted_youtube_confirm/submitted_youtube_confirm_event.dart';
import 'package:techtalk/presentation/pages/youtube/upload/submitted_youtube_confirm/submitted_youtube_confirm_state.dart';
import 'package:techtalk/presentation/widgets/base/base_page.dart';
import 'package:techtalk/presentation/widgets/common/app_bar/back_button_app_bar.dart';
import 'package:techtalk/presentation/widgets/common/item/youtube_content_item_view.dart';

class SubmittedYoutubeConfirmPage extends BasePage
    with SubmittedYoutubeConfirmState, SubmittedYoutubeConfirmEvent {
  const SubmittedYoutubeConfirmPage({
    super.key,
    required this.arg,
  });

  final SubmittedYoutubeConfirmArg arg;

  @override
  Override? get argProviderOverrides =>
      submittedYoutubeConfirmArgProvider.overrideWithValue(arg);

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(16),
          Text(
            arg.hasFetchedMetaInfo ? '입력하신 영상이 맞나요?' : '테크톡에 없는 영상이에요',
            style: AppTextStyle.headline1,
          ),
          const Gap(12),
          Text(
            '영상을 업로드하면 내용을 요약하고\n면접 질문을 받아볼 수 있어요!',
            style: AppTextStyle.body1.copyWith(
              color: AppColor.of.gray4,
            ),
          ),
          const Spacer(flex: 121),
          YoutubeContentItemView(
            thumbnailImgUrl: arg.video.thumbnails.highResUrl,
            title: arg.video.title,
            channelName: arg.video.channelName,
            videoId: arg.video.id,
          ),
          const Spacer(flex: 136),
          SafeArea(
            child: Container(
              margin: EdgeInsets.only(bottom: 16),
              width: double.infinity,
              child: HookBuilder(
                builder: (context) {
                  return BounceTapper(
                    child: SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: () {
                          onConfirmBtnTapped(ref);
                        },
                        child: const Text(
                          '다음',
                        ),
                      ),
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

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, WidgetRef ref) {
    return const BackButtonAppBar();
  }
}
