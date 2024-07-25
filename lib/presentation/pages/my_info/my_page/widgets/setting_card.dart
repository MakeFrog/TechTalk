part of '../my_page.dart';

class _SettingCard extends ConsumerWidget with MyPageState, MyPageEvent {
  const _SettingCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          tr(LocaleKeys.myInfo_settings_settings),
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
                  text:
                      '${tr(LocaleKeys.myInfo_settings_currentVersion)} ${versionInfo.versionCode}',
                ),
                error: (e, _) => const EmptyBox(),
                loading: () => const CardListTileButton(text: '현재 버전'),
              ),
              CardListTileButton(
                onTap: onVisitCsPageTapped,
                text: tr(LocaleKeys.myInfo_settings_feedbackAndInquiries),
              ),
              CardListTileButton(
                onTap: onVisitPolicyPageBtnTapped,
                text: tr(LocaleKeys.myInfo_settings_privacyAndTerms),
              ),
              CardListTileButton(
                onTap: onRateAppTapped,
                text: tr(LocaleKeys.myInfo_settings_rateApp),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
