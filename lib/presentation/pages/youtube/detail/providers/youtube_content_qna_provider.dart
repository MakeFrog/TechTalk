import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/features/chat/repositories/entities/youtube_qna_entity.dart';
import 'package:techtalk/features/contents/youtube.dart';

part 'youtube_content_qna_provider.g.dart';

@riverpod
class YoutubeContentQna extends _$YoutubeContentQna {
  @override
  FutureOr<Set<YoutubeQnaEntity>> build(String contentId) async {
    final response = await youtubeRepository.getQnas(contentId);
    return response.fold(
        onSuccess: (qnas) => qnas.toSet(),
        onFailure: (e) {
          log('유튜브 콘텐츠 qna 정보 호출 실패 : $e');
          throw e;
        });
  }
}
