import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/core/constants/assets.dart';
import 'package:techtalk/core/theme/extension/app_color.dart';
import 'package:techtalk/core/theme/extension/app_text_style.dart';
import 'package:techtalk/presentation/pages/sign_in/widgets/start_with_apple_button.dart';
import 'package:techtalk/presentation/pages/sign_in/widgets/start_with_google_button.dart';
import 'package:techtalk/presentation/widgets/common/common.dart';

class SignInPage extends ConsumerWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
          SvgPicture.asset(
            Assets.logoTechTalkLogo,
            width: 114,
          ),
          const HeightBox(8),
          Center(
            child: Text(
              'AI 면접관과 톡톡!',
              style: AppTextStyle.boldBaseStyle(24, 33),
            ),
          ),
          const HeightBox(70),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: SvgPicture.asset(
              Assets.imagesWelcomeTechtalk,
            ),
          ),
          const Spacer(),
          const StartWithGoogleButton(),
          const HeightBox(8),
          const StartWithAppleButton(),
          const HeightBox(48),
        ],
      ),
    );
  }
}
