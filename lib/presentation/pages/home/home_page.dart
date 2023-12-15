import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:techtalk/core/core.dart';
import 'package:techtalk/core/theme/extension/app_color.dart';
import 'package:techtalk/presentation/pages/home/widgets/cheer_up_message_card.dart';
import 'package:techtalk/presentation/pages/home/widgets/practical_interview_card.dart';
import 'package:techtalk/presentation/pages/home/widgets/topic_interview_card.dart';

class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    useAutomaticKeepAlive();

    return ColoredBox(
      color: AppColor.of.background1,
      child: Column(
        children: [
          AppBar(
            backgroundColor: AppColor.of.background1,
            title: SvgPicture.asset(
              Assets.logoTechTalkLogo,
              height: 26,
            ),
          ),
          Expanded(
            child: ListView(
              physics: const ScrollPhysics(),
              padding: const EdgeInsets.symmetric(vertical: 8),
              children: const [
                CheerUpMessageCard(),
                Gap(16),
                PracticalInterviewCard(),
                Gap(16),
                TopicInterviewCard(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
