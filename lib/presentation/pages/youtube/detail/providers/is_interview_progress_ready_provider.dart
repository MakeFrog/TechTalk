import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/core/helper/bool_extension.dart';
import 'package:techtalk/presentation/pages/youtube/detail/providers/selected_youtube_qnas_provider.dart';
import 'package:techtalk/presentation/pages/youtube/detail/providers/youtube_detail_route_arg_provider.dart';

part 'is_interview_progress_ready_provider.g.dart';

@Riverpod(dependencies: [youtubeDetailRouteArg, SelectedYoutubeQnas])
class IsInterviewProgressReady extends _$IsInterviewProgressReady {
  @override
  bool build() {
    setListener();
    return true;
  }

  void setListener() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final videoId = ref.read(youtubeDetailRouteArgProvider).contentId;

      final passedQnas = ref.read(youtubeDetailRouteArgProvider).qnas?.toList();

      ref.listen(
          selectedYoutubeQnasProvider(
            videoId,
            passedQnas: passedQnas?.toList(),
          ), (prev, now) {
        if (now.isEmpty && state.isTrue) {
          state = false;
          return;
        }
        if (now.isNotEmpty && state.isFalse) {
          state = true;
          return;
        }
      });
    });
  }
}
