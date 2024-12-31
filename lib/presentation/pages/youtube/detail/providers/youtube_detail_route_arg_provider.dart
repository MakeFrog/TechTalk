import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/features/chat/repositories/entities/youtube_qna_entity.dart';
import 'package:techtalk/features/contents/data_source/remote/models/youtube_content_overview_model.dart';
import 'package:techtalk/features/contents/repositories/entities/summary_entity.dart';

part 'youtube_detail_route_arg_provider.g.dart';

@riverpod
YoutubeDetailArg youtubeDetailRouteArg(YoutubeDetailRouteArgRef ref) {
  throw Exception('youtubeDetailRouteArg : arugment를 초기화 시켜주어야 합니다');
}

final class YoutubeDetailArg {
  /// Overview 섹션에서 보여지는 데이터
  final YoutubeContentOverviewEntity overView;

  /// 요약 정보
  final SummaryEntity? summary;

  /// 문답 리스트
  final Set<YoutubeQnaEntity>? qnas;

  const YoutubeDetailArg._(
      {required this.overView, required this.summary, required this.qnas});

  /// [summary] / [qnas]
  /// 메인 리스트에서 진입하는 경우 null
  factory YoutubeDetailArg.entryFromMainList(
      {required YoutubeContentOverviewEntity overView}) {
    return YoutubeDetailArg._(
      overView: overView,
      summary: null,
      qnas: null,
    );
  }

  /// [summary] / [qnas]
  /// 메인 리스트에서 진입하는 경우 NOT not
  factory YoutubeDetailArg.entryFromUpload({
    required YoutubeContentOverviewEntity overView,
    required SummaryEntity summary,
    required Set<YoutubeQnaEntity> qnas,
  }) {
    return YoutubeDetailArg._(
      overView: overView,
      summary: summary,
      qnas: qnas,
    );
  }
}
