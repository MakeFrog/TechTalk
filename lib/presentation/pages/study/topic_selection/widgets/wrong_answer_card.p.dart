part of '../study_topic_selection_page.dart';

class _WrongAnswerNoteCard extends ConsumerWidget
    with StudyTopicSelectionEvent {
  const _WrongAnswerNoteCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BounceTapper(
      onTap: () {
        onWrongAnswerCardTapped(ref);
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.of.red1,
          borderRadius: BorderRadius.circular(16),
        ),
        alignment: Alignment.topLeft,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 187,
              child: Container(
                padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '오답노트',
                          style: AppTextStyle.headline2.copyWith(
                            color: AppColor.of.red2,
                          ),
                        ),
                        const Gap(2),
                        SvgPicture.asset(
                          Assets.iconsRightAlignedRightArrow,
                        )
                      ],
                    ),
                    const Gap(4),
                    Text(
                      '오답 복습을 통해\n실력을 증진하세요!',
                      style: AppTextStyle.body3.copyWith(
                        color: AppColor.of.gray5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 156,
              child: SvgPicture.asset(
                Assets.iconsMistakeNoteIllust,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
