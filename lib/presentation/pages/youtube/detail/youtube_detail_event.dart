import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/chat/repositories/entities/chat_room_entity.dart';
import 'package:techtalk/features/chat/repositories/entities/youtube_qna_entity.dart';
import 'package:techtalk/features/youtube/index.dart';
import 'package:techtalk/features/youtube/repositories/entities/youtube_related_vido_entity.dart';
import 'package:techtalk/presentation/pages/youtube/detail/providers/is_bookmark_checked_provider.dart';
import 'package:techtalk/presentation/pages/youtube/detail/providers/selected_youtube_qnas_provider.dart';
import 'package:techtalk/presentation/pages/youtube/detail/providers/youtube_detail_ressource_provider.dart';
import 'package:techtalk/presentation/pages/youtube/detail/providers/youtube_detail_route_arg_provider.dart';
import 'package:techtalk/presentation/pages/youtube/upload/submitted_youtube_confirm/provider/submitted_youtube_confirm_arg_provider.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

mixin class YoutubeDetailEvent {
  ///
  /// 북마크 버튼이 탭 되었을 때
  ///
  void onBookmarkBtnTapped(WidgetRef ref) {
    ref.read(isBookmarkCheckedProvider.notifier).toggle();
  }

  ///
  /// 요약노트 > 타임 스탬프 버튼이 클릭 되었을 때
  ///
  Future<void> onTimeStampTapped(
    WidgetRef ref, {
    required Duration? timeStamp,
  }) async {
    if (timeStamp == null) {
      SnackBarService.showSnackBar('해당 위치로 이동하지 못했어요');
      return;
    }
    try {
      final videoId = ref.read(youtubeDetailRouteArgProvider).contentId;
      final youtubeController = ref.read(youtubeDetailResourceProvider(videoId)
          .select((p) => p.youtubeController));
      await youtubeController.seekTo(
          seconds: timeStamp.inSeconds.toDouble(), allowSeekAhead: true);
    } catch (e) {
      log('seek 이동 실패 : $e');
    }
  }

  ///
  /// 면접 시작하기 버튼이 클릭 되었을 떄
  ///
  Future<void> onStartInterviewBtnTapped(WidgetRef ref) async {
    // final videoId = ref
    //     .read(youtubeDetailRouteArgProvider)
    //     .contentId;
    // final youtubeController = ref.read(youtubeDetailResourceProvider(videoId)
    //     .select((p) => p.youtubeController));
    //
    // youtubeController
    // .
    //
    // await youtubeController.cueVideoByUrl(
    // mediaContentUrl: "http://www.youtube.com/v/${videoId}?version=5",
    // startSeconds: 10,
    // endSeconds: 30,
    // );

    return;
    final room = ChatRoomEntity.generateResumeInterview(
      qnas: [],
    );

    final route = ChatPageRoute(roomId: room.id, type: room.type);
    route.updateArg(room: room);
    route.go(ref.context);
  }

  ///
  /// 화면 회전을 막는 설정
  /// YoutubePlayer의 '전체 화면' 기능으로
  /// 페이지 진입하거나 이탈 할 때 Portrait이 가로로 강제되는 경우가 있음
  /// 이를 방지하고자 아래 메소드를 사용
  ///
  /// 아마 웹뷰에 캐시가 남아 있는것으로 예상됨
  ///
  void setOrientation() {
    Future.microtask(() async {
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    });
  }

  ///
  /// 문답 박스가 클릭 되었을 때
  /// 선택 여부 토글
  ///
  void onQnaBoxTapped(WidgetRef ref, {required YoutubeQnaEntity qna}) {
    final videoId = ref.read(youtubeDetailRouteArgProvider).contentId;
    ref.read(selectedYoutubeQnasProvider(videoId).notifier).toggle(qna);
  }

  ///
  /// 문답 박스 전체 선택
  ///
  void onAllSelectBtnTapped(WidgetRef ref) {
    final videoId = ref.read(youtubeDetailRouteArgProvider).contentId;
    ref.read(selectedYoutubeQnasProvider(videoId).notifier).activateAll();
  }

  Future<void> onRelatedVideoTapped(WidgetRef ref,
      {required RelatedVideoEntity video}) async {
    final response =
        await youtubeRepository.isUploadedContent(videoId: video.id);

    response.fold(
      onSuccess: (isUploadedContent) {
        if (isUploadedContent) {
          final arg =
              YoutubeDetailArg.deeplinkOrHasSingleIdArg(contentId: video.id);
          ContentsDetailRoute(arg).push(ref.context);
        } else {
          final arg = SubmittedYoutubeConfirmArg.fromContentAccessFlow(
              video: YoutubeVideoEntity.fromRelatedVideoEntity(video));
          SubmittedYoutubeConfirmRoute(arg).push(ref.context);
        }
      },
      onFailure: (e) {
        log('Youtube Detail > $e');
      },
    );
  }
}

extension YoutubePlayerControllerEx on YoutubePlayerController {
  /// Due to a bug we are converting the videoid to url
  static fromVideoIdd({
    required String videoId,
    YoutubePlayerParams params = const YoutubePlayerParams(),
    bool autoPlay = false,
    double? startSeconds,
    double? endSeconds,
  }) {
    final controller = YoutubePlayerController(params: params);
    final url = 'http://www.youtube.com/v/$videoId';
    if (autoPlay) {
      controller.loadVideoByUrl(
        mediaContentUrl: url,
        startSeconds: startSeconds,
        endSeconds: endSeconds,
      );
    } else {
      controller.cueVideoByUrl(
        mediaContentUrl: url,
        startSeconds: startSeconds,
        endSeconds: endSeconds,
      );
    }

    return controller;
  }
}
