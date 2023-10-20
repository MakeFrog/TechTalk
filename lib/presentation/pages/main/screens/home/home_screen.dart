import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:techtalk/core/core.dart';
import 'package:techtalk/core/theme/extension/app_color.dart';
import 'package:techtalk/presentation/pages/main/screens/home/widgets/cheer_up_message_card.dart';
import 'package:techtalk/presentation/pages/main/screens/home/widgets/practical_interview_card.dart';
import 'package:techtalk/presentation/pages/main/screens/home/widgets/topic_interview_card.dart';
import 'package:techtalk/presentation/widgets/common/common.dart';

class HomeScreen extends HookWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.of.background1,
      appBar: const _AppBar(),
      body: const _Body(),
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      centerTitle: false,
      title: SvgPicture.asset(
        Assets.logoTechTalkLogo,
        height: 26,
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 8),
      children: const [
        CheerUpMessageCard(),
        HeightBox(16),
        PracticalInterviewCard(),
        HeightBox(16),
        TopicInterviewCard(),
      ],
    );
  }
}
