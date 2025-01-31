import 'package:bounce_tapper/bounce_tapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/style/app_color.dart';
import 'package:techtalk/app/style/app_text_style.dart';
import 'package:techtalk/core/constants/assets.dart';
import 'package:techtalk/core/services/app_size.dart';
import 'package:techtalk/features/youtube/index.dart';
import 'package:techtalk/presentation/pages/youtube/upload_failed/provider/youtube_upload_failed_route_arg_provider.dart';
import 'package:techtalk/presentation/pages/youtube/upload_failed/youtube_upload_failed_event.dart';
import 'package:techtalk/presentation/widgets/base/base_page.dart';
import 'package:techtalk/presentation/widgets/common/app_bar/back_button_app_bar.dart';
import 'package:techtalk/presentation/widgets/common/item/youtube_content_item_view.dart';

class YoutubeUploadFailedPage extends BasePage with YoutubeUploadFailedEvent {
  const YoutubeUploadFailedPage({super.key, required this.arg});

  final YoutubeUploadFailedArg arg;

  @override
  Override? get argProviderOverrides =>
      youtubeUploadFailedRouteArgProvider.overrideWithValue(arg);

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Gap(16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                arg.type.title,
                style: AppTextStyle.headline1,
              ),
              const Gap(12),
              Text(
                arg.type.description,
                style: AppTextStyle.body1.copyWith(color: AppColor.of.gray4),
              ),
            ],
          ),
        ),
        if (arg.type == YoutubeUploadFailedType.alreadyUploaded) ...[
          const Spacer(flex: 131),
          if (arg.video != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: YoutubeContentItemView(
                thumbnailImgUrl: arg.video!.thumbnails.highResUrl,
                title: arg.video!.title,
                channelName: '',
                videoDuration: arg.video!.duration,
                videoId: arg.video!.id.value,
              ),
            )
          else
            YoutubeContentItemView.createSkeleton(),
          const Spacer(flex: 130),
        ],
        if (arg.type != YoutubeUploadFailedType.alreadyUploaded) ...[
          const Spacer(flex: 105),
          SvgPicture.asset(Assets.iconsRedWarnningBig),
          const Spacer(flex: 166),
        ],
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 24) +
              const EdgeInsets.only(top: 16),
          margin: EdgeInsets.only(bottom: AppSize.bottomInset == 0 ? 16 : 0),
          child: BounceTapper(
            child: SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {
                  onBottomFixedBtnTapped(ref);
                },
                child: Text(arg.type == YoutubeUploadFailedType.alreadyUploaded
                    ? '바로가기'
                    : '다른 영상 가져오기'),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, WidgetRef ref) {
    return const BackButtonAppBar();
  }
}
