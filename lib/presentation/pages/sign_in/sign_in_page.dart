import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/localization/locale_keys.g.dart';
import 'package:techtalk/app/style/index.dart';
import 'package:techtalk/core/index.dart';
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
            AppSize.ratioHeight(8),
          ),
          Center(
            child: Text(
              tr(LocaleKeys.onboarding_login_talkTalkWithAiInterviewer),
              textAlign: TextAlign.center,
              style: AppTextStyle.pretendardBoldStyle(24, 33),
            ),
          ),
          Gap(AppSize.ratioHeight(70)),
          SvgPicture.asset(
            Assets.imagesWelcomeTechtalk,
            height: AppSize.ratioWidth(270),
          ),
          const Spacer(),
          GoogleSignInButton(
            onTap: () async => onSocialSignInBtnTapped(
              ref,
              socialAccountProvider: UserAccountProvider.google,
            ),
          ),
          Gap(AppSize.ratioHeight(8)),
          if (Platform.isIOS)
            AppleSignInButton(
              onTap: () async => onSocialSignInBtnTapped(
                ref,
                socialAccountProvider: UserAccountProvider.apple,
              ),
            ),
          Gap(
            AppSize.ratioHeight(
              Platform.isIOS
                  ? AppSize.screenWidth <= 320
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
