import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:techtalk/core/constants/assets.dart';
import 'package:techtalk/core/theme/extension/app_color.dart';
import 'package:techtalk/core/theme/extension/app_text_style.dart';
import 'package:techtalk/presentation/pages/sign_in/widgets/start_with_apple_button.dart';
import 'package:techtalk/presentation/pages/sign_in/widgets/start_with_google_button.dart';
import 'package:techtalk/presentation/widgets/common/common.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.of.white,
      body: const _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          _buildWelcomeSection(),
          const Spacer(),
          _buildSignInButtonSection(),
        ],
      ),
    );
  }

  Widget _buildWelcomeSection() {
    return Column(
      children: [
        SvgPicture.asset(
          Assets.logoTechTalkLogo,
          width: 114,
        ),
        const HeightBox(8),
        Center(
          child: Text(
            'AI 면접관과 톡톡!',
            style: AppTextStyle.pretendardBoldStyle(24, 33),
          ),
        ),
        const HeightBox(70),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: SvgPicture.asset(
            Assets.imagesWelcomeTechtalk,
          ),
        ),
      ],
    );
  }

  Widget _buildSignInButtonSection() {
    return const Column(
      children: [
        StartWithGoogleButton(),
        HeightBox(8),
        StartWithAppleButton(),
        HeightBox(48),
      ],
    );
  }
}
