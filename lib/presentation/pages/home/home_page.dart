import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/core/core.dart';
import 'package:techtalk/core/theme/extension/app_color.dart';
import 'package:techtalk/presentation/pages/home/widgets/cheer_up_message_card.dart';
import 'package:techtalk/presentation/providers/app_user_data_provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 회원가입을 완료하지 않고 홈으로 접속 시 회원가입 페이지로 이동하기 위한 listener
    ref.listen(appUserDataProvider, (_, next) {
      if (next.valueOrNull != null) {
        if (!next.requireValue!.isCompleteSignUp) {
          const SignUpRoute().go(context);
        }
      }
    });

    return Scaffold(
      backgroundColor: AppColor.of.background1,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: false,
        title: SvgPicture.asset(
          Assets.logoTechTalkLogo,
          height: 26,
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 8),
        children: [
          CheerUpMessageCard(),
          Center(
            child: Text('test'),
          ),
        ],
      ),
    );
  }
}
