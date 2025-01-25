import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/features/youtube/index.dart';

part 'youtube_main_info_provider.g.dart';

@riverpod
class YoutubeMainInfo extends _$YoutubeMainInfo {
  @override
  Future<YoutubeMainEntity> build(String contentId) async {
    final response =
        await youtubeRepository.getYoutubeMainInfo(contentId: contentId);

    return response.fold(
      onSuccess: (info) => info,
      onFailure: (e) {
        log('YoutubeMainInfo 호출 실패 : $e');
        throw e;
      },
    );
  }
}
