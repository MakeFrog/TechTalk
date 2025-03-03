import 'package:youtube_explode_dart/youtube_explode_dart.dart';

abstract final class AppYoutubeExplode {
  AppYoutubeExplode._internal();

  static YoutubeExplode? _instance;

  static YoutubeExplode getInstance() => _instance ??= YoutubeExplode();
}
