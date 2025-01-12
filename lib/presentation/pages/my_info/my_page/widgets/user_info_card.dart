part of '../my_page.dart';

class _UserInfoCard extends ConsumerWidget with MyPageState, MyPageEvent {
  const _UserInfoCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Text(
            tr(LocaleKeys.gnb_myInfo),
            style: AppTextStyle.headline3,
          ),
        ),
        const Gap(12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            vertical: 24,
            horizontal: 16,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: AppColor.of.white,
          ),
          child: user(ref).when(
            data: (user) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      onJobGroupSectionTapped(context);
                    },
                    behavior: HitTestBehavior.translucent,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              tr(LocaleKeys
                                  .common_interviewTerms_interestedJobPositions),
                              style: AppTextStyle.title2,
                            ),
                            SvgPicture.asset(
                              Assets.iconsNewRightArrow,
                            ),
                          ],
                        ),
                        const Gap(8),
                        ExpandableWrappedListview(
                          items: user!.jobGroups.map((e) => e.name).toList(),
                        ),
                      ],
                    ),
                  ),
                  const Gap(24),
                  GestureDetector(
                    onTap: () {
                      onSkillSectionTapped(context);
                    },
                    behavior: HitTestBehavior.translucent,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              tr(LocaleKeys
                                  .common_interviewTerms_interestedTopics),
                              style: AppTextStyle.title2,
                            ),
                            SvgPicture.asset(
                              Assets.iconsNewRightArrow,
                            ),
                          ],
                        ),
                        const Gap(8),
                        ExpandableSkillWrappedListview(
                          items: user.skills,
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
