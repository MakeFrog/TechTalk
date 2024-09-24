import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/style/app_color.dart';
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
          child: HookBuilder(
            builder: (context) {
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

              if (state.isOnProgress && !bgAnimationController.isAnimating) {
                bgAnimationController.repeat(reverse: true);
              } else {
                if (bgAnimationController.isAnimating) {
                  Future.microtask(() async {
                    // 원래 크기로 돌아오는것을 기다린 이후 애니메이션 멈춤
                    await bgAnimationController.reverse();
                    bgAnimationController.stop();
                  });
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
                              // AnimationController 설정
                              final animationController =
                                  useAnimationController(
                                duration: const Duration(milliseconds: 1650),
                              );

                              useEffect(() {
                                animationController.repeat();
                                return null;
                              }, []);

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
