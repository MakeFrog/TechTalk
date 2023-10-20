import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/core/core.dart';
import 'package:techtalk/core/theme/extension/app_color.dart';
import 'package:techtalk/core/theme/extension/app_text_style.dart';
import 'package:techtalk/presentation/providers/app_user_data_provider.dart';

class CheerUpMessageCard extends HookWidget {
  const CheerUpMessageCard({super.key});

  @override
  Widget build(BuildContext context) {
    final sparkleAnimationController = useAnimationController(
      duration: 1.seconds,
    );
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
      margin: EdgeInsets.symmetric(horizontal: 16),
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
              Assets.imagesTechTalkCharacterBlue04,
              height: 80,
            ),
          ),
          Positioned(
            right: 50,
            top: bigSparkleHeight,
            child: SvgPicture.asset(
              Assets.imagesSparkle,
            ),
          ),
          Positioned(
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
          ),
          Padding(
            padding: EdgeInsets.all(24),
            child: Consumer(
              builder: (context, ref, child) {
                final userName =
                    ref.watch(appUserDataProvider).valueOrNull?.nickname;

                return Text(
                  '${userName ?? ''}님!\n테크톡이 항상 응원해요!',
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
