import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:techtalk/core/theme/extension/app_color.dart';
import 'package:techtalk/presentation/pages/sign_up/providers/sign_up_step_controller.dart';
import 'package:techtalk/presentation/pages/sign_up/sign_up_event.dart';
import 'package:techtalk/presentation/pages/sign_up/sign_up_state.dart';
import 'package:techtalk/presentation/pages/sign_up/steps/job_group_select_step.dart';
import 'package:techtalk/presentation/pages/sign_up/steps/nickname_input_step.dart';
import 'package:techtalk/presentation/pages/sign_up/steps/skill_select_step.dart';
import 'package:techtalk/presentation/widgets/base/base_page.dart';
import 'package:techtalk/presentation/widgets/common/button/app_back_button.dart';

class SignUpPage extends BasePage {
  const SignUpPage({super.key});

  @override
  bool get preventSwipeBack => true;

  @override
  Color get screenBackgroundColor => Colors.white;

  @override
  bool get setBottomSafeArea => false;

  @override
  PreferredSizeWidget buildAppBar(BuildContext context, WidgetRef ref) =>
      const _AppBar();

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) => const _Body();
}

class _AppBar extends StatelessWidget
    with SignUpEvent, SignUpState
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
    return HookConsumer(
      builder: (context, ref, child) {
        final pageController = signUpStepController(ref);
        final canBack = useListenableSelector(
          pageController,
          () =>
              pageController.hasClients &&
              (pageController.page?.round() ?? 0) >= 1,
        );

        return canBack
            ? AppBackButton(
                onBackBtnTapped: () => onTapBackButton(ref),
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
          return SmoothPageIndicator(
            controller: signUpStepController(ref),
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

class _Body extends ConsumerWidget with SignUpState {
  const _Body({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageView(
      controller: signUpStepController(ref),
      physics: const NeverScrollableScrollPhysics(),
      children: const [
        SkillSelectStep(),
        NicknameInputStep(),
        JobGroupSelectStep(),
      ],
    );
  }
}
