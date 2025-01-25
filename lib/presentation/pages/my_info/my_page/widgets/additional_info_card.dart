part of '../my_page.dart';

class _AdditionalInfoCard extends ConsumerWidget with MyPageEvent {
  const _AdditionalInfoCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Text(
            tr(LocaleKeys.myInfo_others_others),
            style: AppTextStyle.headline3,
          ),
        ),
        const Gap(12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(4, 12, 4, 12),
          decoration: BoxDecoration(
            color: AppColor.of.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CardListTileButton(
                onTap: () {
                  onLogOutBtnTapped(ref);
                },
                text: tr(LocaleKeys.myInfo_others_logout),
              ),
              CardListTileButton(
                onTap: () {
                  onResignBtnTapped(ref);
                },
                text: tr(LocaleKeys.myInfo_others_deleteAccount),
                textColor: AppColor.of.gray2,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
