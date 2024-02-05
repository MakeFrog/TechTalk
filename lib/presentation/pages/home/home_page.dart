import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/core/core.dart';
import 'package:techtalk/core/theme/extension/app_color.dart';
import 'package:techtalk/presentation/pages/home/widgets/cheer_up_message_card.dart';
import 'package:techtalk/presentation/pages/home/widgets/home_state.dart';
import 'package:techtalk/presentation/pages/home/widgets/practical_interview_card.dart';
import 'package:techtalk/presentation/pages/home/widgets/single_topic_interview_card.dart';
import 'package:techtalk/presentation/widgets/base/base_page.dart';

class HomePage extends BasePage with HomeState {
  const HomePage({super.key});

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    useAutomaticKeepAlive();

    return asyncValue(ref).when(
      data: (_) {
        return ListView(
          physics: const ScrollPhysics(),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          children: const [
            CheerUpMessageCard(),
            Gap(16),
            PracticalInterviewCard(),
            Gap(16),
            SingleTopicInterviewCard(),
          ],
        );
      },
      error: (e, __) => const Text('error on homepage'),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  @override
  Color? get screenBackgroundColor => AppColor.of.background1;

  @override
  Color? get unSafeAreaColor => AppColor.of.background1;

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, WidgetRef ref) =>
      AppBar(
        backgroundColor: AppColor.of.background1,
        title: SvgPicture.asset(
          Assets.logoTechTalkLogo,
          height: 26,
        ),
      );
}
