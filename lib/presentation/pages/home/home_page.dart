import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/environment/app_version.dart';
import 'package:techtalk/app/style/app_color.dart';
import 'package:techtalk/app/style/app_text_style.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/presentation/pages/home/home_event.dart';
import 'package:techtalk/presentation/pages/home/widgets/proficiency_interview_card.dart';
import 'package:techtalk/presentation/pages/home/widgets/cheer_up_message_card.dart';
import 'package:techtalk/presentation/pages/home/widgets/common_interview_card.dart';
import 'package:techtalk/presentation/pages/home/widgets/home_state.dart';
import 'package:techtalk/presentation/pages/home/widgets/interview_indicator_card.dart';
import 'package:techtalk/presentation/widgets/base/base_page.dart';
import 'package:techtalk/presentation/widgets/base/controller_holder.dart';
import 'package:techtalk/presentation/widgets/common/common.dart';

part 'widgets/youtube_content_feature_card.p.dart';
part 'widgets/new_feature_card.p.dart';

class HomePage extends BasePage with HomeState, HomeEvent {
  const HomePage({super.key});

  @override
  void onInit(WidgetRef ref) async {
    super.onInit(ref);

    await requestNotificationPermission(ref);
  }

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    useAutomaticKeepAlive();
    final scrollController = useScrollController();

    return ControllerHolder<ScrollController>(
      controller: scrollController,
      child: userAsync(ref).when(
        data: (_) {
          return ListView(
            controller: scrollController,
            physics: const ScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            children: [
              Builder(
                builder: (context) {
                  if (AppVersion().isOnReview) {
                    return const CheerUpMessageCard();
                  } else {
                    return const _NewFeatureCard();
                  }
                },
              ),
              const Gap(16),
              const ProficiencyInterviewCard(),
              const Gap(16),
              const CommonInterviewCard(),
            ],
          );
        },
        error: (e, __) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const ExceptionIndicator(
                title: '오류 발생',
                subTitle: '예상하지 못한 오류가 발생했습니다.\n다시 시도해주세요',
              ),
              FilledButton(
                onPressed: () => onRetryBtnTapped(ref),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 34,
                    vertical: 14,
                  ),
                ),
                child: const Text('재시도'),
              )
            ],
          ),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  @override
  bool get canPop => false;

  @override
  Color? get screenBackgroundColor => AppColor.of.background1;

  @override
  Color? get unSafeAreaColor => AppColor.of.background1;

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, WidgetRef ref) =>
      AppBar(
        backgroundColor: AppColor.of.background1,
        title: SvgPicture.asset(
          Assets.iconsTechTalkLogo,
          height: 26,
        ),
      );
}
