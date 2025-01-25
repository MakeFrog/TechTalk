import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:techtalk/features/youtube/index.dart';
import 'package:techtalk/features/youtube/repositories/entities/channel_detail_entity.dart';
import 'package:techtalk/presentation/pages/youtube/channel_detail/provider/channel_contents_pagination_provider.dart';
import 'package:techtalk/presentation/pages/youtube/channel_detail/provider/channel_detail_provider.dart';
import 'package:techtalk/presentation/pages/youtube/channel_detail/provider/channel_detail_route_arg_provider.dart';

mixin class ChannelDetailState {
  ///
  /// 페이지네이션 컨트롤러
  ///
  PagingController<DocumentSnapshot<YoutubeMainModel>?, YoutubeMainEntity>
      pagingController(WidgetRef ref) {
    final channelId = ref.read(channelDetailRouteArgProvider).channel.id;
    final pagingController =
        ref.watch(channelContentsPaginationProvider(channelId: channelId));
    return pagingController;
  }

  ///
  /// 채널 정보
  ///
  ChannelEntity channel(WidgetRef ref) =>
      ref.read(channelDetailRouteArgProvider).channel;

  ///
  /// 채널 상세 정보
  ///
  @Deprecated('현재 YoutubeExplore 엔드포인트가 안맞아서 상세 정보를 못불러오고 있음')
  AsyncValue<ChannelDetailEntity> channelDetail(WidgetRef ref) {
    final channelId = ref.read(channelDetailRouteArgProvider).channel.id;
    return ref.watch(channelDetailProvider(channelId));
  }
}
