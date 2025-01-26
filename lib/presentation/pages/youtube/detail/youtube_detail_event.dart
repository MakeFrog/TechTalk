import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/app/util/app_logger.dart';
import 'package:techtalk/features/chat/repositories/entities/chat_room_entity.dart';
import 'package:techtalk/features/chat/repositories/entities/youtube_qna_entity.dart';
import 'package:techtalk/features/user/user.dart';
import 'package:techtalk/features/youtube/index.dart';
import 'package:techtalk/features/youtube/repositories/entities/video_overview_entity.dart';
import 'package:techtalk/presentation/pages/youtube/channel_detail/provider/channel_detail_route_arg_provider.dart';
import 'package:techtalk/presentation/pages/youtube/detail/providers/is_bookmark_checked_provider.dart';
import 'package:techtalk/presentation/pages/youtube/detail/providers/selected_youtube_qnas_provider.dart';
import 'package:techtalk/presentation/pages/youtube/detail/providers/youtube_detail_route_arg_provider.dart';
import 'package:techtalk/presentation/pages/youtube/detail/providers/youtube_player_provider.dart';
import 'package:techtalk/presentation/pages/youtube/detail/youtube_detail_state.dart';
import 'package:techtalk/presentation/pages/youtube/upload/submitted_youtube_confirm/provider/submitted_youtube_confirm_arg_provider.dart';
import 'package:techtalk/presentation/widgets/common/common.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

