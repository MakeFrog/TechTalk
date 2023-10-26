import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:techtalk/core/theme/extension/app_color.dart';
import 'package:techtalk/presentation/pages/sign_up/providers/sign_up_step_controller_provider.dart';
import 'package:techtalk/presentation/pages/sign_up/sign_up_event.dart';
import 'package:techtalk/presentation/pages/sign_up/steps/job_group_select_screen.dart';
import 'package:techtalk/presentation/pages/sign_up/steps/nickname_input_screen.dart';
import 'package:techtalk/presentation/pages/sign_up/steps/tech_skill_select_screen.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _AppBar(),
      body: _Body(),
    );
  }
}

class _AppBar extends StatelessWidget
    with SignUpEvent
    implements PreferredSizeWidget {
  const _AppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      leading: _buildBackButton(),
      actions: [
        _buildStepIndicator(),
      ],
    );
  }

  Widget _buildBackButton() {
    return Consumer(
      builder: (_, ref, __) {
        final canBack = ref.watch(canBackToPreviousStepProvider);

        return canBack
            ? BackButton(
                onPressed: () => onTapBackButton(ref),
              )
            : const SizedBox();
      },
    );
  }

  Widget _buildStepIndicator() {
    return Padding(
      padding: EdgeInsets.only(right: 16.w),
      child: Consumer(
        builder: (_, ref, __) {
          final pageController = ref.watch(signUpStepControllerProvider);

          return SmoothPageIndicator(
            controller: pageController,
            count: 3,
            effect: WormEffect(
              type: WormType.thin,
              activeDotColor: AppColor.of.brand2,
              dotColor: AppColor.of.brand1,
              dotHeight: 8.r,
              dotWidth: 8.r,
            ),
          );
        },
      ),
    );
  }
}

class _Body extends ConsumerWidget {
  const _Body({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageController = ref.watch(signUpStepControllerProvider);

    return SafeArea(
      child: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          NicknameInputScreen(),
          JobGroupSelectScreen(),
          TechSkillSelectScreen(),
        ],
      ),
    );
  }
}
