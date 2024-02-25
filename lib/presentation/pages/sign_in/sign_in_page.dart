import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/core/constants/assets.dart';
import 'package:techtalk/core/theme/extension/app_color.dart';
import 'package:techtalk/core/theme/extension/app_text_style.dart';
import 'package:techtalk/presentation/pages/sign_in/sign_in_event.dart';
import 'package:techtalk/presentation/widgets/common/button/apple_sign_in_button.dart';
import 'package:techtalk/presentation/widgets/common/button/google_sign_in_button.dart';

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

class _Body extends ConsumerWidget with SignInEvent {
  const _Body({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
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
            const Spacer(),
            GoogleSignInButton(
              onTap: () async => onTapSignInWithGoogle(ref),
            ),
            const Gap(8),
            if (Platform.isIOS)
              AppleSignInButton(
                onTap: () async => onTapSignInWithApple(ref),
              ),
            Gap(Platform.isIOS ? 48 : 24),
          ],
        ),
      ),
    );
  }
}
