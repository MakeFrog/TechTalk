part of '../my_page.dart';

class _AdditionalInfoCard extends ConsumerWidget with MyPageEvent {
  const _AdditionalInfoCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '기타',
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
                  text: '로그아웃'),
              CardListTileButton(
                onTap: onWithdrawalBtnTapped,
                text: '회원 탈퇴',
                textColor: AppColor.of.gray2,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
