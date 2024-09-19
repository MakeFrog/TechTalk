import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/app/style/app_color.dart';
import 'package:techtalk/core/constants/assets.dart';
import 'package:techtalk/presentation/pages/interview/chat/chat_event.dart';
import 'package:techtalk/presentation/pages/interview/chat/chat_state.dart';
import 'package:techtalk/presentation/pages/interview/chat/constant/recrod_progress_state.dart';
import 'package:techtalk/presentation/pages/interview/chat/providers/speech_to_text_provider.dart';
import 'package:techtalk/presentation/pages/interview/chat/widgets/interview_tab_view/staggered_dot_wave.dart';

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/style/app_color.dart';
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
                            duration: const Duration(milliseconds: 1100),
                          );

                          final debouncer =
                              Debouncer(const Duration(milliseconds: 600));

                          ref.listen(
                            speechToTextProvider.select((c) => c.recordedText),
                            (previous, current) {
                              if (current.isNotEmpty) {
                                // 텍스트가 입력되면 애니메이션 반복 실행

                                if (!animationController.isAnimating) {
                                  animationController.repeat();
                                }

                                debouncer.run(() async {
                                  if (animationController.isAnimating) {
                                    // 0.6초 동안 입력이 없으면 애니메이션 중지
                                    await animationController.forward();

                                    animationController.stop();
                                  }
                                });
                              }
                            },
                          );

                          return StaggeredDotsWave(
                            size: 28,
                            color: AppColor.of.white,
                            controller: animationController,
                          );
                        },
                      );
                    // TODO: Handle this case.
                    case RecordProgressState.loadingResult:
                      return LoadingAnimationWidget.horizontalRotatingDots(
                        color: AppColor.of.white,
                        size: 32,
                      );
                    // TODO: Handle this case.
                    case RecordProgressState.recognized:
                      return SvgPicture.asset(state.iconPath);
                    case RecordProgressState.submitMessage:
                    // TODO: Handle this case.
                    case RecordProgressState.errorOccured:
                    // TODO: Handle this case.
                    default:
                      return SizedBox();
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

class Debouncer {
  Duration delay;
  Timer? _timer;

  Debouncer(
    this.delay,
  );

  run(void Function() callback) {
    _timer?.cancel();
    _timer = Timer(delay, callback);
  }

  dispose() {
    _timer?.cancel();
  }
}
