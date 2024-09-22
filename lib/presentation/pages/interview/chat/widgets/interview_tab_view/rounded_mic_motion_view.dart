import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:techtalk/app/style/app_color.dart';
import 'package:techtalk/presentation/pages/interview/chat/constant/recrod_progress_state.dart';
import 'package:techtalk/presentation/pages/interview/chat/providers/speech_to_text_provider.dart';
import 'package:techtalk/presentation/pages/interview/chat/widgets/interview_tab_view/staggered_dot_wave.dart';

class RoundedMicMotionView extends HookConsumerWidget {
  const RoundedMicMotionView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state =
        ref.watch(speechToTextProvider.select((c) => c.progressState));
    return Container(
      height: 112,
      width: 112,
      decoration: BoxDecoration(
        color: AppColor.of.blue1,
        shape: BoxShape.circle,
      ),
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
                          final animationController = useAnimationController(
                            duration: const Duration(milliseconds: 1650),
                          );

                          ref.listen(
                              speechToTextProvider
                                  .select((c) => c.progressState), (prev, now) {
                            if (now.isOnProgress ||
                                !animationController.isAnimating) {
                              animationController.repeat();
                            }
                          });

                          return StaggeredDotsWave(
                            size: 28,
                            color: AppColor.of.white,
                            controller: animationController,
                          );
                        },
                      );
                    case RecordProgressState.loading:
                      return LoadingAnimationWidget.horizontalRotatingDots(
                        color: AppColor.of.white,
                        size: 32,
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
    );
  }
}
