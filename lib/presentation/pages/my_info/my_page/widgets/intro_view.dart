part of '../my_page.dart';

class _IntroView extends ConsumerWidget with MyPageState {
  const _IntroView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const String guideText = '오늘도 열공하세요.';

    return user(ref).when(
      data: (user) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text.rich(
              TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: '${user?.nickname ?? '익명'}님\n',
                    style: TextStyle(
                      color: AppColor.of.brand3,
                    ),
                  ),
                  const TextSpan(text: guideText),
                ],
              ),
              style: AppTextStyle.headline1,
            ),
            RoundProfileImg(
              size: 64,
              imgUrl: user?.profileImgUrl,
            ),
          ],
        );
      },
      error: (e, _) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '\n$guideText',
            style: AppTextStyle.headline1,
          ),
          RoundProfileImg.createSkeleton(size: 64)
        ],
      ),
      loading: EmptyBox.new,
    );
  }
}
