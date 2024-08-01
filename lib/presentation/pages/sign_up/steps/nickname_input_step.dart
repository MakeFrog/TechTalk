import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/localization/locale_keys.g.dart';
import 'package:techtalk/app/style/index.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/presentation/pages/sign_up/events/sign_up_event.dart';
import 'package:techtalk/presentation/pages/sign_up/sign_up_state.dart';
import 'package:techtalk/presentation/pages/sign_up/widgets/sign_up_step_intro_message.dart';
import 'package:techtalk/presentation/providers/input/nickname_input_provider.dart';
import 'package:techtalk/presentation/widgets/common/common.dart';
import 'package:techtalk/presentation/widgets/common/gesture/animated_scale_tap.dart';

class NicknameInputStep extends StatelessWidget {
  const NicknameInputStep({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return HookBuilder(
      builder: (context) {
        useAutomaticKeepAlive();
        return _Scaffold(
          introText: SignUpStepIntroMessage(
            title: tr(LocaleKeys.onboarding_nickname_greeting),
            subTitle: tr(LocaleKeys.onboarding_nickname_needNickname),
          ),
          searchBar: _SearchBar(formKey),
          bottomFixedBtn: _StepBtn(formKey),
        );
      },
    );
  }
}

class _SearchBar extends ConsumerWidget with SignUpState, SignUpEvent {
  const _SearchBar(this.formKey, {super.key});

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController controller = TextEditingController();
    if (userDisplayName(ref) != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        controller.text = userDisplayName(ref)!;
        ref
            .read(nicknameInputProvider.notifier)
            .onInputChanged(userDisplayName(ref));
      });
    }

    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: ClearableTextField(
        controller: controller,
        textInputAction: TextInputAction.done,
        validator: (input) => nicknameValidation(ref, input: input),
        inputDecoration: InputDecoration(
          hintText: tr(LocaleKeys.onboarding_nickname_enterNickname),
          errorStyle: AppTextStyle.alert2.copyWith(),
        ),
        onClear: () {
          controller.clear();
          onNicknameFieldClear(ref);
        },
        onChanged: (value) => onNicknameFieldChanged(
          ref,
          input: value,
        ),
      ),
    );
  }
}

class _Scaffold extends StatelessWidget {
  const _Scaffold(
      {super.key,
      required this.introText,
      required this.searchBar,
      required this.bottomFixedBtn});

  final Widget introText;
  final Widget searchBar;
  final Widget bottomFixedBtn;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        introText,
        const Gap(16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: searchBar,
        ),
        const Spacer(),
        Container(
          margin: EdgeInsets.only(bottom: AppSize.to.bottomInset == 0 ? 16 : 0),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: bottomFixedBtn,
        )
      ],
    );
  }
}

class _StepBtn extends HookConsumerWidget with SignUpState, SignUpEvent {
  const _StepBtn(this.formKey, {super.key});

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isBtnActivate = useState(false);

    ref.listen(nicknameInputProvider, (_, __) {
      isBtnActivate.value = formKey.currentState!.validate();
    });

    return ShrinkGestureView(
      borderRadius: BorderRadius.circular(16),
      disableScaleAnimation: !isBtnActivate.value,
      child: FilledButton(
        onPressed:
            isBtnActivate.value ? () => onNicknameStepBtnTapped(ref) : null,
        child: Center(
          child: Text(tr(LocaleKeys.common_next)),
        ),
      ),
    );
  }
}
