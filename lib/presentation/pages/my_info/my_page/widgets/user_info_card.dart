part of '../my_page.dart';

class _UserInfoCard extends ConsumerWidget with MyPageState, MyPageEvent {
  const _UserInfoCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '내 정보',
              style: AppTextStyle.title1,
            ),
            IconFlashAreaButton.assetIcon(
              iconPath: Assets.iconsPencil,
              size: 16,
              onIconTapped: () {
                onProfileEditBtnTapped(ref);
              },
            ),
          ],
        ),
        const Gap(8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 20,
          ),
          decoration: BoxDecoration(
            color: AppColor.of.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: user(ref).when(
            data: (user) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '관심 직군',
                    style: AppTextStyle.body3,
                  ),
                  const Gap(8),
                  ExpandableWrappedListview(
                    items: user!.jobGroups.map((e) => e.name).toList(),
                  ),
                  const Gap(16),
                  Text(
                    '관심 주제',
                    style: AppTextStyle.body3,
                  ),
                  const Gap(8),
                  ExpandableWrappedListview(
                    items: user.skills.map((e) => e.name).toList(),
                  ),
                ],
              );
            },
            error: (e, _) => SizedBox(
              height: 140,
              child: Center(
                child: Text(
                  '데이터를 전달받지 못하였습니다.',
                  style: AppTextStyle.title1,
                ),
              ),
            ),
            loading: () => const SizedBox(
              height: 140,
              child: Center(child: CircularProgressIndicator()),
            ),
          ),
        ),
      ],
    );
  }
}
