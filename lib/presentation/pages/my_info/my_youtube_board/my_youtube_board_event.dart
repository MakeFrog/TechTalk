import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/features/user/user.dart';
import 'package:techtalk/features/youtube/data_source/remote/models/youtube_main_entity.dart';
import 'package:techtalk/features/youtube/index.dart';
import 'package:techtalk/presentation/pages/my_info/my_youtube_board/provider/bookmarked_paging_controller_provider.dart';
import 'package:techtalk/presentation/pages/my_info/my_youtube_board/provider/uploaded_history_paging_controller_provider.dart';
import 'package:techtalk/presentation/pages/my_info/my_youtube_board/provider/watched_history_paging_controller_provider.dart';
import 'package:techtalk/presentation/pages/youtube/detail/providers/youtube_detail_route_arg_provider.dart';
import 'package:techtalk/presentation/providers/main_bottom_navigation_provider.dart';

mixin class MyYoutubeBoardEvent {
  ///
  /// 유튜브 상세 페이지로 이동
  ///
  void routeToDetailPage(
    WidgetRef ref, {
    required YoutubeMainEntity overview,
  }) {
    final route = YoutubeDetailRoute(
        YoutubeDetailArg.entryFromMainList(overView: overview));
    route.push(ref.context);
  }

  ///
  /// 북마크 제거
  ///
  Future<void> deleteBookmark(WidgetRef ref, {required String videoId}) async {
    final response = await userRepository.updateBookMarkState(
      contentId: videoId,
      targetState: false,
    );

    response.fold(
      onSuccess: (_) {
        final pagingController = ref.read(bookmarkedPagingControllerProvider);
        pagingController.itemList?.removeWhere((item) => item.id == videoId);

        /// 리스트만 직접 지우다가, 전부 다 지워지면
        /// pagingController 상태 자체를 바꿔야 하므로 refresh 실행
        if (pagingController.itemList?.isEmpty ?? true) {
          ref.read(bookmarkedPagingControllerProvider).refresh();
        }
      },
      onFailure: (error) {
        // 실패 처리
      },
    );
  }

  ///
  /// 영상 업로드 페이지 이동
  ///
  void goToUploadPage(WidgetRef ref) {
    //// 업로드 페이지
    const YoutubeLinkSubmitRoute().push(ref.context);
  }

  ///
  /// 유튜브 컨텐츠 메인 페이지 이동
  ///
  void goToYoutubeMainPage(WidgetRef ref) {
    //// 유튜브 메인 페이지
    // YoutubeContentsMainListRoute().push(ref.context);
    ref.context.pop();
    ref
        .read(mainBottomNavigationProvider.notifier)
        .changeTab(MainNavigationTab.youtube);
  }

  ///
  /// 북마크 리스트 새로고침
  ///
  Future<void> refreshBookmarkList(WidgetRef ref) async {
    ref.read(bookmarkedPagingControllerProvider).refresh();
  }

  ///
  /// 시청기록 리스트 새로고침
  ///
  Future<void> refreshWatchedHistoryList(WidgetRef ref) async {
    ref.read(watchedHistoryPagingControllerProvider).refresh();
  }

  ///
  /// 업로드 리스트 새로고침
  ///
  Future<void> refreshUploadList(WidgetRef ref) async {
    ref.read(uploadedHistoryPagingControllerProvider).refresh();
  }
}
