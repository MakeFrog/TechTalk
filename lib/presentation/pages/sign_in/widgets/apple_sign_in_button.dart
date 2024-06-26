import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:techtalk/app/style/index.dart';
import 'package:techtalk/presentation/widgets/common/gesture/animated_scale_tap.dart';

class AppleSignInButton extends StatelessWidget {
  const AppleSignInButton({
    super.key,
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AnimatedScaleTap(
      borderRadius: BorderRadius.circular(16),
      child: FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: const Color(0xFF09090B),
          foregroundColor: Colors.white,
          textStyle: AppTextStyle.body1,
          padding: EdgeInsets.zero,
        ),
        onPressed: onTap,
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
