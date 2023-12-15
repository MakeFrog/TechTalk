import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/core/theme/extension/app_color.dart';
import 'package:techtalk/core/theme/extension/app_text_style.dart';
import 'package:techtalk/presentation/pages/sign_up/providers/sign_up_form_provider.dart';
import 'package:techtalk/presentation/pages/sign_up/sign_up_event.dart';
import 'package:techtalk/presentation/pages/sign_up/widgets/sign_up_step_intro_message.dart';
import 'package:techtalk/presentation/widgets/common/common.dart';

class NicknameInputStep extends HookWidget {
  const NicknameInputStep({super.key});

  @override
  Widget build(BuildContext context) {
    useAutomaticKeepAlive();

    return const Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SignUpStepIntroMessage(
            title: '안녕하세요. 테크톡으로\n면접을 준비해볼까요?',
            subTitle: '먼저 사용할 닉네임이 필요해요.',
          ),
          Gap(56),
          _NicknameInputSection(),
          Spacer(),
          _NextButton(),
        ],
      ),
    );
  }
}

class _NicknameInputSection extends HookConsumerWidget with SignUpEvent {
  const _NicknameInputSection({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isRunningDebounce = useValueNotifier(false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClearableTextField(
          inputDecoration: const InputDecoration(
            hintText: '닉네임을 입력해 주세요',
          ),
          onChanged: (value) => onChangeNicknameField(
            ref,
            nickname: value,
            isRunningDebouncer: isRunningDebounce,
          ),
          onClear: () => onClearNicknameField(
            ref,
            isRunningDebouncer: isRunningDebounce,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: HookConsumer(
            builder: (context, ref, child) {
              final isChecking = useValueListenable(isRunningDebounce);

              if (isChecking) {
                return const SizedBox.square(
                  dimension: 12,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                );
              }
              final signUpForm = ref.watch(signUpFormProvider);

              if (signUpForm.nicknameValidation != null) {
                return Text(
                  signUpForm.nicknameValidation!,
                  style: AppTextStyle.alert2.copyWith(
                    color: AppColor.of.red2,
                  ),
                );
              } else {
                return Text(
                  '사용가능한 닉네임입니다.',
                  style: AppTextStyle.alert2.copyWith(
                    color: AppColor.of.brand3,
                  ),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}

class _NextButton extends ConsumerWidget with SignUpEvent {
  const _NextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPassNickname = ref.watch(
      signUpFormProvider.select((v) => v.isPassNickname),
    );

    return FilledButton(
      onPressed: isPassNickname ? () => onTapNicknameStepNext(ref) : null,
      child: const Center(
        child: Text('다음'),
      ),
    );
  }
}
