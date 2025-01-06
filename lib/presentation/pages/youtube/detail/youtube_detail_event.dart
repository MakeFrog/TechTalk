import 'dart:developer';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/user/repositories/entities/user_entity.dart';
import 'package:techtalk/features/youtube/index.dart';
import 'package:techtalk/presentation/pages/youtube/detail/providers/is_bookmark_checked_provider.dart';
import 'package:techtalk/presentation/pages/youtube/detail/providers/youtube_detail_ressource_provider.dart';
import 'package:techtalk/presentation/pages/youtube/detail/providers/youtube_detail_route_arg_provider.dart';
import 'package:techtalk/presentation/pages/youtube/detail/widgets/constants/contents_detail_tab_type.enum.dart';

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
    final videoId = ref.read(youtubeDetailRouteArgProvider).contentId;
    final response = await youtubeRepository.getRelatedVideo(videoId);
  }

  tabChanged(ContentsDetailTabType tabType) {}

  onTapAuthorProfile(ChannelEntity author) {}

  onTapUploaderProfile(UserEntity uploader) {}
}
