import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:techtalk/core/theme/extension/app_color.dart';
import 'package:techtalk/presentation/pages/sign_up/providers/sign_up_step_controller_provider.dart';
import 'package:techtalk/presentation/pages/sign_up/sign_up_page_event.dart';
import 'package:techtalk/presentation/pages/sign_up/steps/interested_job_group_select_screen.dart';
import 'package:techtalk/presentation/pages/sign_up/steps/nickname_input_screen.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: _AppBar(),
      body: _Body(),
    );
  }
}

class _AppBar extends StatelessWidget
    with SignUpPageEvent
    implements PreferredSizeWidget {
  const _AppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
      padding: const EdgeInsets.only(right: 16),
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
              dotHeight: 8,
              dotWidth: 8,
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
          InterestJobGroupSelectScreen(),
          NicknameInputScreen(),
        ],
      ),
    );
  }
}
