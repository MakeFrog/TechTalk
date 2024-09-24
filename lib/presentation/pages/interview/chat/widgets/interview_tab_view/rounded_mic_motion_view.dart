import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/style/app_color.dart';
import 'package:techtalk/core/helper/debouncer.dart';
import 'package:techtalk/presentation/pages/interview/chat/constant/recrod_progress_state.dart';
import 'package:techtalk/presentation/pages/interview/chat/providers/speech_to_text_provider.dart';
import 'package:techtalk/presentation/pages/interview/chat/widgets/interview_tab_view/horizon_roating_dots.dart';
import 'package:techtalk/presentation/pages/interview/chat/widgets/interview_tab_view/staggered_dot_wave.dart';

class RoundedMicMotionView extends HookConsumerWidget {
  const RoundedMicMotionView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state =
        ref.watch(speechToTextProvider.select((c) => c.progressState));
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        /// 메인 녹음 버튼 Background / 애니메이션을 조건에 따라 실행
        Positioned(
          child: HookConsumer(
            builder: (context, ref, _) {
              final bgAnimationController = useAnimationController(
                duration: const Duration(milliseconds: 1000),
                vsync: useSingleTickerProvider(),
              );

              final scale = Tween<double>(begin: 1, end: 1.1464).animate(
                CurvedAnimation(
                  parent: bgAnimationController,
                  curve: Curves.easeInOut,
                ),
              );

              void stopAnimation() {
                Future.microtask(() async {
                  // 원래 크기로 돌아오는것을 기다린 이후 애니메이션 멈춤
                  await bgAnimationController.reverse();
                  bgAnimationController.stop();
                });
              }

              if (state.isOnProgress && !bgAnimationController.isAnimating) {
                ref.listen(speechToTextProvider.select((p) => p.notifyText),
                    (prev, now) {
                  if (now.isNotEmpty) {
                    // 텍스트가 입력되면 애니메이션 반복 실행

                    if (!bgAnimationController.isAnimating) {
                      bgAnimationController.repeat(reverse: true);
                    }

                    ref
                        .read(speechToTextProvider.select((p) => p.debouncer))
                        .run(() async {
                      if (bgAnimationController.isAnimating) {
                        // 0.6초 동안 입력이 없으면 애니메이션 중지
                        stopAnimation();
                      }
                    });
                  }
                });
              } else {
                if (bgAnimationController.isAnimating) {
                  stopAnimation();
                }
              }

              return AnimatedBuilder(
                animation: bgAnimationController,
                builder: (BuildContext context, Widget? child) {
                  return Transform.scale(
                    scale: scale.value,
                    child: Container(
                      height: 120, // 원하는 최종 높이 설정
                      width: 120, // 원하는 최종 너비 설정
                      decoration: BoxDecoration(
                        color: AppColor.of.blue1, // 원하는 색상으로 변경
                        shape: BoxShape.circle,
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
        SizedBox(
          height: 112,
          width: 112,
          child: Center(
            child: Container(
              height: 88,
              width: 88,
              decoration: BoxDecoration(
                color: state.color,
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 12,
                    offset: Offset(0, 2),
                    color: Color.fromRGBO(217, 200, 239, 59),
                  )
                ],
                shape: BoxShape.circle,
              ),
              child: SizedBox(
                child: Center(
                  child: Builder(
                    builder: (context) {
                      switch (state) {
                        case RecordProgressState.initial:
                          return SvgPicture.asset(
                            state.iconPath,
                            height: 40,
                            width: 40,
                            colorFilter: ColorFilter.mode(
                              AppColor.of.brand3,
                              BlendMode.srcIn,
                            ),
                          );
                        case RecordProgressState.ready ||
                              RecordProgressState.onProgress:
                          return HookConsumer(
                            builder: (context, ref, _) {
                              final debouncer = Debouncer(const Duration(milliseconds: 500));

                              // AnimationController 설정
                              final animationController =
                                  useAnimationController(
                                duration: const Duration(milliseconds: 1650),
                              );


                              ref.listen(
                                  speechToTextProvider.select(
                                      (p) => p.notifyText), (prev, now) {
                                if (now.isNotEmpty) {
                                  // 텍스트가 입력되면 애니메이션 반복 실행

                                  if (!animationController.isAnimating) {
                                    animationController.repeat();
                                  }

                                  debouncer
                                      .run(() async {
                                    if (animationController.isAnimating) {
                                      await animationController.forward();
                                      animationController.stop();
                                    }
                                  });
                                }
                              });

                              return StaggeredDotsWave(
                                size: 24,
                                color: AppColor.of.white,
                                controller: animationController,
                              );
                            },
                          );
                        case RecordProgressState.loading:
                          return HorizontalRotatingDots(
                            color: AppColor.of.white,
                            size: 30,
                          );

                        default:
                          return SvgPicture.asset(
                            state.iconPath,
                            height: 40,
                            width: 40,
                            colorFilter: ColorFilter.mode(
                              AppColor.of.brand3,
                              BlendMode.srcIn,
                            ),
                          );
                      }
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
