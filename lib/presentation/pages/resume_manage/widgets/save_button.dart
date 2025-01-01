part of '../resume_manage_page.dart';

class _SaveButton extends HookConsumerWidget {
  const _SaveButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isBtnActivate = useState(false);

    return BounceTapper(
      enable: isBtnActivate.value,
      child: FilledButton(
        onPressed: isBtnActivate.value ? () {} : null,
        child: Center(
          child: Text(
            context.tr(
              LocaleKeys.common_save,
            ),
          ),
        ),
      ),
    );
  }
}
