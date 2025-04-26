import 'package:bounce_tapper/bounce_tapper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/src/consumer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/app/localization/locale_keys.g.dart';
import 'package:techtalk/app/style/app_color.dart';
import 'package:techtalk/app/style/app_text_style.dart';
import 'package:techtalk/core/constants/assets.dart';
import 'package:techtalk/core/services/app_size.dart';
import 'package:techtalk/features/youtube/index.dart';
import 'package:techtalk/presentation/pages/youtube/upload/analyze_youtube/analyze_youtube_progerss_state.dart';
import 'package:techtalk/presentation/pages/youtube/upload/analyze_youtube/analyze_youtube_progress_event.dart';
import 'package:techtalk/presentation/providers/system/notification_status_provider.dart';
import 'package:techtalk/presentation/widgets/base/base_page.dart';
import 'package:techtalk/presentation/widgets/common/common.dart';

class AnalyzeYoutubePage extends BasePage
    with AnalyzeYoutubeProgressState, AnalyzeYoutubeProgressEvent {
  const AnalyzeYoutubePage({super.key, required this.video});

  final YoutubeVideoEntity video;

  @override
  void onInit(WidgetRef ref) {
    super.onInit(ref);

    analyzeAndUploadYoutubeUseCase.call(video);
  }

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Gap(16),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                tr(LocaleKeys.youtubeUpload_uploadingTitle),
                style: AppTextStyle.headline1,
              ),
              const Gap(12),
              Text(
                tr(LocaleKeys.youtubeUpload_uploadWarning),
                style: AppTextStyle.body1.copyWith(
                  color: AppColor.of.gray4,
                ),
              ),
            ],
          ),
        ),

        const Spacer(),

        // 일러스트 영역
        Center(
          child: Transform.scale(
            scale: 0.84,
            child: Lottie.asset(
              Assets.lottieVideoUploading,
              width: AppSize.ratioHeight(375),
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
        const Spacer(),

        HookBuilder(
          builder: (context) {
            final initialGrantState = useState<bool?>(null);
            return isNotificationGranted(ref).when(
              data: (isGranted) {
                initialGrantState.value ??= isGranted;
                return Column(
                  children: [
                    if (initialGrantState.value ?? isGranted)
                      const EmptyBox()
                    else
                      Padding(
                        padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                            ) +
                            const EdgeInsets.only(bottom: 16),
                        child: Container(
                          height: 64,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: AppColor.of.background1,
                          ),
                          child: Row(
                            children: <Widget>[
                              SvgPicture.asset(
                                Assets.iconsAlarm,
                              ),
                              const Gap(6),
                              Text(
                                tr(LocaleKeys
                                    .youtubeUpload_confirmationNotification),
                                style: AppTextStyle.body1,
                              ),
                              const Spacer(),
                              FlatSwitch(
                                value: isGranted,
                                height: 24,
                                onTap: (_) {
                                  onNotificationSwitchBtnTapped(ref);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: SafeArea(
                        child: Container(
                          margin: const EdgeInsets.only(
                            bottom: 16,
                          ),
                          width: double.infinity,
                          child: BounceTapper(
                            child: SizedBox(
                              width: double.infinity,
                              child: FilledButton(
                                onPressed: () {
                                  onExitPageBtnTapped(ref);
                                },
                                child: Text(isGranted
                                    ? tr(LocaleKeys
                                        .youtubeUpload_uploadCompleteNotification)
                                    : tr(LocaleKeys.common_confirm)),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                );
              },
              error: (_, __) => const EmptyBox(),
              loading: () => const EmptyBox(),
            );
          },
        ),
      ],
    );
  }

  @override
  void onResumed(WidgetRef ref) {
    super.onResumed(ref);
    ref.read(notificationStatusProvider.notifier).detectStatusOnResumed();
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, WidgetRef ref) {
    return BackButtonAppBar(
      onBackBtnTapped: () {
        onExitPageBtnTapped(ref);
      },
    );
  }

  @override
  bool get canPop => false;
}
