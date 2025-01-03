import 'dart:developer';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/features/contents/youtube.dart';
import 'package:techtalk/presentation/pages/youtube/detail/providers/youtube_detail_route_arg_provider.dart';

part 'youtube_summary_provider.g.dart';

@riverpod
class YoutubeSummary extends _$YoutubeSummary {
  @override
  FutureOr<SummaryEntity> build(String contentId) async {
    final response = await youtubeRepository.getYoutubeSummary(contentId);

    return response.fold(onSuccess: (e) {
      return e;
    }, onFailure: (e) {
      log('유튜브 요약 정보 호출 실패 : $e');
      throw e;
    });
  }
}
