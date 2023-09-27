import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:techtalk/core/constants/assets.dart';
import 'package:techtalk/core/theme/extension/app_text_style.dart';

class StartWithGoogleButton extends StatelessWidget {
  const StartWithGoogleButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: const Color(0xFFF6F6F9),
          foregroundColor: const Color(0xFF282831),
          textStyle: PretendardTextStyle.body1,
          padding: EdgeInsets.zero,
        ),
        onPressed: () async {
          GoogleSignIn googleSignIn = GoogleSignIn(
            scopes: [
              'email',
              'https://www.googleapis.com/auth/contacts.readonly',
            ],
          );

          try {
            await googleSignIn.signIn();
          } catch (error) {
            print(error);
          }
        },
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
    );
  }
}
