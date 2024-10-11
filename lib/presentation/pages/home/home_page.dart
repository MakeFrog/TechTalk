import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/localization/app_locale.dart';
import 'package:techtalk/app/localization/localization_enum.dart';
import 'package:techtalk/app/style/app_color.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/topic/topic.dart';
import 'package:techtalk/presentation/pages/home/home_event.dart';
import 'package:techtalk/presentation/pages/home/widgets/cheer_up_message_card.dart';
import 'package:techtalk/presentation/pages/home/widgets/home_state.dart';
import 'package:techtalk/presentation/pages/home/widgets/practical_interview_card.dart';
import 'package:techtalk/presentation/pages/home/widgets/resume_interview_card.dart';
import 'package:techtalk/presentation/pages/home/widgets/single_topic_interview_card.dart';
import 'package:techtalk/presentation/widgets/base/base_page.dart';
import 'package:techtalk/presentation/widgets/common/common.dart';

class HomePage extends BasePage with HomeState, HomeEvent {
  const HomePage({super.key});

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    useAutomaticKeepAlive();

    return userAsync(ref).when(
      data: (_) {
        return ListView(
          physics: const ScrollPhysics(),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          children: const [
            CheerUpMessageCard(),
            Gap(16),
            ResumeInterviewCard(),
            Gap(16),
            PracticalInterviewCard(),
            Gap(16),
            SingleTopicInterviewCard(),
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
