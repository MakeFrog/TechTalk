import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/features/contents/repositories/entities/youtube_contents_detail_entity.dart';
import 'package:techtalk/features/contents/youtube.dart';

part 'youtube_contents_detail_data_provider.g.dart';

@riverpod
class YoutubeContentsDetailData extends _$YoutubeContentsDetailData {
  @override
  Future<YoutubeContentsDetailEntity> build(String videoId) async {
    final result = await getYoutubeContentsDetailDataUseCase.call(videoId);
    return result.fold(
      onSuccess: (data) => data,
      onFailure: (e) {
        log(e.toString());
        throw e;
      },
    );
  }
}
