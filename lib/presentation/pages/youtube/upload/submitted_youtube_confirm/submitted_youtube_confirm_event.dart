import 'dart:async';
import 'dart:developer';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/features/youtube/index.dart';
import 'package:techtalk/presentation/pages/youtube/upload/submitted_youtube_confirm/provider/submitted_youtube_confirm_arg_provider.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

mixin class SubmittedYoutubeConfirmEvent {
  ///
  /// 업로드 버튼 '확인'이 클릭 되었을 때
  ///
  void onConfirmBtnTapped(WidgetRef ref) async {
    final arg = ref.read(submittedYoutubeConfirmArgProvider);
    var targetVide = arg.video;

    /// 자막 정보가 없다면 호출
    if (!arg.hasFetchedMetaInfo) {
      await EasyLoading.show();
      final response =
          await youtubeRepository.getVideoInfoForUpload(targetVide.id);

      unawaited(EasyLoading.dismiss());

      response.fold(
        onSuccess: (video) {
          targetVide = video;
        },
        onFailure: (e) {
          log('sbmitted_youtube_confirm_event : 유튜브 AI 분석 실패 : $e');
          final targetException =
              e is YoutubeUploadException ? e : const YtUnknownException();

          final targetType =
              YoutubeUploadFailedType.getByErrorCode(targetException.code);
          final Video? alreadyUploadedVideo =
              targetException is YtAlreadyUploadedException
                  ? (e as YtAlreadyUploadedException).video
                  : null;

          YoutubeContentUploadFailedRoute(
                  $extra: alreadyUploadedVideo, failedType: targetType)
              .go(ref.context);

          return;
        },
      );
    }

    AnalyzeYoutubeRoute(targetVide).go(ref.context);
  }
}
