import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/app/router/navigation_context.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/features/youtube/index.dart';
import 'package:techtalk/presentation/pages/youtube/upload/youtube_link_submit/provider/youtube_link_input_controller_provider.dart';

part 'submitted_youtube_info_provider.g.dart';

@riverpod
class SubmittedYoutubeInfo extends _$SubmittedYoutubeInfo {
  @override
  Future<YoutubeVideoEntity> build() async {
    final videoId = ref.read(youtubeLinkInputControllerProvider).text;
    final response = await youtubeRepository.getVideoInfoForUpload(videoId);
    return response.fold(
      onSuccess: (youtube) async {
        return youtube;
      },
      onFailure: (e) async {
        log('유튜브 explore 데이터 호출 실패');

        final targetException =
            e is YoutubeUploadException ? e : const YtUnknownException();

        final targetFailedType =
            YoutubeUploadFailedType.getByErrorCode(targetException.code);

        /// 이미 업로드된 영상이라 떨어진 exception 이라면
        /// exception에서 콘텐츠 id를 반환
        final targetContentId = targetFailedType.isAlreadyUploaded
            ? (targetException as YtAlreadyUploadedException).contentId
            : null;

        /// 실패 페이지로 이동
        YoutubeContentUploadFailedRoute(
                contentId: targetContentId, failedType: targetFailedType)
            .go(await navigationContext);

        throw e;
      },
    );
  }
}
