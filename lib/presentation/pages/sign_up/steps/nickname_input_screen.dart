import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/core/theme/extension/app_color.dart';
import 'package:techtalk/core/theme/extension/app_text_style.dart';
import 'package:techtalk/features/sign_up/models/sign_up_form_model.dart';
import 'package:techtalk/presentation/pages/sign_up/providers/sign_up_form_provider.dart';
import 'package:techtalk/presentation/pages/sign_up/sign_up_page_event.dart';
import 'package:techtalk/presentation/pages/sign_up/widgets/sign_up_step_screen_frame.dart';
import 'package:techtalk/presentation/widgets/common/common.dart';

class NicknameInputScreen extends HookConsumerWidget with SignUpPageEvent {
  const NicknameInputScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nicknameCtrl = useTextEditingController();
    final isRunningDebouncer = useState<bool>(false);
    final signUpForm = ref.watch(signUpFormProvider);

    return SignUpStepScreenFrame(
      stepTitle: '안녕하세요. 테크톡으로\n면접을 준비해볼까요?',
      stepDesc: '먼저 사용할 닉네임이 필요해요.',
      onTapNext: !isRunningDebouncer.value && signUpForm.isPassNickname
          ? () => onTapNicknamePageNext(ref)
          : null,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HeightBox(56),
          ClearableTextField(
            controller: nicknameCtrl,
            inputDecoration: const InputDecoration(
              hintText: '닉네임을 입력해 주세요',
            ),
            onChanged: (value) => onChangeNicknameField(
              ref,
              nickname: value,
              isRunningDebouncer: isRunningDebouncer,
            ),
            onClear: isRunningDebouncer.value
                ? null
                : () => onClearNicknameField(
                      ref,
                      controller: nicknameCtrl,
                    ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: isRunningDebouncer.value
                ? const SizedBox.square(
                    dimension: 12,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  )
                : _buildValidationResult(signUpForm),
          ),
        ],
      ),
    );
  }

  Widget? _buildValidationResult(SignUpFormModel form) {
    if (form.nicknameValidation != null) {
      return Text(
        form.nicknameValidation!,
        style: AppTextStyle.alert2.copyWith(
          color: AppColor.of.red2,
        ),
      );
    } else if (form.isPassNickname) {
      return Text(
        '사용가능한 닉네임입니다.',
        style: AppTextStyle.alert2.copyWith(
          color: AppColor.of.brand3,
        ),
      );
    }

    return null;
  }
}
