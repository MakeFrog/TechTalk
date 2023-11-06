import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/core/core.dart';
import 'package:techtalk/presentation/providers/app_user_auth_provider.dart';
import 'package:techtalk/presentation/providers/app_user_data_provider.dart';

class SplashPage extends HookConsumerWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(
      () {
        Future.delayed(1.seconds).then((value) async {
          final isLoggedIn = ref.read(isUserAuthorizedProvider);

          if (!isLoggedIn) {
            const SignInRoute().go(context);
          } else {
            await ref
                .read(
              appUserDataProvider.selectAsync((data) => data != null),
            )
                .then((hasUserData) {
              if (hasUserData) {
                const TestPageRoute().go(context);

                // const MainRoute().go(context);
              } else {
                const TestPageRoute().go(context);

                // const SignUpRoute().go(context);
              }
            });
          }
        });

        return () {};
      },
      [],
    );

    return Scaffold(
      body: Center(
        child: SvgPicture.asset(
          Assets.imagesTechTalkCharacterBlue04,
        ),
      ),
    );
  }
}
