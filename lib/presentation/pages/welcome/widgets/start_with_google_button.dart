import 'package:flutter/material.dart';
import 'package:techtalk/core/theme/extension/app_text_style.dart';

class StartWithGoogleButton extends StatelessWidget {
  const StartWithGoogleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: Color(0xFFF6F6F9),
          foregroundColor: Color(0xFF282831),
          textStyle: PretendardTextStyle.body1,
        ),
        onPressed: () {},
        child: Center(
          child: Text('Google로 시작하기'),
        ),
      ),
    );
  }
}
