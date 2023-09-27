import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:techtalk/core/constants/assets.dart';
import 'package:techtalk/core/theme/extension/app_color.dart';
import 'package:techtalk/core/theme/extension/app_text_style.dart';
import 'package:techtalk/presentation/pages/welcome/widgets/start_with_apple_button.dart';
import 'package:techtalk/presentation/pages/welcome/widgets/start_with_google_button.dart';
import 'package:techtalk/presentation/widgets/common/common.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.of.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            SvgPicture.asset(
              Assets.logoTechTalkLogo,
              width: 114,
            ),
            const HeightBox(8),
            Center(
              child: Text(
                'AI 면접관과 톡톡!',
                style: PretendardTextStyle.highlight,
              ),
            ),
            const HeightBox(70),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: SvgPicture.asset(
                Assets.imagesWelcomeTechtalk,
              ),
            ),
            const HeightBox(80),
            StartWithGoogleButton(),
            HeightBox(8),
            StartWithAppleButton(),
            HeightBox(48),
          ],
        ),
      ),
    );
  }
}
