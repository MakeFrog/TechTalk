import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/core/constants/assets.dart';
import 'package:techtalk/core/services/size_service.dart';
import 'package:techtalk/core/theme/extension/app_text_style.dart';
import 'package:techtalk/features/auth/repositories/entities/user_account_provider.enum.dart';
import 'package:techtalk/presentation/pages/sign_in/sign_in_event.dart';
import 'package:techtalk/presentation/pages/sign_in/widgets/apple_sign_in_button.dart';
import 'package:techtalk/presentation/pages/sign_in/widgets/google_sign_in_button.dart';
import 'package:techtalk/presentation/widgets/base/base_page.dart';

class SignInPage extends BasePage with SignInEvent {
  const SignInPage({super.key});

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          SvgPicture.asset(
            Assets.iconsTechTalkLogo,
            width: 114,
          ),
          Gap(
            AppSize.to.ratioHeight(8),
          ),
          Center(
            child: Text(
              'AI 면접관과 준비하는\n개발 면접',
              textAlign: TextAlign.center,
              style: AppTextStyle.pretendardBoldStyle(24, 33),
            ),
          ),
          Gap(AppSize.to.ratioHeight(70)),
          SvgPicture.asset(
            Assets.imagesWelcomeTechtalk,
            height: AppSize.to.ratioWidth(270),
          ),
          const Spacer(),
          GoogleSignInButton(
            onTap: () async => onSocialSignInBtnTapped(
              ref,
              socialAccountProvider: UserAccountProvider.google,
            ),
          ),
          Gap(AppSize.to.ratioHeight(8)),
          if (Platform.isIOS)
            AppleSignInButton(
              onTap: () async => onSocialSignInBtnTapped(
                ref,
                socialAccountProvider: UserAccountProvider.apple,
              ),
            ),
          Gap(
            AppSize.to.ratioHeight(
              Platform.isIOS
                  ? AppSize.to.screenWidth <= 320
                      ? 24
                      : 48
                  : 24,
            ),
          ),
        ],
      ),
    );
  }
}
