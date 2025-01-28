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
  final YoutubeMainEntity? main;

  /// 요약 정보
  final SummaryEntity? summary;

  /// 문답 리스트
  final Set<YoutubeQnaEntity>? qnas;

  /// 썸네일
  /// [NOTE]
  /// [main] 객체는 없지만 썸네일만 있는 경우
  /// [main]을 쓰려면 필드를 null로 만들어야하는데
  /// 그러면 null지옥 상태가 되어 오히려 복잡해짐.
  final String? thumbnailUrl;

  const YoutubeDetailArg._({
    required this.main,
    required this.summary,
    required this.qnas,
    required this.contentId,
    required this.thumbnailUrl,
  });

  /// [summary] / [qnas]
  /// 메인 리스트에서 진입하는 경우 null
  factory YoutubeDetailArg.entryFromMainList(
      {required YoutubeMainEntity overView}) {
    return YoutubeDetailArg._(
      main: overView,
      summary: null,
      qnas: null,
      contentId: overView.id,
      thumbnailUrl: overView.thumbnailImgUrl,
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
      main: overView,
      summary: summary,
      qnas: qnas,
      contentId: overView.id,
      thumbnailUrl: overView.thumbnailImgUrl,
    );
  }

  ///
  /// 딥링크 또는 argument가 id밖에 없는 진입점
  ///
  factory YoutubeDetailArg.deeplinkOrHasSingleIdArg({
    required String contentId,
    required String? thumbnailImage,
  }) {
    return YoutubeDetailArg._(
      contentId: contentId,
      main: null,
      summary: null,
      qnas: null,
      thumbnailUrl: thumbnailImage,
    );
  }
}
