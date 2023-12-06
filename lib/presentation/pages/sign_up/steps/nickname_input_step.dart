import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/presentation/pages/sign_up/sign_up_event.dart';
import 'package:techtalk/presentation/pages/sign_up/widgets/sign_up_step_intro_message.dart';
import 'package:techtalk/presentation/providers/sign_up/validate_nickname_provider.dart';
import 'package:techtalk/presentation/widgets/common/common.dart';
import 'package:techtalk/presentation/widgets/common/input/under_validate_text_field.dart';

class NicknameInputStep extends HookWidget with SignUpEvent {
  const NicknameInputStep({super.key});

  @override
  Widget build(BuildContext context) {
    useAutomaticKeepAlive();
    final controller = useTextEditingController();

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SignUpStepIntroMessage(
            title: '안녕하세요. 테크톡으로\n면접을 준비해볼까요?',
            subTitle: '먼저 사용할 닉네임이 필요해요.',
          ),
          const Gap(56),
          _buildField(controller),
          const Spacer(),
          _buildNextButton(controller),
        ],
      ),
    );
  }

  Widget _buildField(TextEditingController controller) {
    return HookConsumer(
      builder: (context, ref, child) {
        final nickname = useListenableSelector(
          controller,
          () => controller.text,
        );
        final validation = ref.watch(validateNicknameProvider(nickname).future);

        return UnderValidateTextField(
          controller: controller,
          field: (controller) => ClearableTextField(
            controller: controller,
            textInputAction: TextInputAction.done,
            inputDecoration: const InputDecoration(
              hintText: '닉네임을 입력해 주세요',
            ),
          ),
          validate: validation,
          successText: '사용가능한 닉네임입니다.',
        );
      },
    );
  }

  Widget _buildNextButton(TextEditingController controller) {
    return HookConsumer(
      builder: (context, ref, child) {
        final nickname =
            useListenableSelector(controller, () => controller.text);
        final isValidated = ref.watch(
          validateNicknameProvider(nickname).select(
            (value) => value.hasValue && value.valueOrNull == null,
          ),
        );

        return FilledButton(
          onPressed: nickname.isNotEmpty && isValidated
              ? () => onTapNicknameStepNext(
                    ref,
                    nickname: nickname,
                  )
              : null,
          child: const Center(
            child: Text('다음'),
          ),
        );
      },
    );
  }
}
