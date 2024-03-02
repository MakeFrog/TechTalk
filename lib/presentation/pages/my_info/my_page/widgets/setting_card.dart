part of '../my_page.dart';

class _SettingCard extends ConsumerWidget with MyPageState, MyPageEvent {
  const _SettingCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              version(ref).when(
                data: (versionInfo) => CardListTileButton(
                    text: '현재 버전 ${versionInfo.versionCode}'),
                error: (e, _) => const EmptyBox(),
                loading: () => const CardListTileButton(text: '현재 버전'),
              ),
              CardListTileButton(
                  onTap: onVisitCsPageTapped, text: '피드백 및 문의사항'),
              CardListTileButton(
                  onTap: onVisitPolicyPageBtnTapped, text: '개인정보 및 약관'),
              CardListTileButton(onTap: onRateAppTapped, text: '앱 평가하기'),
            ],
          ),
        ),
      ],
    );
  }
}
