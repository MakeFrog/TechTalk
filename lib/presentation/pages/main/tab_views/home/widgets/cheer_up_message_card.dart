import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -15.w,
            bottom: -11.h,
            child: SvgPicture.asset(
              Assets.imagesTechTalkCharacterBlue04,
              height: 80.r,
              width: 80.r,
            ),
          ),
          HookBuilder(
            builder: (context) {
              final bigSparkleHeight = useAnimation<double>(
                Tween<double>(
                  begin: 15.h,
                  end: 20.h,
                )
                    .chain(
                      CurveTween(
                        curve: Curves.easeInOut,
                      ),
                    )
                    .animate(sparkleAnimationController),
              );

              return Positioned(
                right: 52.w,
                top: bigSparkleHeight,
                child: SvgPicture.asset(
                  Assets.imagesSparkle,
                  width: 24.w,
                ),
              );
            },
          ),
          HookBuilder(
            builder: (context) {
              final smallSparkleHeight = useAnimation<double>(
                Tween<double>(
                  begin: 15.h,
                  end: 18.h,
                )
                    .chain(
                      CurveTween(
                        curve: Curves.easeInOut,
                      ),
                    )
                    .animate(sparkleAnimationController),
              );

              return Positioned(
                right: 40.w,
                top: smallSparkleHeight,
                child: SvgPicture.asset(
                  Assets.imagesSparkle,
                  width: 20.w,
                  colorFilter: ColorFilter.mode(
                    AppColor.of.brand1,
                    BlendMode.srcIn,
                  ),
                ),
              );
            },
          ),
          Padding(
            padding: EdgeInsets.all(24.r),
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
