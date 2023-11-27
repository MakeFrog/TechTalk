part of '../sign_in_page.dart';

class _WelcomeBanner extends StatelessWidget {
  const _WelcomeBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          Assets.logoTechTalkLogo,
          width: 114,
        ),
        const Gap(8),
        Center(
          child: Text(
            'AI 면접관과 톡톡!',
            style: AppTextStyle.pretendardBoldStyle(24, 33),
          ),
        ),
        const Gap(70),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: SvgPicture.asset(
            Assets.imagesWelcomeTechtalk,
          ),
        ),
      ],
    );
  }
}
