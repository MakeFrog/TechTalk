import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:techtalk/core/constants/assets.dart';
import 'package:techtalk/core/theme/extension/app_text_style.dart';

class StartWithGoogleButton extends StatelessWidget {
  const StartWithGoogleButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AuthFlowBuilder<OAuthController>(
      provider: GoogleProvider(
        clientId: 'clientId',
      ),
      listener: (oldState, newState, controller) {},
      builder: (context, state, ctrl, child) {
        return _buildButton(
          onTap: () async {
            if (ctrl.auth.currentUser != null) {
              print(ctrl.auth.currentUser);
              return;
            }

            ctrl.signIn(defaultTargetPlatform);
          },
        );
      },
    );
  }

  Widget _buildButton({
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: const Color(0xFFF6F6F9),
          foregroundColor: const Color(0xFF282831),
          textStyle: PretendardTextStyle.body1,
          padding: EdgeInsets.zero,
        ),
        onPressed: onTap,
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