mixin class YoutubeDetailEvent {
  ///
  /// 북마크 버튼이 탭 되었을 때
  ///
  void onBookmarkBtnTapped(WidgetRef ref) {
    final contentId = ref.read(youtubeDetailRouteArgProvider).contentId;
    ref.read(isBookmarkCheckedProvider(contentId).notifier).toggle();
  }

  ///
  /// 요약 노트 > ListTile이 클릭 되었을 때
  ///
  Future<void> onSummaryListTileItemTapped(
    WidgetRef ref, {
    required Duration? timestamp,
    required ValueNotifier<bool> isExpanded,
    required ValueNotifier<int?> selectedIndex,
    required int currentIndex,
  }) async {
    final isSelected = selectedIndex.value == currentIndex;
    isExpanded.value = !isExpanded.value;

    /// 1. 재생 시점으로 이동
    /// 2. timestamp 토글
    /// 3. ListTie Expand 값 조정

    if (!isSelected && isExpanded.value) {
      selectedIndex.value = currentIndex;

      await _seekToTimestamp(ref, timestamp: timestamp);
    }

    /// timeStampe 토글
  }

  ///
  /// 특정 타임스탬프로 영상 재생
  ///
  Future<void> _seekToTimestamp(WidgetRef ref,
      {required Duration? timestamp}) async {
    final isPlayerCued = YoutubeDetailState().hasYoutubePlayerCued(ref);
    if (!isPlayerCued) {
      AppDialog.singleBtn(
        title: '영상 재생을 가디리고 있어요',
        onBtnClicked: () {
          ref.context.pop();
        },
        showContentImg: false,
      );
      return;
    }
    try {
      final videoId = ref.read(youtubeDetailRouteArgProvider).contentId;
      final youtubeController = ref.read(
          youtubePlayerProvider(videoId).select((p) => p.youtubeController));
      await youtubeController.seekTo(
          seconds: (timestamp?.inSeconds ?? 0).toDouble(),
          allowSeekAhead: true);
    } catch (e) {
      log('seek 이동 실패 : $e');
    }
  }

  ///
  /// 요약노트 > 타임 스탬프 버튼이 클릭 되었을 때
  ///
  Future<void> onTimeStampTapped(
    WidgetRef ref, {
    required Duration? timeStamp,
  }) async {
    final isPlayerCued = YoutubeDetailState().hasYoutubePlayerCued(ref);
    if (!isPlayerCued) {
      AppDialog.singleBtn(
        title: '영상 재생을 가디리고 있어요',
        onBtnClicked: () {
          ref.context.pop();
        },
        showContentImg: false,
      );
      return;
    }
    if (timeStamp == null) {
      return;
    }
    try {
      final videoId = ref.read(youtubeDetailRouteArgProvider).contentId;
      final youtubeController = ref.read(
          youtubePlayerProvider(videoId).select((p) => p.youtubeController));
      await youtubeController.seekTo(
          seconds: timeStamp.inSeconds.toDouble(), allowSeekAhead: true);
    } catch (e) {
      log('seek 이동 실패 : $e');
    }
  }

  ///
  /// 채널 영역이 클릭 되었을 때
  ///
  void onChannelSectionTapped(WidgetRef ref, {required ChannelEntity channel}) {
    final contentId = ref.read(youtubeDetailRouteArgProvider).contentId;
    final arg =
        ChannelDetailRouteArg(channel: channel, currentContentId: contentId);
    ChannelDetailRoute(arg).push(ref.context);
  }

  ///
  /// 면접 시작하기 버튼이 클릭 되었을 떄
  ///
  Future<void> onStartInterviewBtnTapped(WidgetRef ref) async {
    final videoId = ref.read(youtubeDetailRouteArgProvider).contentId;

    final passedQnas = ref.read(youtubeDetailRouteArgProvider).qnas?.toList();

    final selectedQnas = ref.read(selectedYoutubeQnasProvider(
      videoId,
      passedQnas: passedQnas ?? null,
    ));

    final room = ChatRoomEntity.generateYoutubeInterview(
      qnas: selectedQnas,
    );

    final route = ChatPageRoute(roomId: room.id, type: room.type);
    route.updateArg(room: room);
    route.push(ref.context);
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

    final passedQnas = ref.read(youtubeDetailRouteArgProvider).qnas?.toList();

    ref
        .read(selectedYoutubeQnasProvider(
          videoId,
          passedQnas: passedQnas ?? null,
        ).notifier)
        .toggle(qna);
  }

  ///
  /// 문답 박스 전체 선택
  ///
  void onAllSelectBtnTapped(WidgetRef ref) {
    final videoId = ref.read(youtubeDetailRouteArgProvider).contentId;
    final passedQnas = ref.read(youtubeDetailRouteArgProvider).qnas;
    ref
        .read(selectedYoutubeQnasProvider(
          videoId,
          passedQnas: passedQnas?.toList() ?? null,
        ).notifier)
        .activateAll();
  }

  Future<void> onRelatedVideoTapped(WidgetRef ref,
      {required VideoOverviewEntity video}) async {
    final response =
        await youtubeRepository.isUploadedContent(videoId: video.id);

    response.fold(
      onSuccess: (isUploadedContent) {
        if (isUploadedContent) {
          final arg = YoutubeDetailArg.deeplinkOrHasSingleIdArg(
            contentId: video.id,
            thumbnailImage: video.thumbnailImgUrl,
          );

          /// 이전에 스택이 있는 페이지라면
          /// 해당 라우트를 제거
          if (_isContentIdInPreviousRoutes(ref.context, arg.contentId)) {
            final goRouter = GoRouter.of(ref.context);
            // 스택에서 해당 라우트 제거
            goRouter.routerDelegate.currentConfiguration.matches
                .removeWhere((match) {
              final uri = Uri.parse(match.matchedLocation);
              return uri.pathSegments.contains('youtube-detail') &&
                  uri.pathSegments.last == arg.contentId;
            });
          }

          YoutubeDetailRoute(arg).push(ref.context);
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

  ///
  ///contentId 값이 이전 라우트 스택에 있는지 확인
  ///
  bool _isContentIdInPreviousRoutes(BuildContext context, String contentId) {
    // GoRouter의 라우터 델리게이트를 가져옵니다.
    final goRouter = GoRouter.of(context);
    final routerDelegate = goRouter.routerDelegate;

    // 현재 라우트 스택에서 주어진 contentId가 이전 라우트에 있는지 확인
    final bool existsInStack = routerDelegate.currentConfiguration.matches
        .where((match) => match.route is GoRoute)
        .any((match) {
      final uri = Uri.parse(match.matchedLocation);
      // 주어진 contentId가 있는지 확인
      return uri.pathSegments.contains('youtube-detail') &&
          uri.pathSegments.last == contentId;
    });

    return existsInStack;
  }

  ///
  /// 시청 기록 업데이트
  ///
  Future<void> updateWatchedHistory(WidgetRef ref) async {
    final contentId = ref.read(youtubeDetailRouteArgProvider).contentId;
    final response = await userRepository.updateYoutubeWatchHistory(contentId);
    response.fold(
      onSuccess: (_) {
        logger.i('시청 기록 업데이트 성공');
      },
      onFailure: (e) {
        logger.e('시청 기록 업데이트 실패 : ${e}');
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
