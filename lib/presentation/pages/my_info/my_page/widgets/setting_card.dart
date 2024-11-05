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
            horizontal: 20,
            vertical: 24,
          ),
          decoration: BoxDecoration(
            color: AppColor.of.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Wrap(
                    direction: Axis.vertical,
                    alignment: WrapAlignment.center,
                    spacing: 4,
                    children: [
                      Text(
                        tr(LocaleKeys.permission_alarm_title),
                        style: AppTextStyle.title3,
                      ),
                      Text(
                        tr(LocaleKeys.permission_alarm_desc),
                        style: AppTextStyle.body3.copyWith(
                          color: AppColor.of.gray3,
                        ),
                      ),
                    ],
                  ),
                  isNotificationGranted(ref).when(
                    data: (isGranted) {
                      return FlatSwitch(
                        height: 24,
                        value: isGranted,
                        bgColor: AppColor.of.blue2,
                        onTap: (_) {
                          onNotificationSwitchBtnTapped(ref);
                        },
                      );
                    },
                    error: (_, __) => const EmptyBox(),
                    loading: () => const EmptyBox(),
                  ),
                ],
              ),
              const Gap(12),
              FutureBuilder(
                future: currentAppVersion(),
                builder: (context, value) {
                  if (value.hasData) {
                    return CardListTileButton(
                      text:
                          '${tr(LocaleKeys.myInfo_settings_currentVersion)} ${value.requireData}',
                    );
                  } else {
                    return const EmptyBox();
                  }
                },
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
