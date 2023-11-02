import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/core/core.dart';
import 'package:techtalk/presentation/pages/splash/splash_event.dart';

class SplashPage extends HookConsumerWidget with SplashEvent {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(
      () {
        Future.delayed(3.seconds).then((value) async {
          await initUserAuthAndData(ref);
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
