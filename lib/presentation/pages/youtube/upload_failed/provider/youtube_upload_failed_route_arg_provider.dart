import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/features/youtube/index.dart';

part 'youtube_upload_failed_route_arg_provider.g.dart';

@riverpod
YoutubeUploadFailedArg youtubeUploadFailedRouteArg(
    YoutubeUploadFailedRouteArgRef ref) {
  throw Exception('youtubeUploadFailedRouteArg : arugment를 초기화 시켜주어야 합니다');
}

final class YoutubeUploadFailedArg {
  final YoutubeUploadFailedType type;
  final String? contentId;

  YoutubeUploadFailedArg({required this.type, this.contentId});
}
