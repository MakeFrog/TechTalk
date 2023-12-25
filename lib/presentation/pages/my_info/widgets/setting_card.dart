part of '../my_info_page.dart';

class _SettingCard extends ConsumerWidget {
  const _SettingCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const String versionNum = '1.0.5';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '설정',
          style: AppTextStyle.title1,
        ),
        const Gap(8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          decoration: BoxDecoration(
            color: AppColor.of.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CardListTileButton(onTap: () {}, text: '현재 버전 $versionNum'),
              CardListTileButton(onTap: () {}, text: '피드백 및 문의사항'),
              CardListTileButton(onTap: () {}, text: '개인정보 및 약관'),
            ],
          ),
        ),
      ],
    );
  }
}
