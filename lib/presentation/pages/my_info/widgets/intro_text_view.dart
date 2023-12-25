part of '../my_info_page.dart';

class _IntroView extends ConsumerWidget {
  const _IntroView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text.rich(
          TextSpan(
            children: <TextSpan>[
              TextSpan(
                text: '심야님\n',
                style: TextStyle(
                  color: AppColor.of.brand3,
                ),
              ),
              const TextSpan(text: '오늘도 열공하세요.'),
            ],
          ),
          style: AppTextStyle.headline1,
        ),
        RoundProfileImg(
          size: 64,
          imgUrl:
              'https://avatars.githubusercontent.com/u/75591730?s=400&u=0dca73bd36282a4126c9e4ac25876b90c63829b6&v=4',
        ),
      ],
    );
  }
}
