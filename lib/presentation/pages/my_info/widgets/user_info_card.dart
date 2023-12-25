part of '../my_info_page.dart';

class _UserInfoCard extends ConsumerWidget {
  const _UserInfoCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: <Widget>[
        Row(
          children: [
            Text(
              '내 정보',
              style: AppTextStyle.title1,
            ),
            const Spacer(),
            GestureDetector(
              child: SvgPicture.asset(
                Assets.iconsPencil,
                width: 16,
              ),
            ),
          ],
        ),
        const Gap(8),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 20,
          ),
          decoration: BoxDecoration(
            color: AppColor.of.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '관심 직군',
                style: AppTextStyle.body3,
              ),
              const Gap(8),

              ExpandableWrappedListview(items: [
                '서버 백엔드 개발자',
                '크래스  개발자3',
                'iOS 개발자',
                '안드로이드21323423232 개발자',
                '닷넷 개발자',
                '슈퍼 개발자',
              ]),

              // SvgPicture.asset(
              //   Assets.iconsRoundedMore,
              // ),
              const Gap(16),
              Text(
                '관심 주제',
                style: AppTextStyle.body3,
              ),
              Gap(8),
              ExpandableWrappedListview(items: [
                'Flutter/Dart',
                'Swift/iOS',
                '자료구조',
                '알고리즘',
              ]),
            ],
          ),
        ),
      ],
    );
  }
}
