import 'dart:developer';

import 'package:flutter/animation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/app/router/navigation_context.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/features/youtube/index.dart';
import 'package:techtalk/presentation/pages/youtube/upload/provider/upload_step_page_controller.dart';
import 'package:techtalk/presentation/pages/youtube/upload/provider/url_input_text_editing_controller_provider.dart';

part 'target_youtube_info_provider.g.dart';

@riverpod
class TargetYoutubeInfo extends _$TargetYoutubeInfo {
  @override
  Future<YoutubeVideoEntity> build() async {
    final videoId = ref.read(urlInputTextEditingControllerProvider).text;
    final response = await youtubeRepository.getVideoInfoForUpload(videoId);
    return response.fold(
      onSuccess: (youtube) async {
        final pageController = ref.read(uploadStepPageControllerProvider);
        await pageController.animateToPage(2,
            duration: const Duration(milliseconds: 200), curve: Curves.easeIn);

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
