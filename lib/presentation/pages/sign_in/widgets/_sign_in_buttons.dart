part of '../sign_in_page.dart';

class _SignInButtons extends StatelessWidget with SignInEvent {
  const _SignInButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSignInGoogleButton(),
        const Gap(8),
        _buildSignInAppleButton(),
        const Gap(48),
      ],
    );
  }

  Widget _buildSignInGoogleButton() {
    return Consumer(
      builder: (context, ref, child) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: const Color(0xFFF6F6F9),
            foregroundColor: AppColor.of.gray6,
            textStyle: AppTextStyle.body1,
            padding: EdgeInsets.zero,
          ),
          onPressed: () async => onTapSignInWithGoogle(ref),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 18),
                child: Center(
                  child: Text('Google로 시작하기'),
                ),
              ),
              Positioned(
                left: 24,
                top: 0,
                bottom: 0,
                child: SvgPicture.asset(
                  Assets.iconsGoogleLogo,
                  width: 24,
                  height: 24,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSignInAppleButton() {
    return Consumer(
      builder: (context, ref, child) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: const Color(0xFF09090B),
            foregroundColor: Colors.white,
            textStyle: AppTextStyle.body1,
            padding: EdgeInsets.zero,
          ),
          onPressed: () async => onTapSignInWithApple(ref),
          child: const Stack(
            clipBehavior: Clip.none,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 18),
                child: Center(
                  child: Text('Apple로 시작하기'),
                ),
              ),
              Positioned(
                left: 24,
                top: 0,
                bottom: 0,
                child: Center(
                  child: FaIcon(
                    FontAwesomeIcons.apple,
                    size: 24,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
