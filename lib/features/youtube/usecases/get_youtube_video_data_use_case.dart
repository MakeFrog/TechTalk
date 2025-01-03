import 'dart:async';

import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/youtube/index.dart';

final class GetYoutubeVideoDataUseCase
    extends BaseUseCase<String, Result<YoutubeCoreVideoEntity>> {
  GetYoutubeVideoDataUseCase(this._repository);

  final YoutubeRepository _repository;

  @override
  Future<Result<YoutubeCoreVideoEntity>> call(String request) =>
      _repository.getYoutubeVideoData(request);
}
