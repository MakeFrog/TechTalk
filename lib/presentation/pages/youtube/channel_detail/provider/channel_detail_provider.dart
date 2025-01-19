import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/features/youtube/index.dart';
import 'package:techtalk/features/youtube/repositories/entities/channel_detail_entity.dart';

part 'channel_detail_provider.g.dart';

@riverpod
class ChannelDetail extends _$ChannelDetail {
  @override
  Future<ChannelDetailEntity> build(String channelId) async {
    final response = await youtubeRepository.getChannelDetail(channelId);
    return response.fold(
      onSuccess: (channel) => channel,
      onFailure: (e) {
        log('$this > 채널 상세 정보 호출 실패 : $e');
        throw e;
      },
    );
  }
}
