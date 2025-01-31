// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommended_youtube_video_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$recommendedYoutubeVideoHash() =>
    r'e9db7a9facbed44c86a557e4665e5388f79146a6';

///
/// [InterviewType]이 youtube인 경우
/// 면접이 종료되고 보여지는 [InterviewIndicatorCard] 다이어로그에서
/// 관련 콘텐츠를 추천할 떄 보여지는 비디오 정보
/// 이전 화면에서 전달 받았다면 별도의 api call을 하지 않음.
///
///
/// Copied from [RecommendedYoutubeVideo].
@ProviderFor(RecommendedYoutubeVideo)
final recommendedYoutubeVideoProvider = AutoDisposeAsyncNotifierProvider<
    RecommendedYoutubeVideo, VideoOverviewEntity>.internal(
  RecommendedYoutubeVideo.new,
  name: r'recommendedYoutubeVideoProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$recommendedYoutubeVideoHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$RecommendedYoutubeVideo
    = AutoDisposeAsyncNotifier<VideoOverviewEntity>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
