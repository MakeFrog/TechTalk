import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/localization/locale_keys.g.dart';
import 'package:techtalk/app/style/index.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/presentation/pages/home/widgets/home_state.dart';

class CheerUpMessageCard extends HookWidget with HomeState {
  const CheerUpMessageCard({super.key});

  @override
  Widget build(BuildContext context) {
    final sparkleAnimationController = useAnimationController(
      duration: 1.seconds,
    );

    useEffect(
      () {
        sparkleAnimationController.loop(
          reverse: true,
        );

        return () {};
      },
      [],
    );

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -15,
            bottom: -11,
            child: SvgPicture.asset(
              Assets.characterBlue04,
              height: 80,
              width: 80,
            ),
          ),
          HookBuilder(
            builder: (context) {
              final bigSparkleHeight = useAnimation<double>(
                Tween<double>(
                  begin: 15,
                  end: 20,
                )
                    .chain(
                      CurveTween(
                        curve: Curves.easeInOut,
                      ),
                    )
                    .animate(sparkleAnimationController),
              );

              return Positioned(
                right: 52,
                top: bigSparkleHeight,
                child: SvgPicture.asset(
                  Assets.imagesSparkle,
                  width: 24,
                ),
              );
            },
          ),
          HookBuilder(
            builder: (context) {
              final smallSparkleHeight = useAnimation<double>(
                Tween<double>(
                  begin: 15,
                  end: 18,
                )
                    .chain(
                      CurveTween(
                        curve: Curves.easeInOut,
                      ),
                    )
                    .animate(sparkleAnimationController),
              );

              return Positioned(
                right: 40,
                top: smallSparkleHeight,
                child: SvgPicture.asset(
                  Assets.imagesSparkle,
                  width: 20,
                  colorFilter: ColorFilter.mode(
                    AppColor.of.brand1,
                    BlendMode.srcIn,
                  ),
                ),
              );
            },
          ),
          Container(
            width: AppSize.to.screenWidth - 108,
            padding: const EdgeInsets.all(24),
            child: Consumer(
              builder: (context, ref, child) {
                return Text(
                  tr(
                    LocaleKeys.home_cheerUpMessage,
                    namedArgs: {
                      'nickname':
                          user(ref)?.nickname ?? LocaleKeys.common_emptyName,
                    },
                  ),
                  style: AppTextStyle.headline2,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
