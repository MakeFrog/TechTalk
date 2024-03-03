import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/presentation/pages/splash/splash_event.dart';
import 'package:techtalk/presentation/widgets/base/base_page.dart';

class SplashPage extends BasePage with SplashEvent {
  const SplashPage({super.key});

  @override
  void onInit(WidgetRef ref) {
    routeByUserAuthAndData(ref);
  }

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    return Center(
      child: SvgPicture.asset(
        Assets.characterBlue04,
      ),
    );
  }
}
