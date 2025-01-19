import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/features/youtube/data_source/remote/models/youtube_main_entity.dart';
import 'package:techtalk/presentation/pages/youtube/channel_detail/provider/channel_detail_route_arg_provider.dart';
import 'package:techtalk/presentation/pages/youtube/detail/providers/youtube_detail_route_arg_provider.dart';

mixin class ChannelDetailEvent {
  ///
  /// 콘텐츠 아이템이 클릭 되었을 때
  ///
  void onContentTapped(WidgetRef ref, {required YoutubeMainEntity content}) {
    final arg = ref.read(channelDetailRouteArgProvider);

    /// 현재 콘텐츠를 선택했다면 뒤로 이동
    if (arg.currentContentId == content.id) {
      ref.context.pop();
    } else {
      /// [NOTE]
      /// 채널 상세페이지에서는 채널 정보를 별도로 호출하지 않기 때문에
      /// 상세 페이지 이동 전 채널 정보를 업데이트한 argument로 포맷해야됨
      final targetContent = content.copyWith(channel: arg.channel);
      final route = YoutubeDetailRoute(
        YoutubeDetailArg.entryFromMainList(
          overView: targetContent,
        ),
      );
      ref.context.pop();
      route.pushReplacement(ref.context);
    }
  }
}
