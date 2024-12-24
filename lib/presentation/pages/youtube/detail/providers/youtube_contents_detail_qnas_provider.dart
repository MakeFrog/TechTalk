import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/features/contents/youtube.dart';
import 'package:techtalk/features/topic/repositories/entities/qna_entity.dart';

part 'youtube_contents_detail_qnas_provider.g.dart';

@riverpod
class YoutubeContentsDetailQnas extends _$YoutubeContentsDetailQnas {
  @override
  Future<List<QnaEntity>> build(String videoId) async {
    final result = await getYoutubeContentsDetailQnasUseCase.call(videoId);
    return result.fold(
      onSuccess: (data) => data,
      onFailure: (e) {
        log(e.toString());
        throw e;
      },
    );
  }
}
