import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:techtalk/core/theme/extension/app_color.dart';
import 'package:techtalk/presentation/pages/sign_up/providers/sign_up_step_controller_provider.dart';
import 'package:techtalk/presentation/pages/sign_up/sign_up_page_event.dart';
import 'package:techtalk/presentation/pages/sign_up/steps/interested_job_select_screen.dart';
import 'package:techtalk/presentation/pages/sign_up/steps/nickname_input_screen.dart';
import 'package:techtalk/presentation/widgets/common/common.dart';

class SignUpPage extends ConsumerWidget with SignUpPageEvent {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageController = ref.watch(signUpStepControllerProvider);
    final canBack = ref.watch(canBackToPreviousStepProvider);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: canBack
            ? BackButton(
                onPressed: () => onTapBackButton(ref),
              )
            : null,
        actions: [
          SmoothPageIndicator(
            controller: pageController,
            count: 3,
            effect: WormEffect(
              type: WormType.thin,
              activeDotColor: AppColor.of.brand2,
              dotColor: AppColor.of.brand1,
              dotHeight: 8,
              dotWidth: 8,
            ),
          ),
          const WidthBox(16),
        ],
      ),
      body: SafeArea(
        child: PageView(
          controller: pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            NicknameInputScreen(),
            InterestJobSelectScreen(),
            NicknameInputScreen(),
          ],
        ),
      ),
    );
  }
}
