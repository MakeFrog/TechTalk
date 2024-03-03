import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:techtalk/app/style/app_color.dart';
import 'package:techtalk/presentation/pages/sign_up/events/sign_up_event.dart';
import 'package:techtalk/presentation/pages/sign_up/sign_up_state.dart';
import 'package:techtalk/presentation/pages/sign_up/steps/job_group_select_step.dart';
import 'package:techtalk/presentation/pages/sign_up/steps/nickname_input_step.dart';
import 'package:techtalk/presentation/pages/sign_up/steps/skill_select_step.dart';
import 'package:techtalk/presentation/widgets/base/base_page.dart';
import 'package:techtalk/presentation/widgets/common/button/app_back_button.dart';

part 'widgets/sign_up_app_bar.dart';

class SignUpPage extends BasePage with SignUpState {
  const SignUpPage({super.key});

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    return PageView(
      controller: signUpStepController(ref),
      physics: const NeverScrollableScrollPhysics(),
      children: const [
        NicknameInputStep(),
        JobGroupSelectStep(),
        SkillSelectStep(),
      ],
    );
  }

  @override
  bool get resizeToAvoidBottomInset => false;

  // @override
  // bool get setBottomSafeArea => false;

  @override
  PreferredSizeWidget buildAppBar(BuildContext context, WidgetRef ref) =>
      const _AppBar();
}
