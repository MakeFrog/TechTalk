import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_apple/firebase_ui_oauth_apple.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:techtalk/core/theme/extension/app_text_style.dart';

class StartWithAppleButton extends StatelessWidget {
  const StartWithAppleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: AuthStateListener<OAuthController>(
        listener: (oldState, newState, controller) {
          print(newState);
          if (newState is SignedIn) {
            // navigate to other screen.
          }
        },
        child: AuthFlowBuilder<OAuthController>(
          provider: AppleProvider(),
          builder: (context, state, ctrl, child) {
            return FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFF09090B),
                foregroundColor: const Color(0xFFFFFFFF),
                textStyle: PretendardTextStyle.body1,
                padding: EdgeInsets.zero,
              ),
              onPressed: () async {
                // ctrl.signIn(defaultTargetPlatform);
                await FirebaseAuth.instance.signOut();
              },
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
            );
          },
        ),
      ),
    );
  }
}
