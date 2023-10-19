import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/core/theme/extension/app_text_style.dart';
import 'package:techtalk/presentation/pages/sign_in/sign_in_event.dart';

class StartWithAppleButton extends ConsumerWidget with SignInEvent {
  const StartWithAppleButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: const Color(0xFF09090B),
          foregroundColor: const Color(0xFFFFFFFF),
          textStyle: AppTextStyle.body1,
          padding: EdgeInsets.zero,
        ),
        onPressed: () async {
          await onTapSignInWithApple(ref);
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
      ),
    );
  }
}
