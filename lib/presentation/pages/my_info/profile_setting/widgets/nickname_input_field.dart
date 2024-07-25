part of '../profile_setting_page.dart';

class _NicknameInputField extends ConsumerWidget
    with ProfileSettingState, ProfileSettingEvent {
  const _NicknameInputField(this.formKey, {super.key});

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: ClearableTextField(
        textInputAction: TextInputAction.done,
        validator: (input) => nicknameValidation(ref, input: input),
        initialValue: nickname(ref),
        inputDecoration: InputDecoration(
          hintText: tr(LocaleKeys.onboarding_nickname_needNickname),
          errorStyle: AppTextStyle.alert2.copyWith(),
        ),
        onClear: () {
          onNicknameFieldClear(ref);
        },
        onChanged: (input) {
          onNicknameChanged(ref, input: input);
        },
      ),
    );
  }
}
