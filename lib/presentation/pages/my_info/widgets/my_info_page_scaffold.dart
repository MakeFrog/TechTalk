part of '../my_info_page.dart';

class _Scaffold extends StatelessWidget {
  const _Scaffold({
    super.key,
    required this.myInfoCard,
    required this.settingCard,
    required this.additionalInfoCard,
    required this.introView,
  });

  final Widget introView;
  final Widget myInfoCard;
  final Widget settingCard;
  final Widget additionalInfoCard;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Gap(32),

        introView,

        const Gap(52),

        myInfoCard,
        Gap(24),

        settingCard,
        Gap(24),

        additionalInfoCard,

        /// 기타
      ],
    );
  }
}
