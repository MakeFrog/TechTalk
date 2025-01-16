import 'package:youtube_player_iframe/youtube_player_iframe.dart';

///
/// 기존 youtube_iframe 패키지에서 제공하는 [PlayerState]에서
/// 몇가지 상태를 추가한 enum
///
/// 레퍼런스 (https://developers.google.com/youtube/iframe_api_reference#Playback_status).
///
enum YoutubePlaySate {
  /// Denotes State when player is not loaded with video.
  unknown(-2),

  /// Denotes state when player loads first video.
  unStarted(-1),

  /// Denotes state when player has ended playing a video.
  ended(0),

  /// Denotes state when player is playing video.
  playing(1),

  /// Denotes state when player is paused.
  paused(2),

  /// Denotes state when player is buffering bytes from the internet.
  buffering(3),

  /// Denotes state when player loads video and is ready to be played.
  cued(5),

  /// 에러가 발생했을 때
  errorOccured(6),

  /// 예외 경우
  unDefined(7);

  /// Returns the [YoutubePlaySate] from the given code.
  const YoutubePlaySate(this.code);

  /// Code of the player state.
  final int code;

  factory YoutubePlaySate.fromCode(int code) {
    return values.firstWhere((e) => e.code == code,
        orElse: () => YoutubePlaySate.unDefined);
  }
}
