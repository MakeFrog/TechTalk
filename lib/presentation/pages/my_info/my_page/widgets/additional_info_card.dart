part of '../my_page.dart';

class _AdditionalInfoCard extends ConsumerWidget with MyPageEvent {
  const _AdditionalInfoCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          tr(LocaleKeys.myInfo_others_others),
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
