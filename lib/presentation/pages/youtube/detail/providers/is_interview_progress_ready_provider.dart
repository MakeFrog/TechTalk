import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/presentation/pages/youtube/detail/providers/youtube_content_qna_provider.dart';
import 'package:techtalk/presentation/pages/youtube/detail/providers/youtube_detail_route_arg_provider.dart';

part 'is_interview_progress_ready_provider.g.dart';

@Riverpod(dependencies: [youtubeDetailRouteArg, YoutubeContentQna])
class IsInterviewProgressReady extends _$IsInterviewProgressReady {
  @override
  bool build() {
    final arg = ref.read(youtubeDetailRouteArgProvider);

    final async = ref.watch(youtubeContentQnaProvider(
      contentId: arg.contentId,
    ));

    if (async.isLoading) return true;
    return async.value?.any((e) => e.isSelected) ?? true;
  }
}
