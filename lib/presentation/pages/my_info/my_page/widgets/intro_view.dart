part of '../my_page.dart';

class _IntroView extends ConsumerWidget with MyPageState {
  const _IntroView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String guideText = tr(LocaleKeys.myInfo_stayStrong);

    return user(ref).when(
      data: (user) {
        String nickname = user?.nickname ?? tr(LocaleKeys.common_emptyName);
        String greetingNickname = tr(
          LocaleKeys.undefined_greetingWithNickname,
          namedArgs: {
            'nickname': nickname,
          },
        );
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text.rich(
              TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: greetingNickname,
                    style: TextStyle(
                      color: AppColor.of.brand3,
                    ),
                  ),
                  TextSpan(text: guideText),
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
          RoundProfileImg.createSkeleton(size: 64),
        ],
      ),
      loading: EmptyBox.new,
    );
  }
}
