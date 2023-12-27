import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/core/theme/extension/app_color.dart';
import 'package:techtalk/core/theme/extension/app_text_style.dart';
import 'package:techtalk/presentation/pages/sign_up/sign_up_event.dart';
import 'package:techtalk/presentation/pages/sign_up/widgets/sign_up_step_intro_message.dart';
import 'package:techtalk/presentation/widgets/common/common.dart';

class NicknameInputStep extends HookConsumerWidget with SignUpEvent {
  const NicknameInputStep({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useAutomaticKeepAlive();
    final nickname = useState('');
    final nicknameValidation = useState<String?>(null);
    final isPass =
        nickname.value.isNotEmpty && nicknameValidation.value == null;

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
          ClearableTextField(
            textInputAction: TextInputAction.done,
            inputDecoration: InputDecoration(
              hintText: '닉네임을 입력해 주세요',
              errorText: isPass ? '사용 가능한 닉네임입니다.' : nicknameValidation.value,
              errorStyle: AppTextStyle.alert2.copyWith(
                color: isPass ? AppColor.of.brand3 : AppColor.of.red2,
              ),
            ),
            onChanged: (value) {
              nickname.value = value;
              nicknameValidation.value = validateNickname(value);
            },
          ),
          const Spacer(),
          FilledButton(
            onPressed: isPass
                ? () => onTapNicknameStepNext(
                      ref,
                      nickname: nickname.value,
                      nicknameValidation: nicknameValidation,
                    )
                : null,
            child: const Center(
              child: Text('다음'),
            ),
          ),
        ],
      ),
    );
  }
}
