import 'dart:async';

import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/youtube/index.dart';

final class GetYoutubeVideoDataUseCase
    extends BaseUseCase<String, Result<YouTubeVideoDataEntity>> {
  GetYoutubeVideoDataUseCase(this._repository);

  final YoutubeContentsRepository _repository;

  @override
  Future<Result<YouTubeVideoDataEntity>> call(String request) =>
      _repository.getYoutubeVideoData(request);
}
