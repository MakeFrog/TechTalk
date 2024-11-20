import 'dart:async';

import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/contents/repositories/entities/youtube_contents_detail_entity.dart';
import 'package:techtalk/features/contents/repositories/youtube_contents_repository.dart';

///
/// 특정 영상 관련 컨텐츠 데이터 가져오기 - 요약, 관련 질문 등
///
final class GetYoutubeContentsDetailDataUseCase extends BaseUseCase<String, Result<YoutubeContentsDetailEntity>> {
  GetYoutubeContentsDetailDataUseCase(this._repository);

  final YoutubeContentsRepository _repository;

  @override
  Future<Result<YoutubeContentsDetailEntity>> call(String request) => _repository.getYoutubeContentsDetail(request);
}
