import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/features/youtube/index.dart';
import 'package:techtalk/presentation/pages/youtube/detail/providers/youtube_detail_route_arg_provider.dart';
import 'package:techtalk/presentation/pages/youtube/upload_failed/provider/youtube_upload_failed_route_arg_provider.dart';

mixin class YoutubeUploadFailedEvent {
  ///
  /// 하단 버튼이 클릭되었을 때
  ///
  void onBottomFixedBtnTapped(WidgetRef ref) {
    final passedArg = ref.read(youtubeUploadFailedRouteArgProvider);

    if /* 이미 업로드 된 영상 */ (passedArg.type ==
        YoutubeUploadFailedType.alreadyUploaded) {
      final nextArg = YoutubeDetailArg.deeplinkOrHasSingleIdArg(
        contentId: passedArg.contentId!,
      );
      ContentsDetailRoute(nextArg).go(ref.context);

      /// TODO
      /// => 상세 페이지로 이동
    } else /* 그외 경우 */ {
      //// 업로드 페이지
      const YoutubeLinkSubmitRoute().go(ref.context);
    }
  }
}
