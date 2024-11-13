import 'dart:async';

import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/contents/repositories/contents_repository.dart';
import 'package:techtalk/features/contents/repositories/entities/youtube_video_data_entity.dart';

final class GetYoutubeVideoDataUseCase extends BaseUseCase<String, Result<YouTubeVideoDataEntity>> {
  GetYoutubeVideoDataUseCase(this._repository);

  final ContentsRepository _repository;

  @override
  Future<Result<YouTubeVideoDataEntity>> call(String request) => _repository.getYoutubeVideoData(request);
}
