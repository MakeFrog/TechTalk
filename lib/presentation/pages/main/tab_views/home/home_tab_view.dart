import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:techtalk/core/core.dart';
import 'package:techtalk/core/theme/extension/app_color.dart';
import 'package:techtalk/presentation/pages/main/tab_views/home/widgets/cheer_up_message_card.dart';
import 'package:techtalk/presentation/pages/main/tab_views/home/widgets/practical_interview_card.dart';
import 'package:techtalk/presentation/pages/main/tab_views/home/widgets/topic_interview_card.dart';
import 'package:techtalk/presentation/widgets/common/common.dart';

class HomeTabView extends HookWidget {
  const HomeTabView({super.key});

  @override
  Widget build(BuildContext context) {
    useAutomaticKeepAlive();

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
      backgroundColor: AppColor.of.background1,
      title: SvgPicture.asset(
        Assets.logoTechTalkLogo,
        height: 26.h,
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: ScrollPhysics(),
      padding: EdgeInsets.symmetric(vertical: 8.h),
      children: [
        const CheerUpMessageCard(),
        HeightBox(16.h),
        const PracticalInterviewCard(),
        HeightBox(16.h),
        const TopicInterviewCard(),
      ],
    );
  }
}
