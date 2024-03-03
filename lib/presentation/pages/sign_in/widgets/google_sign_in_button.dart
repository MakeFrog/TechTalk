import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:techtalk/app/style/index.dart';
import 'package:techtalk/core/index.dart';

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({
    super.key,
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: FilledButton.styleFrom(
        backgroundColor: const Color(0xFFF6F6F9),
        foregroundColor: AppColor.of.gray6,
        textStyle: AppTextStyle.body1,
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
    );
  }
}
