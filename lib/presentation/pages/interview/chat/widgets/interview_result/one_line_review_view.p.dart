part of 'interview_result_dialog.dart';

class _OnLineView extends ConsumerWidget {
  const _OnLineView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        16,
        28,
        16,
        16,
      ),
      decoration: BoxDecoration(
        color: AppColor.of.white,
        borderRadius: BorderRadius.circular(
          24,
        ),
      ),
      margin: const EdgeInsets.only(right: 20),
      child: Column(
        children: <Widget>[
          Text(
            '면접관의 한줄평',
            maxLines: 1,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyle.headline1,
          ),
          const Spacer(),
          SvgPicture.asset(
            Assets.iconsPonderingIllusration,
          ),
          Container(
            height: 108,
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: AppColor.of.background1,
            ),
            child: Text(
              '자료구조의 기본 개념인 트리(Tree)는 어느정도 이해했지만, 트리의 순회(Traversal) 부분에 대해서는 좀 더 깊이 있는 학습이 필요할 것 같습니다.',
              style: TextStyle(
                fontFamily: 'pretendard',
                leadingDistribution: TextLeadingDistribution.even,
                letterSpacing: -2 / 100 * 13,
                fontSize: 13,
                fontWeight: FontWeight.w500,
                height: 20 / 13,
              ),
            ),
          ),
          const Gap(
            16,
          ),
          SizedBox(
            height: 48,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: SizedBox(
                    child: FilledButton(
                      onPressed: () {
                        context.pop();
                      },
                      style: FilledButton.styleFrom(
                        foregroundColor: AppColor.of.brand3,
                        backgroundColor: AppColor.of.blue1,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 13,
                        ),
                      ),
                      child: Text(
                        '취소',
                        style: AppTextStyle.title1,
                      ),
                    ),
                  ),
                ),
                const Gap(8),
                Expanded(
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 13,
                      ),
                    ),
                    onPressed: () {},
                    child: const Text(
                      '다음',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
