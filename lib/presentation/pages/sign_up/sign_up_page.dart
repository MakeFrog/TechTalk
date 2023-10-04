import 'package:flutter/material.dart';
import 'package:techtalk/presentation/pages/sign_up/steps/nickname_input_screen.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [],
      ),
      body: SafeArea(
        child: PageView(
          children: [
            NicknameInputScreen(),
          ],
        ),
      ),
    );
  }
}
