import 'package:bounce_tapper/bounce_tapper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/localization/locale_keys.g.dart';
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
            arg.hasFetchedMetaInfo
                ? tr(LocaleKeys.youtubeUpload_confirmationTitle)
                : tr(LocaleKeys.youtubeUpload_notFoundError),
            style: AppTextStyle.headline1,
          ),
          const Gap(12),
          Text(
            tr(LocaleKeys.youtubeUpload_confirmationDescription),
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
              margin: const EdgeInsets.only(bottom: 16),
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
                        child: Text(
                          tr(LocaleKeys.common_next),
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
