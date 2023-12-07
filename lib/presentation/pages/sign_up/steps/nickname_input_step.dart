import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/core/theme/extension/app_color.dart';
import 'package:techtalk/core/theme/extension/app_text_style.dart';
import 'package:techtalk/presentation/pages/sign_up/sign_up_event.dart';
import 'package:techtalk/presentation/pages/sign_up/widgets/sign_up_step_intro_message.dart';
import 'package:techtalk/presentation/providers/sign_up/sign_up_form_provider.dart';
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
          _NicknameField(),
          Spacer(),
          _NextButton(),
        ],
      ),
    );
  }
}

class _NicknameField extends ConsumerWidget with SignUpEvent {
  const _NicknameField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final validation = ref.watch(
      signUpFormProvider.select((value) => value.nicknameValidation),
    );
    final isPassNickname = ref.watch(
      signUpFormProvider.select((value) => value.isPassNickname),
    );

    return ClearableTextField(
      textInputAction: TextInputAction.done,
      inputDecoration: InputDecoration(
        hintText: '닉네임을 입력해 주세요',
        errorText: isPassNickname ? '사용 가능한 닉네임입니다.' : validation,
        errorStyle: AppTextStyle.alert2.copyWith(
          color: isPassNickname ? AppColor.of.brand3 : AppColor.of.red2,
        ),
      ),
      onChanged: ref.read(signUpFormProvider.notifier).updateNickname,
    );
  }
}

class _NextButton extends ConsumerWidget with SignUpEvent {
  const _NextButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPassNickname = ref.watch(
      signUpFormProvider.select((value) => value.isPassNickname),
    );

    return FilledButton(
      onPressed: isPassNickname ? () => onTapNicknameStepNext(ref) : null,
      child: const Center(
        child: Text('다음'),
      ),
    );
  }
}
