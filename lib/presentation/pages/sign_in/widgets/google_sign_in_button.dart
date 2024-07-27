import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:techtalk/app/localization/locale_keys.g.dart';
import 'package:techtalk/app/style/index.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/presentation/widgets/common/gesture/animated_scale_tap.dart';

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({
    super.key,
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AnimatedScaleTap(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: const Color(0xFFF6F6F9),
          foregroundColor: AppColor.of.gray6,
          textStyle: AppTextStyle.body1,
          padding: EdgeInsets.zero,
        ),
        onPressed: () {},
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 18),
              child: Center(
                child: Text(
                  tr(LocaleKeys.onboarding_login_signUpWithGoogle),
                ),
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
    );
  }
}
