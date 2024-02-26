part of '../profile_setting_page.dart';

class _SaveButton extends HookConsumerWidget
    with ProfileSettingState, ProfileSettingEvent {
  const _SaveButton(this.formKey, {super.key});

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isBtnActivate = useState(false);

    ref.listen(pickedProfileImgProvider, (_, next) {
      isBtnActivate.value = formKey.currentState!.validate() &&
          (hasProfileImgEdited(ref) || hasNicknameEdited(ref));
    });

    ref.listen(nicknameInputProvider, (_, input) {
      isBtnActivate.value = formKey.currentState!.validate() &&
          (hasProfileImgEdited(ref) || hasNicknameEdited(ref));
    });

    return Padding(
      padding: EdgeInsets.only(bottom: AppSize.to.bottomInset == 0 ? 16 : 0),
      child: FilledButton(
        onPressed: isBtnActivate.value
            ? () {
                onSaveBtnTapped(ref);
              }
            : null,
        child: const Center(
          child: Text('저장하기'),
        ),
      ),
    );
  }
}
