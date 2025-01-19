import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/features/chat/repositories/entities/youtube_qna_entity.dart';
import 'package:techtalk/features/youtube/index.dart';

part 'youtube_detail_route_arg_provider.g.dart';

@riverpod
YoutubeDetailArg youtubeDetailRouteArg(YoutubeDetailRouteArgRef ref) {
  throw Exception('youtubeDetailRouteArg : arugment를 초기화 시켜주어야 합니다');
}

final class YoutubeDetailArg {
  final String contentId;

  /// Overview 섹션에서 보여지는 데이터
  final YoutubeMainEntity? overView;

  /// 요약 정보
  final SummaryEntity? summary;

  /// 문답 리스트
  final Set<YoutubeQnaEntity>? qnas;

  const YoutubeDetailArg._({
    required this.overView,
    required this.summary,
    required this.qnas,
    required this.contentId,
  });

  /// [summary] / [qnas]
  /// 메인 리스트에서 진입하는 경우 null
  factory YoutubeDetailArg.entryFromMainList(
      {required YoutubeMainEntity overView}) {
    return YoutubeDetailArg._(
      overView: overView,
      summary: null,
      qnas: null,
      contentId: overView.id,
    );
  }

  /// [summary] / [qnas]
  /// 메인 리스트에서 진입하는 경우 NOT not
  factory YoutubeDetailArg.entryFromUpload({
    required YoutubeMainEntity overView,
    required SummaryEntity summary,
    required Set<YoutubeQnaEntity> qnas,
  }) {
    return YoutubeDetailArg._(
      overView: overView,
      summary: summary,
      qnas: qnas,
      contentId: overView.id,
    );
  }

  ///
  /// 딥링크 또는 argument가 id밖에 없는 진입점
  ///
  factory YoutubeDetailArg.deeplinkOrHasSingleIdArg({
    required String contentId,
  }) {
    return YoutubeDetailArg._(
      contentId: contentId,
      overView: null,
      summary: null,
      qnas: null,
    );
  }
}
