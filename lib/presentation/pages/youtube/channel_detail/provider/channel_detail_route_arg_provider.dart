import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/features/youtube/repositories/entities/channel_entity.dart';

part 'channel_detail_route_arg_provider.g.dart';

@riverpod
ChannelDetailRouteArg channelDetailRouteArg(ChannelDetailRouteArgRef ref) {
  throw Exception('channelDetailRouteArg > argument를 초기화 해주어야 합니다.');
}

final class ChannelDetailRouteArg {
  final ChannelEntity channel;
  final String currentContentId;

  ChannelDetailRouteArg(
      {required this.channel, required this.currentContentId});
}
