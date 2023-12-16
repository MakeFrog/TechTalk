import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:techtalk/core/theme/extension/app_color.dart';
import 'package:techtalk/presentation/pages/sign_up/sign_up_event.dart';
import 'package:techtalk/presentation/pages/sign_up/steps/job_group_select_step.dart';
import 'package:techtalk/presentation/pages/sign_up/steps/nickname_input_step.dart';
import 'package:techtalk/presentation/pages/sign_up/steps/topic_select_step.dart';
import 'package:techtalk/presentation/providers/sign_up/sign_up_step_controller.dart';
import 'package:techtalk/presentation/widgets/base/base_page.dart';
import 'package:techtalk/presentation/widgets/common/button/app_back_button.dart';

class SignUpPage extends BasePage {
  const SignUpPage({super.key});

  @override
  bool get preventSwipeBack => true;

  @override
  Color get screenBackgroundColor => Colors.white;

  @override
  PreferredSizeWidget buildAppBar(BuildContext context, WidgetRef ref) =>
      const _AppBar();

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) => const _Body();
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
      builder: (context, ref, child) {
        return AppBackButton(
          onBackBtnTapped: () => onTapBackButton(ref),
        );
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

    return PageView(
      controller: pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: const [
        NicknameInputStep(),
        JobGroupSelectStep(),
        TopicSelectStep(),
      ],
    );
  }
}
