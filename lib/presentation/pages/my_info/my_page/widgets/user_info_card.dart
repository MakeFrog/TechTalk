part of '../my_page.dart';

class _UserInfoCard extends ConsumerWidget with MyPageState, MyPageEvent {
  const _UserInfoCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              tr(LocaleKeys.gnb_myInfo),
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
                  // 관심 직군
                  Text(
                    tr(LocaleKeys.common_interviewTerms_interestedJobPositions),
                    style: AppTextStyle.body3,
                  ),
                  const Gap(8),
                  ExpandableWrappedListview(
                    items: user!.jobGroups
                        .map((e) => AppLocale.isKo ? e.name : e.enName)
                        .toList(),
                  ),
                  const Gap(16),

                  // 관심 주제
                  Text(
                    tr(LocaleKeys.common_interviewTerms_interestedTopics),
                    style: AppTextStyle.body3,
                  ),
                  const Gap(8),
                  ExpandableWrappedListview(
                    items: user.skills.map((e) => e.name).toList(),
                  ),
                  const Gap(16),

                  // 내 이력서
                  BounceTapper(
                    onTap: () => routeToResumeManagePage(ref),
                    highlightColor: Colors.transparent,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '내 이력서',
                              style: AppTextStyle.title2,
                            ),
                            SvgPicture.asset(
                              Assets.iconsArrowRight,
                              height: 16,
                              colorFilter: ColorFilter.mode(
                                AppColor.of.gray3,
                                BlendMode.srcIn,
                              ),
                            ),
                          ],
                        ),
                        const Gap(4),
                        resumeAsync(ref).when(
                          data: (_) {
                            return Consumer(
                              builder: (context, ref, _) {
                                final hasData = ref
                                    .read(resumeInfoProvider.notifier)
                                    .hasData();

                                if (!hasData) {
                                  return Text(
                                    '이력서 등록 후 예상 질문을 경험해 보세요!',
                                    style: AppTextStyle.body3
                                        .copyWith(color: AppColor.of.gray3),
                                  );
                                } else {
                                  return const EmptyBox();
                                }
                              },
                            );
                          },
                          error: (e, __) => const Text('에러가 발생했습니다'),
                          loading: () => const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ],
                    ),
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
