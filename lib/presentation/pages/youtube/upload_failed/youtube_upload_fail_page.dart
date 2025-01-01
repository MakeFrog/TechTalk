import 'package:bounce_tapper/bounce_tapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/style/app_color.dart';
import 'package:techtalk/app/style/app_text_style.dart';
import 'package:techtalk/core/constants/assets.dart';
import 'package:techtalk/core/services/app_size.dart';
import 'package:techtalk/features/contents/usecases/enums/youtube_upload_failed_type.dart';
import 'package:techtalk/presentation/pages/youtube/upload_failed/provider/youtube_upload_failed_route_arg_provider.dart';
import 'package:techtalk/presentation/pages/youtube/upload_failed/youtube_upload_failed_event.dart';
import 'package:techtalk/presentation/widgets/base/base_page.dart';
import 'package:techtalk/presentation/widgets/common/app_bar/back_button_app_bar.dart';

class YoutubeUploadFailedPage extends BasePage with YoutubeUploadFailedEvent {
  const YoutubeUploadFailedPage({super.key, required this.exception});

  final YoutubeUploadFailedType exception;

  @override
  Override? get argProviderOverrides =>
      youtubeUploadFailedRouteArgProvider.overrideWithValue(exception);

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
                exception.title,
                style: AppTextStyle.headline1,
              ),
              const Gap(12),
              Text(
                exception.description,
                style: AppTextStyle.body1.copyWith(color: AppColor.of.gray4),
              ),
            ],
          ),
        ),
        const Spacer(flex: 105),
        SvgPicture.asset(Assets.iconsRedWarnningBig),
        const Spacer(flex: 166),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          margin: EdgeInsets.only(bottom: AppSize.bottomInset == 0 ? 16 : 0),
          child: BounceTapper(
            child: SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {
                  onBottomFixedBtnTapped(ref);
                },
                child: Text(exception == YoutubeUploadFailedType.alreadyUploaded
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
