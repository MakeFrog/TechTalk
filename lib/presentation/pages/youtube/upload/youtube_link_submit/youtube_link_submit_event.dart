import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/app/util/app_logger.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/youtube/index.dart';
import 'package:techtalk/presentation/pages/youtube/upload/submitted_youtube_confirm/provider/submitted_youtube_confirm_arg_provider.dart';
import 'package:techtalk/presentation/pages/youtube/upload/youtube_link_submit/provider/youtube_link_input_controller_provider.dart';
import 'package:url_launcher/url_launcher.dart';

mixin class YoutubeLinkSubmitEvent {
  ///
  /// 유튜브 링크 가져오기 버튼이 클릭 되었을 때
  ///
  Future<void> onGetYoutubeBtnTapped() async {
    try {
      await launchUrl(
        Uri.parse('https://www.youtube.com'),
        mode: LaunchMode.externalApplication,
      );
    } catch (e) {
      logger.e(e);
      SnackBarService.showSnackBar('유튜브를 열지 못했어요. 잠시 후 다시 시도해주세요');
    }
  }

  ///
  ///  '다음(확인)' 버튼이 클릭되었을 때
  ///
  Future<void> onConfirmBtnTapped(WidgetRef ref) async {
    FocusScope.of(ref.context).unfocus();
    await EasyLoading.show();
    final targetLink = ref.read(youtubeLinkInputControllerProvider).text;
    final response = await youtubeRepository.getVideoInfoForUpload(targetLink);
    await EasyLoading.dismiss();

    response.fold(
      /// 입력된 유튜브 확인 페이지로 이동
      onSuccess: (video) {
        SubmittedYoutubeConfirmRoute(
          SubmittedYoutubeConfirmArg.fromNormalFlow(video: video),
        ).push(ref.context);
      },

      /// 실패 시 실패 화면으로 이동
      onFailure: (e) {
        log('youtube_link_submit_event : 유튜브 AI 분석 실패 : $e');
        final targetException =
            e is YoutubeUploadException ? e : const YtUnknownException();

        final targetType =
            YoutubeUploadFailedType.getByErrorCode(targetException.code);
        final String? targetCardId =
            targetException is YtAlreadyUploadedException
                ? (e as YtAlreadyUploadedException).contentId
                : null;

        YoutubeContentUploadFailedRoute(
                contentId: targetCardId, failedType: targetType)
            .go(ref.context);
      },
    );
  }
}
