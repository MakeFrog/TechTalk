import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:techtalk/features/youtube/data_source/remote/models/youtube_content_overview_model.dart';
import 'package:techtalk/features/youtube/data_source/remote/models/youtube_main_model.dart';
import 'package:techtalk/presentation/pages/youtube/channel_detail/provider/channel_contents_pagination_provider.dart';
import 'package:techtalk/presentation/pages/youtube/channel_detail/provider/channel_detail_route_arg_provider.dart';

mixin class ChannelDetailState {
  ///
  /// 페이지네이션 컨트롤러
  ///
  PagingController<DocumentSnapshot<YoutubeMainModel>?,
      YoutubeContentOverviewEntity> pagingController(WidgetRef ref) {
    final channelId = ref.read(channelDetailRouteArgProvider).id;
    final pagingController =
        ref.watch(channelContentsPaginationProvider(channelId: channelId));
    return pagingController;
  }
}
