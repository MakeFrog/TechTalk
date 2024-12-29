import 'dart:async';

import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/chat/repositories/entities/youtube_qna_entity.dart';
import 'package:techtalk/features/contents/repositories/youtube_contents_repository.dart';

///
/// 특정 영상의 관련 질문 리스트 가져오기
///
final class GetYoutubeContentsDetailQnasUseCase
    extends BaseUseCase<String, Result<List<YoutubeQnaEntity>>> {
  GetYoutubeContentsDetailQnasUseCase(this._repository);

  final YoutubeContentsRepository _repository;

  @override
  Future<Result<List<YoutubeQnaEntity>>> call(String request) =>
      _repository.getYoutubeContentsDetailQnas(request);
}
