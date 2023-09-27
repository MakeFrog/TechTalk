import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:techtalk/src/core/constants/assets.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F6F9),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              Assets.logoTechTalkLogo,
            ),
            Text('test'),
          ],
        ),
      ),
    );
  }
}
