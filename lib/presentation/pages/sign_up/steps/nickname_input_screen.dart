import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/core/theme/extension/app_color.dart';
import 'package:techtalk/core/theme/extension/app_text_style.dart';
import 'package:techtalk/presentation/pages/sign_up/providers/sign_up_form_provider.dart';
import 'package:techtalk/presentation/pages/sign_up/sign_up_event.dart';
import 'package:techtalk/presentation/pages/sign_up/widgets/sign_up_step_intro_message.dart';
import 'package:techtalk/presentation/widgets/common/common.dart';

class NicknameInputScreen extends HookWidget {
  const NicknameInputScreen({super.key});

  @override
  Widget build(BuildContext context) {
    useAutomaticKeepAlive();

    final isRunningDebouncer = useState<bool>(false);

    return Padding(
      padding: EdgeInsets.all(16.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SignUpStepIntroMessage(
            title: '안녕하세요. 테크톡으로\n면접을 준비해볼까요?',
            subTitle: '먼저 사용할 닉네임이 필요해요.',
          ),
          HeightBox(56.h),
          _NicknameInputSection(
            isRunningDebouncer: isRunningDebouncer,
          ),
          const Spacer(),
          _NextButton(
            isRunningDebouncer: isRunningDebouncer,
          ),
        ],
      ),
    );
  }
}

class _NicknameInputSection extends HookConsumerWidget with SignUpEvent {
  const _NicknameInputSection({
    super.key,
    required this.isRunningDebouncer,
  });

  final ValueNotifier<bool> isRunningDebouncer;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClearableTextField(
          controller: controller,
          inputDecoration: const InputDecoration(
            hintText: '닉네임을 입력해 주세요',
          ),
          onChanged: (value) => onChangeNicknameField(
            ref,
            nickname: value,
            isRunningDebouncer: isRunningDebouncer,
          ),
          onClear: () => onClearNicknameField(
            ref,
            controller: controller,
            isRunningDebouncer: isRunningDebouncer,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0.w),
          child: isRunningDebouncer.value
              ? SizedBox.square(
                  dimension: 12.r,
                  child: const CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                )
              : _buildValidationMessage(),
        ),
      ],
    );
  }

  Widget _buildValidationMessage() {
    return Consumer(
      builder: (context, ref, child) {
        final signUpForm = ref.watch(signUpFormProvider);

        if (signUpForm.nicknameValidation != null) {
          return Text(
            signUpForm.nicknameValidation!,
            style: AppTextStyle.alert2.copyWith(
              color: AppColor.of.red2,
            ),
          );
        } else if (signUpForm.isPassNickname) {
          return Text(
            '사용가능한 닉네임입니다.',
            style: AppTextStyle.alert2.copyWith(
              color: AppColor.of.brand3,
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}

class _NextButton extends ConsumerWidget with SignUpEvent {
  const _NextButton({
    super.key,
    required this.isRunningDebouncer,
  });

  final ValueNotifier<bool> isRunningDebouncer;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPassNickname = ref.watch(
      signUpFormProvider.select((v) => v.isPassNickname),
    );

    return FilledButton(
      onPressed: !isRunningDebouncer.value && isPassNickname
          ? () => onTapNicknameStepNext(ref)
          : null,
      child: const Center(
        child: Text('다음'),
      ),
    );
  }
}
