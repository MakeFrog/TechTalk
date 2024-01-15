part of '../steps/nickname_input_step.dart';

class _BottomFixedBtn extends HookConsumerWidget with SignUpEvent {
  const _BottomFixedBtn(this.formKey, {super.key});

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isBtnActivate = useState(false);

    ref.listen(nicknameInputProvider, (_, __) {
      isBtnActivate.value = formKey.currentState!.validate();
    });

    return FilledButton(
      onPressed: isBtnActivate.value
          ? () {
              onNicknameStepBtnTapped(ref);
            }
          : null,
      child: const Center(
        child: Text('다음'),
      ),
    );
  }
}
