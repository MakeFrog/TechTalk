part of '../steps/nickname_input_step.dart';

class _NicknameInputField extends HookConsumerWidget with SignUpEvent {
  const _NicknameInputField(this.formKey, {super.key});

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: ClearableTextField(
        validator: (input) => nicknameValidation(ref, input: input),
        textInputAction: TextInputAction.done,
        inputDecoration: InputDecoration(
          hintText: '닉네임을 입력해 주세요',
          errorStyle: AppTextStyle.alert2.copyWith(),
        ),
        onClear: () => onClearNicknameField(ref),
        onChanged: (value) => onNicknameChanged(
          ref,
          input: value,
        ),
      ),
    );
  }
}
